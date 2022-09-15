//
//  MainViewController.swift
//  Consolidation06
//
//  Created by Erik Radicheski da Silva on 15/09/22.
//

import UIKit

class MainViewController: UITableViewController {
    
    var countryList: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Countries"
        
        DispatchQueue.global().async {
            if let url = URL(string: "https://restcountries.com/v2/all?fields=name,capital,area,population,currencies"),
               let data = try? Data(contentsOf: url),
               let list = try? JSONDecoder().decode([Country].self, from: data){
                self.countryList = list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = countryList[indexPath.row].name
        cell.contentConfiguration = contentConfiguration
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countryList[indexPath.row]
        performSegue(withIdentifier: "ShowDetail", sender: country)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewController else { return }
        guard let country = sender as? Country else { return }
        
        destination.country = country
    }

}
