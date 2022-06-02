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
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "New game", style: .plain, target: self, action: #selector(startGame))
        startGame()
    }

    @objc func startGame() {
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
        let answer = answer.lowercased()

        if isPossible(word: answer) {
            if isOriginal(word: answer) {
                if  isReal(word: answer) {
                    usedWords.insert(answer, at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)

                    return
                } else {
                    showErrorMessage(title: "Word not recognised", message: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(title: "Word used already", message: "Be more original!")
            }
        } else {
            guard let title = title?.lowercased() else { return }

            showErrorMessage(title: "Word not possible", message: "You can't spell that word from \(title)")
        }


    }


    func isPossible(word: String) -> Bool {
        guard var answer = title?.lowercased() else { return false }

        for letter in word {
            if let index = answer.firstIndex(of: letter) {
                answer.remove(at: index)
            } else {
                return false
            }
        }

        return true
    }

    func isOriginal(word: String) -> Bool {
        if word.lowercased() == title?.lowercased() {
            return false
        }
        return !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {
        if word.count < 3 { return false }

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return mispelledRange.location == NSNotFound
    }

    func showErrorMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        present(alertController, animated: true)
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
