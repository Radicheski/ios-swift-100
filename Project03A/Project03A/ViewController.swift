//
//  ViewController.swift
//  Project03A
//
//  Created by Erik Radicheski da Silva on 30/05/22.
//

import UIKit

class ViewController: UITableViewController {

    private var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true

        if let path = Bundle.main.url(forResource: "countries", withExtension: "json"),
           let countries = try? JSONDecoder().decode([Country].self, from: Data(contentsOf: path)){
            self.countries = countries
        }
    }

    override func didReceiveMemoryWarning() {
        ImageWorker.shared.clearCache()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let country = countries[indexPath.row]

        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = country.name
        contentConfiguration.image = UIImage(systemName: "arrow.counterclockwise.icloud.fill")

        ImageWorker.shared.loadImage(for: country, scale: 10) { image in
            contentConfiguration.image = image
            DispatchQueue.main.async {
                cell.contentConfiguration = contentConfiguration
            }
        }
        cell.contentConfiguration = contentConfiguration

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.country = countries[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

}
