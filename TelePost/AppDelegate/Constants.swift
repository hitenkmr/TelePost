//
//  AppDelegate.swift
//  TelePost
//
//  Created by Hitender kumar on 16/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import Foundation
import UIKit

//MARK: Singletons

let APIMaster                    = API.sharedInstance
let NotificationCntr             = NotificationCenter.default
let Calendar                     =  NSCalendar.current
let MainBundle                   =  Bundle.main
let Application                  = UIApplication.shared
let AppDelegate                  = Application.delegate as! TPAppDelegate
 
//MARK: DEVICES SIZES

struct MainScreenSize
{
    //  let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    // let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenWidth, ScreenHeight)
    static let SCREEN_MIN_LENGTH = min(ScreenWidth, ScreenHeight)
}


struct DeviceType
{
    let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && MainScreenSize.SCREEN_MAX_LENGTH < 568.0
    let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && MainScreenSize.SCREEN_MAX_LENGTH == 568.0
    let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && MainScreenSize.SCREEN_MAX_LENGTH == 667.0
    let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && MainScreenSize.SCREEN_MAX_LENGTH == 736.0
    let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && MainScreenSize.SCREEN_MAX_LENGTH == 812.0
    let IS_PAD_97INCH = UIDevice.current.userInterfaceIdiom == .pad && MainScreenSize.SCREEN_MAX_LENGTH == 1024
    let IS_PAD_105INCH = UIDevice.current.userInterfaceIdiom == .pad && MainScreenSize.SCREEN_MAX_LENGTH == 1112
    let IS_PAD_129INCH = UIDevice.current.userInterfaceIdiom == .pad && MainScreenSize.SCREEN_MAX_LENGTH == 1366
}

//MARK: Device

let IsPad   = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
let isiPadPro = IsPad && (UIScreen.main.bounds.size.height == 1024)

//MARK: Device Width & Heights

let CurrentDevice = UIDevice.current
let iOSVersion   = CurrentDevice.systemVersion
let ISSimulator   = (UIDevice.current.isSimulator)

let WindowFrame = UIScreen.main.bounds
var ScreenWidth = WindowFrame.size.width
var ScreenHeight = WindowFrame.size.height

let DeviceWidth  = min(ScreenWidth, ScreenHeight)
let DeviceHeight = max(ScreenWidth,ScreenHeight)

let NavBarHeight   =          (20+44)
let SideBarWidth    =         IsPad ? 320 : 240
let MasterWidthForSplitVC =    320

let IsiPhone4SOr5S = ScreenHeight == 480 || ScreenHeight == 568
let IsIphoneSize35Inch = ScreenHeight == 480
let IsIphoneSize40Inch = ScreenHeight == 568
let IsIphoneSize47Inch = ScreenHeight == 667
let IsIphoneSize55Inch = ScreenHeight == 736
let IsIphoneX = ScreenHeight == 812

extension Array where Element: Equatable {
    
    public func uniq() -> [Element] {
        var arrayCopy = self
        arrayCopy.uniqInPlace()
        return arrayCopy
    }
    
    mutating public func uniqInPlace() {
        var seen = [Element]()
        var index = 0
        for element in self {
            if seen.contains(element) {
                remove(at: index)
            } else {
                seen.append(element)
                index += 1
            }
        }
    }
}

//MARK: FONTS SIZE

let FontSizeDescription : CGFloat = IsPad ? 15.0 : 13.0
let FontSizeHeading : CGFloat = IsPad ? 18.0 : 16.0
let FontSizeHeadingTypeTwo : CGFloat = IsPad ? 20.0 : 18.0
let FontSizeReadMore : CGFloat = IsPad ? 15.0 : 13.0

//MARK: Colors

extension UIColor{
    class  func UIColorWithRGBA(r: CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor(
            red: CGFloat (r/255.0),
            green: CGFloat (g/255.0),
            blue: CGFloat (b/255.0),
            alpha: CGFloat(a)
        )
    }
}

