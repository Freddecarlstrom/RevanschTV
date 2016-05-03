//
//  Reply.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 24/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SwiftyJSON

class Reply: CommentItem, JSONItem {
    
    required init(json: JSON) {
        let name: String = json["snippet"]["authorDisplayName"].stringValue
        let comment: String = json["snippet"]["textDisplay"].stringValue.stringByReplacingOccurrencesOfString("\n", withString: "")
        var publishedAt: String = json["snippet"]["publishedAt"].stringValue
        super.init(name: name, comment: comment, publishedAt: publishedAt.getDate())
    }
}