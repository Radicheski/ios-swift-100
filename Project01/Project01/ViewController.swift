//
//  ViewController.swift
//  Project01
//
//  Created by Erik Radicheski da Silva on 28/05/22.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        let fileManagegr = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManagegr.contentsOfDirectory(atPath: path)

        items.filter { $0.hasPrefix("nssl") }
            .forEach { pictures.append($0) }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

        var conf = cell.defaultContentConfiguration()
        conf.text = pictures[indexPath.row]
        cell.contentConfiguration = conf

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.image = pictures[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
        }
     }

}
