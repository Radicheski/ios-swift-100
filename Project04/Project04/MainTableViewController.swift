//
//  MainTableViewController.swift
//  Project04
//
//  Created by Erik Radicheski da Silva on 31/05/22.
//

import UIKit

class MainTableViewController: UITableViewController {

    var websites = ["apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "Websites"

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)

        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = websites[indexPath.row]
        cell.contentConfiguration = contentConfiguration

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let website = websites[indexPath.row]
        guard let websiteViewController = storyboard?.instantiateViewController(withIdentifier: "Webview") as? WebsiteViewController else { return }

        websiteViewController.website = website
        navigationController?.pushViewController(websiteViewController, animated: true)
    }

}
