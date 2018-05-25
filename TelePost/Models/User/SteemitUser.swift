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
    
    /*{"user":{"id":504671,"name":"iamankit","owner":{"weight_threshold":1,"account_auths":[],"key_auths":[["STM8BDGxwueuEvtJXnYw58XW4PZnfcL7Z8mUnp86VMRvyBv9kuVrN",1]]},"active":{"weight_threshold":1,"account_auths":[],"key_auths":[["STM6YHZThESgziP3TCSJrHFENSFKA1525mQSTUwHLfk83GTGPvgJf",1]]},"posting":{"weight_threshold":1,"account_auths":[["fundition.app",1],["steem-plus-app",1],["utopian.app",1]],"key_auths":[["STM651yqco5edHfh3zsCPmCKfbhEE8ioCG4w4W79HB7vivZJLhhYz",1]]},"memo_key":"STM6tJqURwBTsZoo2Ftij5CY7JL2UwJ6r4ndXDT5hUdnV3Uee9uMd","json_metadata":{"profile":{"name":"Animus","location":"Xcode","profile_image":"https://scontent.fluh1-1.fna.fbcdn.net/v/t1.0-9/28168693_2078211402194455_6770665025130099426_n.jpg?oh=703287dcf202ec72f9626350228d35b7&oe=5B039F0B","cover_image":"http://www.topcovers4fb.com/wp-content/uploads/2013/01/Plain-Black-Facebook-Timeline-Cover.jpg","about":"Currently an iOS Developer. Loved the way Steemit works, so now trying to learn development in Steemit.","website":"https://steemit.com/@iamankit"}},"proxy":"","last_owner_update":"2018-05-05T06:14:45","last_account_update":"2018-05-15T17:51:48","created":"2017-12-18T05:44:06","mined":false,"recovery_account":"steem","last_account_recovery":"1970-01-01T00:00:00","reset_account":"null","comment_count":0,"lifetime_vote_count":0,"post_count":613,"can_vote":true,"voting_power":9609,"last_vote_time":"2018-05-23T15:46:03","balance":"0.108 STEEM","savings_balance":"0.000 STEEM","sbd_balance":"0.000 SBD","sbd_seconds":"36604316142","sbd_seconds_last_update":"2018-05-25T02:59:09","sbd_last_interest_payment":"2018-04-27T02:47:00","savings_sbd_balance":"0.000 SBD","savings_sbd_seconds":"1282941000","savings_sbd_seconds_last_update":"2018-02-14T08:07:39","savings_sbd_last_interest_payment":"2018-01-30T11:41:42","savings_withdraw_requests":0,"reward_sbd_balance":"0.000 SBD","reward_steem_balance":"0.000 STEEM","reward_vesting_balance":"0.000000 VESTS","reward_vesting_steem":"0.000 STEEM","vesting_shares":"297689.030172 VESTS","delegated_vesting_shares":"0.000000 VESTS","received_vesting_shares":"0.000000 VESTS","vesting_withdraw_rate":"0.000000 VESTS","next_vesting_withdrawal":"1969-12-31T23:59:59","withdrawn":0,"to_withdraw":0,"withdraw_routes":0,"curation_rewards":250,"posting_rewards":290352,"proxied_vsf_votes":[0,0,0,0],"witnesses_voted_for":2,"last_post":"2018-05-16T08:46:45","last_root_post":"2018-05-13T16:19:09","average_bandwidth":"7487820184","lifetime_bandwidth":"1557418000000","last_bandwidth_update":"2018-05-25T07:13:57","average_market_bandwidth":"10229451915","lifetime_market_bandwidth":"68100000000","last_market_bandwidth_update":"2018-05-25T03:11:51","vesting_balance":"0.000 STEEM","reputation":"4444071094423","transfer_history":[],"market_history":[],"post_history":[],"vote_history":[],"other_history":[],"witness_votes":["jesta","utopian-io"],"tags_usage":[],"guest_bloggers":[]},"status":"200"}*/
    
    
    override init() {
        super.init()
    }
    
    func initWith(info : [String : Any]) {
        if let id = info[SteemitUserKeys.id] as? Int {
            self.id = id
        }
        if let name = info[SteemitUserProfileKeys.name] as? String {
            self.name = name
        }
        if let profileInfo = info[SteemitUserKeys.profile] as? [String : Any] {
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
    
    /*{"profile":{"name":"Animus","location":"Xcode","profile_image":"https://scontent.fluh1-1.fna.fbcdn.net/v/t1.0-9/28168693_2078211402194455_6770665025130099426_n.jpg?oh=703287dcf202ec72f9626350228d35b7&oe=5B039F0B","cover_image":"http://www.topcovers4fb.com/wp-content/uploads/2013/01/Plain-Black-Facebook-Timeline-Cover.jpg","about":"Currently an iOS Developer. Loved the way Steemit works, so now trying to learn development in Steemit.","website":"https://steemit.com/@iamankit"}}*/
    
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

