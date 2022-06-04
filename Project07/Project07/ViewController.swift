//
//  ViewController.swift
//  Project07
//
//  Created by Erik Radicheski da Silva on 04/06/22.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    func showError() {
        let alertController = UIAlertController(title: "Error", message: "There was a problem loading the feed. Please check yout connection and try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
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
        detailController.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }

}

