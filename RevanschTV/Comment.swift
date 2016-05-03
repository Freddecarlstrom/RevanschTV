//
//  Comment.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 22/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SwiftyJSON

class Comment: CommentItem, JSONItem {
    var id: String
    var nbrOfReplies: Int
    
    
    required init(json: JSON){
        self.id = json["id"].stringValue
        self.nbrOfReplies = json["snippet"]["totalReplyCount"].intValue
        let comment: String = json["snippet"]["topLevelComment"]["snippet"]["textDisplay"].stringValue.stringByReplacingOccurrencesOfString("\n", withString: "")
        let name: String = json["snippet"]["topLevelComment"]["snippet"]["authorDisplayName"].stringValue
        var publishedAt: String = json["snippet"]["topLevelComment"]["snippet"]["publishedAt"].stringValue
        super.init(name: name, comment: comment, publishedAt: publishedAt.getDate())
    }
    
    func isEqual(item: CommentItem) -> Bool{
        if let item = item as? Comment {
            return self.id == item.id
        } else {
            return false
        }
    }
}