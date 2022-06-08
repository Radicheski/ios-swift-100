//
//  DetailViewController.swift
//  Project09a
//
//  Created by Erik Radicheski da Silva on 28/05/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var image: String?
    var label: (selected: Int, total: Int)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let label = label {
            title = "Picture \(label.selected) of \(label.total)"
        } else {
            title = image
        }
        navigationItem.largeTitleDisplayMode = .never

        if let image = image {
            self.imageView.image = UIImage(named: image)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
