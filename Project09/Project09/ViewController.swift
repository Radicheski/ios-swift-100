//
//  ViewController.swift
//  Project09
//
//  Created by Erik Radicheski da Silva on 04/06/22.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        let leftBerButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filter))
        navigationItem.leftBarButtonItem = leftBerButton

        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showInfo))
        navigationItem.rightBarButtonItem = rightBarButton

        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    self.filteredPetitions = self.petitions
                    return
                }
            }

            self.showError()
        }

    }

    @objc func showInfo() {
        let alertController = UIAlertController(title: "Credit", message: "Data is provided by We The People API of the Whitehouse", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)

        present(alertController, animated: true)
    }

    @objc func filter() {
        let alertController = UIAlertController(title: "Filter", message: "Enter a term to filter", preferredStyle: .alert)
        alertController.addTextField()

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak alertController] _ in
            if let text = alertController?.textFields?[0].text {
                if text.isEmpty {
                    guard let petitions = self?.petitions else { return }
                    self?.filteredPetitions = petitions
                } else if let filter = self?.petitions.filter({ $0.title.contains(text) || $0.body.contains(text) }) {
                    self?.filteredPetitions = filter
                }
                self?.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)

    }



    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func showError() {
        let alertController = UIAlertController(title: "Error", message: "There was a problem loading the feed. Please check yout connection and try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let petition = petitions[indexPath.row]

        var contetConfiguration = cell.defaultContentConfiguration()
        contetConfiguration.text = petition.title
        contetConfiguration.secondaryText = petition.body
        cell.contentConfiguration = contetConfiguration

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailViewController()
        detailController.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }

}

