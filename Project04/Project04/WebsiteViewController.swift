//
//  ViewController.swift
//  Project04
//
//  Created by Erik Radicheski da Silva on 31/05/22.
//

import UIKit
import WebKit

class WebsiteViewController: UIViewController {
    var webView: WKWebView!
    var progressView: UIProgressView!

    var website: String?

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        progressView = UIProgressView(progressViewStyle: .default)

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: webView, action: #selector(webView.goBack))
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 20
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.right"), style: .plain, target: webView, action: #selector(webView.goForward))
        let progressBarButton = UIBarButtonItem(customView: progressView)
        progressView.sizeToFit()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [backButton, fixedSpace, forwardButton, fixedSpace, progressBarButton, spacer, refresh]
        navigationController?.isToolbarHidden = false

        if let website = website,
           let url = URL(string: "https://\(website)") {
            load(url: url)
        }
        webView.allowsBackForwardNavigationGestures = true
    }

    func load(url: URL) {
        webView.load(URLRequest(url: url))
        title = "Loading..."
    }

    func openPage(_ action: UIAlertAction) {
        if let website = action.title,
           let url = URL(string: "http://\(website)") {
            load(url: url)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.isHidden = false
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }

}

extension WebsiteViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        progressView.progress = 0
        progressView.isHidden = true
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host,
           let website = website {
            if host.hasSuffix(website) {
                decisionHandler(.allow)
                return
            }

            let alertController = UIAlertController(title: "Warning", message: "This site is not allowed", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alertController, animated: true)

        }

        decisionHandler(.cancel)

    }

}
