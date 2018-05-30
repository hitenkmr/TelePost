//
//  Source.swift
//  TelePost
//
//  Created by Hitender kumar on 17/05/18.
//  Copyright © 2018 Hitender kumar. All rights reserved.
//

import UIKit

struct SourceKeys {
    static let id               = "id"
    static let name             = "name"
}

class Source: NSObject {
    
    var id : String = ""
    var name : String = ""
    
    override init() {
        super.init()
    }
    
    init(info : [String : Any]) {
        if let id = info[SourceKeys.id] as? String {
            self.id = id
        }
        if let name = info[SourceKeys.name] as? String {
            self.name = name
        }
    }
}