let ColorMainBackground: UIColor = UIColor.UIColorWithRGBA(r: 247, g: 248, b: 249, a: 1.0)

let ColorSelectedPaymentCardBackgroundColor: UIColor   = UIColor.UIColorWithRGBA(r: 209, g: 242, b: 235, a: 1.0)
let ColorDeSelectedPaymentCardBackgroundColor: UIColor   = UIColor.UIColorWithRGBA(r: 236, g: 240, b: 241, a: 1.0)
let ColorSelectedPaymentCardContainerBorderColor: UIColor   = UIColor.UIColorWithRGBA(r: 112, g: 215, b: 195, a: 1.0)
let ColorDeSelectedPaymentCardContainerBorderColor: UIColor   = UIColor.UIColorWithRGBA(r: 220, g: 222, b: 222, a: 1.0)


let RatingViewTintColor : UIColor   = UIColor.UIColorWithRGBA(r: 241, g: 196, b: 13, a: 1.0)

let ColorTheme : UIColor = UIColor.UIColorWithRGBA(r: 46, g: 186, b: 157, a: 1.0)
//let ColorThemeHwNw : UIColor   = UIColor.UIColorWithRGBA(r: 46, g: 186, b: 157, a: 1.0)

let ColorWithCode_12_121_192 : UIColor   = UIColor.UIColorWithRGBA(r: 12, g: 121, b: 192, a: 1.0)
let ColorWithCode_44_44_44 : UIColor   = UIColor.UIColorWithRGBA(r: 44, g:44, b: 44, a: 1.0)
let ColorWithCode_74_74_74 : UIColor   = UIColor.UIColorWithRGBA(r: 74, g:74, b: 74, a: 1.0)
let ColorWithCode_8_92_147 : UIColor   = UIColor.UIColorWithRGBA(r: 8, g: 92, b: 147, a: 1.0)

let ColorBadge: UIColor   = UIColor.UIColorWithRGBA(r: 229, g: 99, b: 83, a: 1.0)
let ColorCertificate: UIColor   = UIColor.UIColorWithRGBA(r: 135, g: 166, b: 254, a: 1.0)

let LightGrayColor = UIColor.lightGray
let DarkGrayColor  = UIColor.darkGray
let ClearColor     = UIColor.clear
let WhiteColor     = UIColor.white
let BlackColor     = UIColor.black
let GreenColor     = UIColor.green
let RedColor       = UIColor.red

// MARK: Inline Helpers

func search(name: NSString, _ limits: Int) -> NSString {
    let urlEncodedName = name.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    return "https://someURL.com/search?term=\(urlEncodedName)&limit=\(limits)" as NSString
}

func ReplaceOccurances(s : NSString, o : NSString,r : NSString) -> NSString{
    return (s.replacingOccurrences(of: o as String, with: r as String) as NSString)
}

func RemoveCommas(s : NSString) ->String{
    return (s.replacingOccurrences(of: "," as String, with:"" as String))
}

func RemoveSpaces(s : NSString) ->String{
    return (s.replacingOccurrences(of: " " as String, with:"" as String))
}

//func AttributedStringMutable(s: NSString, a: NSDictionary) -> NSMutableAttributedString{
//    return (NSMutableAttributedString.init(string: s as String, attributes: a as? [String : AnyObject]))
//}
//
//func AttributedString(s: NSString, a: NSDictionary) -> NSAttributedString{
//    return (NSAttributedString.init(string: s as String, attributes: a as? [String : AnyObject]))
//}

func Image(i: NSString) -> UIImage{
    return UIImage(named: i as String)!
}

func TemplateImage(imageNamed : String?) -> UIImage?{
    if imageNamed != nil {
        return (UIImage(named: imageNamed!))!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    }else{
        return nil
    }
}

enum TabbarIcon: String {
    case tabbarIcon_sn_news
    case tabbarIcon_sn_news_selected
    case tabbarIcon_news
    case tabbarIcon_news_selected
    case tabbarIcon_profile
    case tabbarIcon_profile_selected
    func image(selected: Bool = false) -> UIImage {
        return UIImage(named: self.rawValue)!
    }
}

