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
            .sorted(by: <)
            .forEach { pictures.append($0) }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

        var conf = cell.defaultContentConfiguration()
        let text = pictures[indexPath.row]
        conf.attributedText = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 20)])
        cell.contentConfiguration = conf

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.image = pictures[indexPath.row]
            vc.label = (indexPath.row + 1, pictures.count)

            navigationController?.pushViewController(vc, animated: true)
        }
     }

}
