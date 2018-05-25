//
//  TopHeadline.swift
//  TelePost
//
//  Created by Hitender kumar on 07/03/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

struct TopHeadlineKeys {
    static let source                   = "source"
    static let author                   = "author"
    static let title                    = "title"
    static let description              = "description"
    static let url                      = "url"
    static let urlToImage               = "urlToImage"
    static let publishedAt              = "publishedAt"
}

class TopHeadline: NSObject {
    var source = Source()
    var author : String = ""
    var title : String = ""
    var desc : String = ""
    var url : String = ""
    var urlToImage : String = ""
    var publishedAt : String = ""
 
    init(info : [String : Any]) {
        super.init()
        if let source = info[TopHeadlineKeys.source] as? [String : Any] {
             self.source = Source.init(info: source)
        }
        if let author = info[TopHeadlineKeys.author] as? String {
            self.author = author
        }
        if let title = info[TopHeadlineKeys.title] as? String {
            self.title = title
        }
        if let description = info[TopHeadlineKeys.description] as? String{
            self.desc = description
        }
        if let url = info[TopHeadlineKeys.url] as? String {
            self.url = url
        }
        if let urlToImage = info[TopHeadlineKeys.urlToImage] as? String{
            self.urlToImage = urlToImage
        }
        if let publishedAt = info[TopHeadlineKeys.publishedAt] as? String {
            self.publishedAt = publishedAt
        }
    }
}
