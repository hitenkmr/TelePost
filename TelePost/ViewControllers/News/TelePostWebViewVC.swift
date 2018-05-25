//
//  TelePostWebViewVC.swift
//  TelePost
//
//  Created by Hitender kumar on 17/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit
import WebKit

class TelePostWebViewVC: UIViewController {

    @IBOutlet weak var cancelBtn : UIButton!
    @IBOutlet weak var activityIndicatorView : UIActivityIndicatorView!
    @IBOutlet weak var webView : WKWebView!
    @IBOutlet weak var titleLabel : UILabel!

    var url : URL?
    var titleText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.titleText
        self.webView.navigationDelegate = self
        if let url = self.url {
            self.webView.load(URLRequest.init(url: url))
        }
    }

    //MARK: Interface Builder actions
    
    @IBAction func cancelBtnAction(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TelePostWebViewVC : WKNavigationDelegate {
    
    //MARK: WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicatorView.stopAnimating()
    }
}
