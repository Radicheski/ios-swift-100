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
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let buttons = [button1, button2, button3]
        buttons.forEach { button in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
        }

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        let buttons = [button1, button2, button3]

        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        for (index, button) in buttons.enumerated() {
            button?.setImage(UIImage(named: countries[index]), for: .normal)
        }

        title = countries[correctAnswer].uppercased()

    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        let alert = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(alert, animated: true)
    }

}
