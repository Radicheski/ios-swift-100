//
//  ViewController.swift
//  Consolidation03
//
//  Created by Erik Radicheski da Silva on 04/06/22.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItemName))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
        navigationItem.rightBarButtonItems = [addButton, shareButton]

        let clearButton = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearList))
        navigationItem.leftBarButtonItem = clearButton
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }

    @objc func promptForItemName() {
        let alertController = UIAlertController(title: "New item", message: "Enter name:", preferredStyle: .alert)

        alertController.addTextField()

        let okButton = UIAlertAction(title: "OK", style: .default) { [weak self, weak alertController] _ in
            if let item = alertController?.textFields?[0].text, !item.isEmpty {
                self?.shoppingList.insert(item, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        alertController.addAction(okButton)

        present(alertController, animated: true)
    }

    @objc func shareAction() {
        let items = shoppingList.joined(separator: "\n")
        let activityController = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        present(activityController, animated: true)
    }

    @objc func clearList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)

        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = shoppingList[indexPath.row]
        cell.contentConfiguration = contentConfiguration

        return cell
    }

}
