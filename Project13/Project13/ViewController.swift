//
//  ViewController.swift
//  Project13
//
//  Created by Erik Radicheski da Silva on 13/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var intensity: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Instafilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    @IBAction func changeFilter(_ sender: UIButton) {
    }
    
    @IBAction func intensityChange(_ sender: UISlider) {
    }
    
    @IBAction func save(_ sender: UIButton) {
    }
    
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
    }
    
}
