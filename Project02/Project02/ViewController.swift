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

    let countries = ["estonia", "france", "germany", "ireland", "italy", "monaco",
                     "nigeria", "poland", "russia", "spain", "uk", "us"]

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

    func askQuestion() {
        let buttons = [button1, button2, button3]
        var number = [Int]()

        while number.count < 3 {
            let random = Int.random(in: 0 ..< 3)
            if number.contains(random) {
                continue
            } else {
                number.append(random)
            }
        }

        for (index, button) in buttons.enumerated() {
            button?.setImage(UIImage(named: countries[index]), for: .normal)
        }

    }

}
