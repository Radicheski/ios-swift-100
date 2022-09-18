//
//  ActionViewController.swift
//  Extension
//
//  Created by Erik Radicheski da Silva on 18/09/22.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let inputIrem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvide = inputIrem.attachments?.first {
                itemProvide.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    // do stuff
                }
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
