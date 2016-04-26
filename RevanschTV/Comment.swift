//
//  Comment.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 22/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation

class Comment: CommentItem {
    var id: String
    var nbrOfReplies: Int
    
    
    init(name: String, comment: String, id: String, nbrOfReplies: Int, publishedAt: String){
        self.id = id
        self.nbrOfReplies = nbrOfReplies
        super.init(name: name, comment: comment, publishedAt: publishedAt)
    }
    
    func isEqual(item: CommentItem) -> Bool{
        if let item = item as? Comment {
            return self.id == item.id
        } else {
            return false
        }
    }
}