//
//  TPAppDelegate.swift
//  TelePost
//
//  Created by Hitender kumar on 16/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

@UIApplicationMain
class TPAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var objTPTabBarController : UITabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let _ = UserDefaults.standard.value(forKey: UserDataSaveConstants.st_access_token_save) as? String {
            if let token_expire_interval = UserDefaults.standard.value(forKey: UserDataSaveConstants.st_expires_in_save) as? String {
                if let token_expire_interval_intVal = Int(token_expire_interval) {
                    let date_with_token_expire_interval = Date.init(timeIntervalSinceNow: TimeInterval(token_expire_interval_intVal))
                    let todayDate = Date()
                    if todayDate < date_with_token_expire_interval {
                        self.navigateUserToTabBarController()
                    }
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func formattedDateStringWith(dateStr : String, currentDateFormat : String, requiredDateFormat : String) -> String {
        var requiredDateStr = ""
        //let components = dateStr.components(separatedBy: ".")
        // let actualDateStr = components[0] + "Z"
        let actualDateStr = dateStr
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = currentDateFormat
        if let date = dateFormatter.date(from: actualDateStr) {
            let requiredDateFormatter = DateFormatter()
            requiredDateFormatter.locale = tempLocale
            requiredDateFormatter.dateFormat = requiredDateFormat
            requiredDateStr = requiredDateFormatter.string(from: date)
        }
        return requiredDateStr
    }
    
    func attrubutedTextWithAttributes(_ fontName : String, fontSize : CGFloat, textColor : UIColor, originalString : String) -> NSMutableAttributedString {
        
        let attributedStr = NSMutableAttributedString.init(string: originalString)
        
        attributedStr.addAttributes([NSAttributedStringKey.foregroundColor : textColor, NSAttributedStringKey.font : UIFont.init(name: fontName, size: fontSize) as Any], range: NSRange.init(location: 0, length: attributedStr.length))
        
        return attributedStr
    }
    
    func navigateUserToTabBarController()  {
        
        //Courses
        let objTopHeadlinesVC : TopHeadlinesVC = TopHeadlinesVC.instantiateWithStoryboard(appStoryboard: AppStoryboard.SB_News) as! TopHeadlinesVC
        
        let newsNavController : UINavigationController = UINavigationController.init(rootViewController: objTopHeadlinesVC)
       // newsNavController.isNavigationBarHidden = true
        let newsItem : UITabBarItem = UITabBarItem.init(title: "News", image: TabbarIcon.tabbarIcon_news.image().withRenderingMode(.alwaysTemplate), tag: 11111)
        newsItem.selectedImage = TabbarIcon.tabbarIcon_news.image(selected: true).withRenderingMode(.alwaysTemplate)
        
        newsItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: 0)
        
        if #available(iOS 10.0, *) {
            newsItem.badgeColor = BlackColor
        } else {
            // Fallback on earlier versions
        }
        
        // playlistsItem.selectedImage = Icon.playlist.image(selected: true)
        objTopHeadlinesVC.tabBarItem = newsItem
        
        //Progress
        
        let profileItem : UITabBarItem = UITabBarItem.init(title: "Profile", image: TabbarIcon.tabbarIcon_profile.image().withRenderingMode(.alwaysTemplate), tag: 22222)
        profileItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: 0)
        profileItem.selectedImage = TabbarIcon.tabbarIcon_profile_selected.image(selected: true).withRenderingMode(.alwaysTemplate)
        
        if #available(iOS 10.0, *) {
            profileItem.badgeColor = BlackColor
        } else {
            // Fallback on earlier versions
        }
        
        let objProfileVC: ProfileVC = ProfileVC.instantiateWithStoryboard(appStoryboard: AppStoryboard.SB_Profile) as! ProfileVC
        objProfileVC.tabBarItem = profileItem
        
        let profileNavController = UINavigationController.init(rootViewController: objProfileVC)
        //profileNavController.isNavigationBarHidden = true
         
        objTPTabBarController  = UITabBarController.init()
        //objHwNwTabBarController?.delegate = self as! UITabBarControllerDelegate
        // objSMTabBarController?.tabBar.delegate = self as UITabBarDelegate
        objTPTabBarController?.tabBar.barTintColor = WhiteColor
        objTPTabBarController?.tabBar.selectedImageTintColor = ColorTheme
        if #available(iOS 10.0, *) {
            objTPTabBarController?.tabBar.unselectedItemTintColor = BlackColor
        } else {
            // Fallback on earlier versions
        }
        
        //UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: WhiteColor], for:.normal)
        // UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: GreenColor], for:.selected)
        
        let paragraphStyle = NSMutableParagraphStyle()
        // *** set LineSpacing property in points ***
        paragraphStyle.minimumLineHeight = 1.0 // Whatever line spacing you want in points
        let attributes = [NSAttributedStringKey.kern : CGFloat(0.7), NSAttributedStringKey.foregroundColor : BlackColor, NSAttributedStringKey.paragraphStyle : paragraphStyle, NSAttributedStringKey.underlineStyle : 0 ,NSAttributedStringKey.font : UIFont.init(name: CustomFonts.Montserrat.regular, size: IsPad ? 14 : 12) as Any]
        
        let selectedAttributes = [NSAttributedStringKey.kern : CGFloat(0.7), NSAttributedStringKey.foregroundColor : ColorTheme, NSAttributedStringKey.paragraphStyle : paragraphStyle, NSAttributedStringKey.underlineStyle : 0 ,NSAttributedStringKey.font : UIFont.init(name: CustomFonts.Montserrat.regular, size: IsPad ? 14 : 12) as Any]

        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        //UITabBar.appearance().tintColor = ColorTheme
        
        objTPTabBarController?.viewControllers = [newsNavController, profileNavController]
        objTPTabBarController?.selectedIndex = 0
        
        // self.addwhiteSpaceBetweenTabbars()
        
        //        let xPosition =  (self.objSMTabBarController?.view.frame.size.width)! / CGFloat((objSMTabBarController?.viewControllers?.count)!)
        //
        //        objSMTabBarController?.tabBar.insertSubview(self.viewUnderSelectedTabbarItem(xPosition: xPosition), at: 1)
        //
        self.objTPTabBarController?.delegate?.tabBarController!(self.objTPTabBarController!, didSelect: (objTPTabBarController?.viewControllers?[1])!)
        
        objTPTabBarController?.tabBar.itemSpacing = 5.0
        self.window?.rootViewController = objTPTabBarController
        self.window?.makeKeyAndVisible()
        
    }

}


