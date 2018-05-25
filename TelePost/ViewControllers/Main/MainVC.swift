//
//  MainVC.swift
//  TelePost
//
//  Created by Hitender kumar on 01/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//


import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "showLoginVC", sender: self)
    }
}
