//
//  ProfileVC.swift
//  TelePost
//
//  Created by Hitender kumar on 01/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var userImageView : UIImageView!
    
    var logoutBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = UserDefaults.standard.object(forKey: UserDataSaveConstants.st_userName_save) as? String {
            self.userNameLabel.text = username
            self.navigationItem.title = "User Profile"
        }
        
        logoutBtn.setTitle("Logout", for: .normal)
        logoutBtn.setTitleColor(UIColor.black, for: .normal)
        logoutBtn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        logoutBtn.addTarget(self, action: #selector(self.logoutBtnAction(_:)), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: logoutBtn), animated: true);
    }
    
    // MARK: - Interface builder actions
    
    @objc func logoutBtnAction(_ sender : UIButton) {
        UserDefaults.standard.removeObject(forKey: UserDataSaveConstants.st_access_token_save)
        UserDefaults.standard.removeObject(forKey: UserDataSaveConstants.st_userName_save)
        UserDefaults.standard.removeObject(forKey: UserDataSaveConstants.st_expires_in_save)
        UserDefaults.standard.synchronize()
        let mainVc : MainVC = MainVC.instantiateWithStoryboard(appStoryboard: .SB_Main) as! MainVC
         AppDelegate.window?.rootViewController = mainVc
    }
}
