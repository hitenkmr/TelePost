//
//  Client.swift
//  TelePost
//
//  Created by Hitender kumar on 01/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

let baseURL:String = "https://v2.steemconnect.com"
let appId:String = ""

//GET /get_discussions_by_trending
let discussions_by_trending = "https://api.steemjs.com/get_discussions_by_trending?"

//GET /get_discussions_by_created
let discussions_by_created = "https://api.steemjs.com/get_discussions_by_created?"

//GET /get_discussions_by_hot
let discussions_by_hot = "https://api.steemjs.com/get_discussions_by_hot?"

//GET /get_accounts
let get_accounts = "https://api.steemjs.com/get_accounts?"

let get_content_replies = "https://api.steemjs.com/get_content_replies?"

let get_login_url = "https://v2.steemconnect.com/oauth2/authorize?client_id=telepost&redirect_uri=https://github.com/cnsteem/sc2-angular&scope=vote"

//GET /get_search
let get_search_result = "https://api.asksteem.com/search?q=steemthink"

//POST /broadcast
let post_broadcast = "https://v2.steemconnect.com/api/broadcast/"


class STClient: NSObject {
    
    typealias STClientCallBack = (_ response: Any?,_ error: Error?)->()
    
    //MARK: post vote
    
    class func vote(
        voter:String,
        author:String,
        permlink:String,
        weight:NSInteger,
        to:UIView?,
        finished:@escaping STClientCallBack){
        let param = ["voter": voter,
                     "author": author,
                     "permlink":permlink,
                     "weight":weight,
                     ] as [String : Any]
        self.broadcast(body: ["operations":[["vote",param]]],to:to,finished: finished)
    }
    
    class func downVote(
        voter:String,
        author:String,
        permlink:String,
        weight:NSInteger,
        to:UIView?,
        finished:@escaping STClientCallBack){
        let param = ["voter": voter,
                     "author": author,
                     "permlink":permlink,
                     "weight":weight,
                     ] as [String : Any]
        self.broadcast(body: ["operations":[["unvote",param]]],to:to,finished: finished)
    }
    
    class func getVoteStatus(
        author:String,
        permlink:String,
        to:UIView?,
        finished:@escaping STClientCallBack){
        let param = ["author": author,
                     "permlink":permlink
            ] as [String : Any]
        self.broadcast(body: param,to:to,finished: finished)
    }
    
    //MARK: post comment
    class func comment(
        parentAuthor:String,
        parentPermlink:String,
        author:String,
        permlink:String,
        body:String,
        to:UIView?,
        finished:@escaping STClientCallBack) {
        
        let param = ["parent_author": parentAuthor,
                     "parent_permlink": parentPermlink,
                     "author":author,
                     "permlink":permlink,
                     "title":"",
                     "body":body,
                     "json_metadata": ""]
        
        self.broadcast(body: ["operations":[["comment",param]]],to:to,finished: finished)
    }
    
    class func broadcast(body:Dictionary<String, Any>,
                         to:UIView?,
                         finished:@escaping STClientCallBack) {
        self.post(url: post_broadcast, body: body, to:to,finished: finished)
    }
    
    class func post(url:String,body:Dictionary<String, Any>,to:UIView?,finished:@escaping STClientCallBack) -> Void {
        let client = NetworkTools.sharedTools;
         client.requestSerializer.setValue(DataManager.sharedInstance.getToken(), forHTTPHeaderField: "Authorization")
        client.request(method: .POST, urlString: url, parameters: body as AnyObject) { (response, error) in
            finished(response,error)
        }
    }
    
    class func get(url:String!,parameters:AnyObject?,to:UIView?,finished:@escaping STClientCallBack){
        NetworkTools.sharedTools.request(method: .GET, urlString: url, parameters: parameters) { (response: Any?,error: Error?) in
            finished(response,error)
        }
    }
}
