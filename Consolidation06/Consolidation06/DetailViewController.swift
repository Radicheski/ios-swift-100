//
//  DetailViewController.swift
//  Consolidation06
//
//  Created by Erik Radicheski da Silva on 15/09/22.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var country: Country! {
        didSet {
            title = country.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell
            else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0: cell.detail = ("Name", country.name)
        case 1: cell.detail = ("Capital", country.capital ?? "")
        case 2: cell.detail = ("Size (km²)", country.area ?? "")
        case 3: cell.detail = ("Population", country.population)
        default: cell.detail = ("Currency", country.currencies?[0].name ?? "")
        }
        
        return cell
    }

}
