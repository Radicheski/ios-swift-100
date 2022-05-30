//
//  DetailViewController.swift
//  Project03A
//
//  Created by Erik Radicheski da Silva on 30/05/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    var country: Country?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = shareButton
        shareButton.isEnabled = country != nil
        if let country = country {
            title = country.name
            ImageWorker.shared.loadImage(for: country) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }

    }

    @objc func shareTapped() {
        guard let country = country else { return }
        guard let image = imageView.image else { return }

        let activityViewController = UIActivityViewController(activityItems: [country.name, image], applicationActivities: [])
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityViewController, animated: true)
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
