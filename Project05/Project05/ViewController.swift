//
//  ViewController.swift
//  Project05
//
//  Created by Erik Radicheski da Silva on 01/06/22.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let file = Bundle.main.path(forResource: "start", ofType: "txt"),
           let fileContent = try? String(contentsOfFile: file){
            allWords = fileContent.components(separatedBy: "\n")
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

        startGame()
    }

    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    @objc func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alertController.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            if let answer = alertController?.textFields?[0].text {
                self?.submit(answer)
            }
        }

        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }

    func submit(_ answer: String) {
        print(answer)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)

        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = usedWords[indexPath.row]
        cell.contentConfiguration = contentConfiguration

        return cell
    }

}
