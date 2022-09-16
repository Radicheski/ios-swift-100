//
//  DetailViewController.swift
//  Project16
//
//  Created by Erik Radicheski da Silva on 16/09/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var capital: Capital!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = capital.title
        webView.load(URLRequest(url: capital.url))
    }

}
