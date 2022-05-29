//
//  ViewController.swift
//  Project02
//
//  Created by Erik Radicheski da Silva on 29/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco",
                     "nigeria", "poland", "russia", "spain", "uk", "us"]
    var correctAnswer = 0
    var questionsAsked = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.layer.backgroundColor = UIColor.systemGray5.cgColor

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        if questionsAsked == 10 {
            let alert = UIAlertController(title: nil, message: "Your final score is \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

            score = 0
            questionsAsked = 0

            present(alert, animated: true)

            return
        }

        let buttons = [button1, button2, button3]

        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        for (index, button) in buttons.enumerated() {
            button?.setImage(UIImage(named: countries[index]), for: .normal)
        }

        title = countries[correctAnswer].uppercased()
        title? += " (SCORE: \(score))"

    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
        } else {
            title = "Wrong"
            score -= 1
            message = "That's the flag of \(countries[sender.tag].uppercased())"
            message += "\nYour score is \(score)"
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(alert, animated: true)

        questionsAsked += 1
    }

}
