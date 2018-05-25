//
//  SteemitUser.swift
//  TelePost
//
//  Created by Hitender kumar on 25/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

struct SteemitUserKeys {
    static let id = "id"
    static let name = "name"
    static let json_metadata = "json_metadata"
    static let profile = "profile"
    
}
class SteemitUser: NSObject {
    
    var id : Int = 0
    var name  :String = ""
    var profile : SteemitUserProfile?
    
    override init() {
        super.init()
    }
    
    init(info : [String : Any]) {
        if let id = info[SteemitUserKeys.id] as? Int {
            self.id = id
        }
        if let name = info[SteemitUserProfileKeys.name] as? String {
            self.name = name
        }
        if let json_metadata = info[SteemitUserKeys.json_metadata] as? [String : Any], let profileInfo = json_metadata[SteemitUserKeys.profile] as? [String : Any] {
             self.profile = SteemitUserProfile.init(info: profileInfo)
        }
    }
 }

struct SteemitUserProfileKeys {
    static let name = "name"
    static let location = "location"
    static let profile_image = "profile_image"
    static let cover_image = "cover_image"
    static let about = "about"
    static let website = "website"
}

class SteemitUserProfile: NSObject {
    
    var name = ""
    var location = ""
    var profile_image = ""
    var cover_image = ""
    var about = ""
    var website = ""
    
    override init() {
        super.init()
    }
    
    init(info : [String : Any]) {
        if let name = info[SteemitUserProfileKeys.name] as? String {
            self.name = name
        }
        if let location = info[SteemitUserProfileKeys.location] as? String {
            self.location = location
        }
        if let profile_image = info[SteemitUserProfileKeys.profile_image] as? String {
            self.profile_image = profile_image
        }
        if let cover_image = info[SteemitUserProfileKeys.cover_image] as? String {
            self.cover_image = cover_image
        }
        if let about = info[SteemitUserProfileKeys.about] as? String {
            self.about = about
        }
        if let website = info[SteemitUserProfileKeys.website] as? String {
            self.website = website
        }
    }
}

