//
//  ViewController.swift
//  Consolidation04
//
//  Created by Erik Radicheski da Silva on 11/06/22.
//

import UIKit

class ViewController: UIViewController {

    var words = [String]()

    var chosenWord: String?

    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var guessInput: UITextField!

    @IBOutlet weak var usedWordsLabel: UILabel!

    var lives = 7 {
        didSet {
            title = "Lives left: \(lives)"
        }
    }

    var rightGuesses = Set<Character>() {
        didSet {
            showUsedLetters()
        }
    }
    var wrongGuesses = Set<Character>() {
        didSet {
            showUsedLetters()
        }
    }

    func showUsedLetters() {
        let letters = rightGuesses.union(wrongGuesses).sorted()
        usedWordsLabel.text = String(letters)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        usedWordsLabel.text = nil
        guessInput.delegate = self

        DispatchQueue.global().async { [weak self] in
             if let path = Bundle.main.path(forResource: "words_alpha", ofType: "txt"),
               var content = try? String(contentsOfFile: path) {
                 content = content.lowercased()
                 content = content.replacingOccurrences(of: "\r", with: "")
                 self?.words = content.components(separatedBy: "\n")

                 DispatchQueue.main.async {
                     self?.newLevel()
                 }
            }
        }

        let newGameButton = UIBarButtonItem(title: "New game", style: .plain, target: self, action: #selector(newLevel))
        navigationItem.rightBarButtonItem = newGameButton

    }

    @objc func newLevel() {
        if let word = words.randomElement() {
            lives = 7
            rightGuesses.removeAll(keepingCapacity: true)
            wrongGuesses.removeAll(keepingCapacity: true)
            chosenWord = word
            guessLabel.text = String(repeating: " _ ", count: word.count)
            guessLabel.isHidden = false
        }
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.newLevel()
        })
        present(alertController, animated: true)
    }

}

extension ViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldString = textField.text ?? ""
        guard let stringRange = Range(range, in: oldString) else { return false }

        let newString = oldString.replacingCharacters(in: stringRange, with: string)

        return newString.count <= 1
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guessLeter(textField.text)
        textField.text = nil
        textField.resignFirstResponder()

        return true
    }

    func guessLeter(_ letter: String?) {
        guard let letter = letter?.lowercased().first else { return }
        guard let chosenWord = chosenWord?.lowercased() else { return }

        var newLabelText = ""
        if chosenWord.contains(letter) {
            rightGuesses.insert(letter)
            for character in chosenWord {
                if rightGuesses.contains(character) {
                    newLabelText += String(character)
                } else {
                    newLabelText += " _ "
                }
            }
            guessLabel.text = newLabelText
            if !newLabelText.contains("_") {
                let title = "Congratulations!"
                let message = "You guessed right"
                self.showAlert(title: title, message: message)
            }
        } else {
            wrongGuesses.insert(letter)
            lives -= 1
            if lives <= 0 {
                let title = "Too bad"
                let message = "The word was \(chosenWord)"
                self.showAlert(title: title, message: message)
            }
        }
    }

}