func Format(fmt : String) -> String {
    
    return String.init(fmt)
    
    //use
    // let floatVal: Float = 3.00
    
    //  let str : String =  Format(fmt: "\("this is : ")\(floatVal)")
}

//MARK: APIEndPoints

struct APIEndPoints  {
    static let APITopStories = "http://timesofindia.indiatimes.com/rssfeedstopstories.cms"
}

//MARK: HttpMethods

struct HttpMethods  {
    static let HttpMethod_GET = "GET"
    static let HttpMethod_POST = "POST"
    static let HttpMethod_DELETE = "DELETE"
    static let HttpMethod_PUT = "PUT"
    static let HttpMethod_UPDATE = "UPDATE"
}

//MARK: UserDefaultsKeys

struct UserDefaultsKeys  {
    static let currency_code = "currency_code"
    static let red = "red"
    static let blue = "blue"
    static let green = "green"
    static let school_id = "school_id"
    static let school_theme_secondary_color = "school_theme_secondary_color"
}

//MARK: JsonKeys

struct JsonKeys  {
    static let shouldResumeJourney = "shouldResumeJourney"
    static let authentication_token = "authentication_token"
    static let firInstanceToken = "token"
    static let remember_me = "remember_me"
    static let email = "email"
    static let current_password = "current_password"
    static let password = "password"
    static let password_confirmation = "password_confirmation"
    static let user = "user"
    static let user_id = "user"

}

//MARK: Custom Fonts

struct CustomFonts {
    struct ProximaNova {
        static let bold = "ProximaNova-Bold"
        static let regular = "ProximaNova-Regular"
    }
    
    struct Montserrat {
        static let bold = "Montserrat-Bold"
        static let medium = "Montserrat-Medium"
        static let regular = "Montserrat-Regular"
    }
}


struct FontMyriadPro {
    static let MyriadProRegular = "MyriadPro-Regular"
    static let MyriadProBold = "MyriadPro-Bold"
    static let MyriadProBlackSemiCn = "MyriadPro-BlackSemiCn"
    static let MyriadProBoldSemiExtended = "MyriadPro-BoldSemiExt"
}

//MARK: Messages

struct Messages {
    static let Required = "Required"
    static let IncorrectEmail = "Incorrect email address"
    static let PasswordTooShort = "Password is too short (minimum is 8 characters)"
    static let PasswordCntn1Nmbr = "Password should contain at least one number"
    static let SmthngWntWrng = "Something went wrong"
    static let InternalServerError = "Whoa! We encountered an error!"
    static let InstructionsToResetPassword = "You will get an OTP to change the password on the App"
    static let OTPValidated = "OTP is successfully validated!"
    static let NoInternet = "The Internet connection appears to be offline"
    static let EmailNotFound = "Email not found"
    static let ReferralCodeApplied = "Referral code successfully applied"
    static let EnterReferralCode = "Enter referral code"
    static let UnauthorizedAccess = "Unauthorized access"
    static let ProfilePicSuccess = "Your profile picture has been updated successfully."
    static let PasswordsNotMatch = "Passwords don't match"
    static let passwordChangeSuccess = "Password has been changed successfully!"
    static let  UnableToLoadfeeds = "Could not load fees"
}

struct CellIdentifiers {
    static let IntroCell = "IntroCell"
    static let DetailCell = "DetailCell"
    static let HistoryCampCell = "HistoryCampCell"
    static let HistoryCell = "HistoryCell"
}

extension UIDevice {
    var isSimulator: Bool {
        
        #if arch(i386) || arch(x86_64)
            return true
        #else
            return false
        #endif
        
        //return UIDevice.current.userInterfaceIdiom.rawValue == 0
        
        //not working
        
        //        #if TARGET_IOS_SIMULATOR
        //            return true
        //        #else
        //            return false
        //        #endif
    }
}

