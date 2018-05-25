//
//  LoginVC.swift
//  TelePost
//
//  Created by Hitender kumar on 01/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit
import WebKit

protocol WKDelegateController:WKScriptMessageHandler {
    
}

class LoginVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var cancelBtn: UIButton!

    deinit {
        self.removeWKWebViewCookies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = localizedString(key: "Login", comment: "")
        self.setUpWebView()
        self.setUpCloseItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Interface Builder Actions
    
    @IBAction func cancelBtnAction(_ sender : UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Helpers
    
    func setUpWebView() {
        //配置环境
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        configuration.userContentController = userContentController
        webView?.load(URLRequest.init(url: URL.init(string: get_login_url)!))
        webView?.uiDelegate = self;
        webView?.navigationDelegate = self
     }
    
    func setUpCloseItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "login_close"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(navigateUserInsideApp))
    }
    
    //MARK: - WKNavigationDelegate
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
   
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
   
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
  
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("RequestUrl ========"+(navigationAction.request.url?.absoluteString)!)
        
        decisionHandler(WKNavigationActionPolicy.allow)
        //        decisionHandler(WKNavigationActionPolicy.cancel)
    }
   
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("ResponseUrl ========"+(navigationResponse.response.url?.absoluteString)!)
        
       
        if (navigationResponse.response.url?.absoluteString.contains("access_token"))! {
            DataManager.sharedInstance.saveUserInfo(fromStr: (navigationResponse.response.url?.absoluteString)!)
            decisionHandler(WKNavigationResponsePolicy.cancel);
            self.navigateUserInsideApp()
        }else{
            
            decisionHandler(WKNavigationResponsePolicy.allow);
        }
    }
    
    @IBAction func loginViaSteemConnectPressed(_ sender: Any) {
        
    }
    
    //MARK: - ItemOnClick
    @objc func navigateUserInsideApp() {
       AppDelegate.navigateUserToTabBarController()
     }
    
    //cookie
    func removeWKWebViewCookies(){
        
        //iOS9.0
        if #available(iOS 9.0, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), completionHandler: { (records) in
                for record in records{
                    //cookie
                    //                    if record.displayName.contains("steemconnect.com"){//cookie
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                        //
                        print("清除成功\(record)")
                    })
                    //                    }
                }
            })
        } else {
            //ios8.0
            let libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let cookiesPath = libraryPath! + "/Cookies"
            try!FileManager.default.removeItem(atPath: cookiesPath)
        }
    }
}
