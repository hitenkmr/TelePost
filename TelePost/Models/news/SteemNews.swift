//
//  SteemNews.swift
//  TelePost
//
//  Created by Hitender kumar on 30/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

struct SteemNewsKeys {
    static let title                = "title"
    static let author               = "author"
    static let net_votes            = "net_votes"
    static let children             = "children" //comments
    static let last_update          = "last_update"
    static let created              = "created"
    static let permlink             = "permlink"
    static let pending_payout_value             = "pending_payout_value"
    static let have_i_voted  = "have_i_voted" //custom
    static let active_votes = "active_votes"
 }

class SteemNews: NSObject {
    
    var title : String = ""
    var author : String = ""
    var net_votes : Int = 0
    var childrens : Int = 0 // comments
    var image_url : URL?
    var last_update : String = ""
    var created : String = ""
    var permlink : String = ""
    var payout : String = ""
    var have_i_voted = false
    
    override init() {
        super.init()
    }
    
    init(info : [String : Any]) {
        if let title = info[SteemNewsKeys.title] as? String {
            self.title = title
        }
        if let author = info[SteemNewsKeys.author] as? String {
            self.author = author
        }
        if let net_votes = info[SteemNewsKeys.net_votes] as? Int {
            self.net_votes = net_votes
        }
        if let children = info[SteemNewsKeys.children] as? Int {
            self.childrens = children
        }
        if let permlink = info[SteemNewsKeys.permlink] as? String {
            self.permlink = permlink
        }
        if let last_update = info[SteemNewsKeys.last_update] as? String {
            self.last_update = last_update
        }
        if let created = info[SteemNewsKeys.created] as? String {
            self.created = created
        }
        if let pending_payout_value = info[SteemNewsKeys.pending_payout_value] as? String {
            self.payout = pending_payout_value
        }
        if let metadata = info["json_metadata"]! as? String {
            let data = metadata.data(using: .utf8)!
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:AnyObject]
                {
                    if let images = jsonArray["image"] as? [String] {
                        if images.count > 0 {
                            let imageUrlStr = images[0]
                            image_url = URL(string: imageUrlStr)
                        }
                    }
                } else {
                    print("bad json")
                }
            } catch {
                print("Error in getting steemit news post image")
            }
        }
        
        if let active_votes = info[SteemNewsKeys.active_votes] as? [[String : Any]] {
            self.have_i_voted = active_votes.contains(where: { (voteInfo) -> Bool in
                var voted = false
                if let voter = voteInfo["voter"] as? String, let savedUserName = UserDefaults.standard.value(forKey: UserDataSaveConstants.st_userName_save) as? String  {
                    voted = voter == savedUserName
                }
                return voted
            })
        }
    }
}
