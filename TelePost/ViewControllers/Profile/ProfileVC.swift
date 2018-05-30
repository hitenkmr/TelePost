//
//  ProfileVC.swift
//  TelePost
//
//  Created by Hitender kumar on 01/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {
    
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var userImageView : UIImageView!
    @IBOutlet weak var userBioLabel : UILabel!
    
    var logoutBtn = UIButton()
    
    override func viewDidLoad() {
        self.userNameLabel.text = ""
        self.userBioLabel.text = ""
        super.viewDidLoad()
        if let username = UserDefaults.standard.object(forKey: UserDataSaveConstants.st_userName_save) as? String {
            self.navigationItem.title = "User Profile"
            self.getUserProfileWith(username: username)
        }
        
    logoutBtn.setAttributedTitle(AppDelegate.attrubutedTextWithAttributes(CustomFonts.Montserrat.bold, fontSize: 13, textColor: BlackColor, originalString: "LOGOUT"), for: .normal)
        
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
    
    func updateuserDetailsWith(user : SteemitUser) {
        if let userProfile = user.profile {
            self.userImageView.sd_setImage(with: URL.init(string: (userProfile.cover_image)), placeholderImage: #imageLiteral(resourceName: "user_missing"), options: .retryFailed, completed: nil)
            self.userNameLabel.text = userProfile.name
            self.userBioLabel.text = userProfile.about
        }
       
    }
    
    //MARK : WEB SERVICES
    
    func getUserProfileWith(username : String) {
        self.startAnimator()
        APIMaster.getUserSteemitProfile(user_name: username, completion: { (anyObject, httpResponse) in
            DispatchQueue.main.async(execute: {
                self.stopAnimator()
            })
            if let jsonObj = anyObject as? [String : Any] {
                if let status = jsonObj["status"] as? String {
                    if status == "200" {
                        if let userInfo = jsonObj["user"] as? [String : Any] {
                            let userModel = SteemitUser.init(info: userInfo)
                            DispatchQueue.main.async(execute: {
                                self.updateuserDetailsWith(user: userModel)
                            })
                        }
                    } else {
                        DispatchQueue.main.async(execute: {
                            self.showAlertWith(title: "Error", message: Messages.InternalServerError)
                        })
                    }
                }
            }
        }) { (error) in
            DispatchQueue.main.async(execute: {
                self.stopAnimator()
                self.showAlertWith(title: "Error", message: error.localizedDescription)
            })
        }
    }
}
