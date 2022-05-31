//
//  ViewController.swift
//  Project04
//
//  Created by Erik Radicheski da Silva on 31/05/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let rightBarButton = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        navigationItem.rightBarButtonItem = rightBarButton

        let url = URL(string: "https://www.hackingwithswift.com/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped() {
        let alertController = UIAlertController(title: "Open...", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        alertController.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(alertController, animated: true)
    }

    func openPage(_ action: UIAlertAction) {
        if let website = action.title,
           let url = URL(string: "http://\(website)") {
            webView.load(URLRequest(url: url))
            title = "Loading..."
        }
    }

}

extension ViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}
