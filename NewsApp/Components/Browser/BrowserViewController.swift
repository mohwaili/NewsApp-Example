//
//  BrowserViewController.swift
//  NewsApp
//
//  Created by Mohammed Al Waili on 26/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class BrowserViewController: UIViewController {
    
    private var webView: WKWebView!
    private var url: URL?
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "close",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(closeButtonTapped(_:)))
        
        guard let url = url else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func load(with url: URL) {
        self.url = url
    }
    
    @objc private func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}
