//
//  CommentItem.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 24/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SwiftyJSON

class CommentItem{
    var name: String
    var comment: String
    var publishedAt: String
    
    init(name: String, comment: String, publishedAt: String){
        self.name = name
        self.comment = comment
        self.publishedAt = publishedAt
    }
}

extension Array {
    public mutating func appendContentsOf(newElements: [Element]) {
        newElements.forEach {
            self.append($0)
        }
    }
    public mutating func insertContentsOf(newElements: [Element], at: Int){
        var index = at
        newElements.forEach {
            self.insert($0, atIndex: index)
            index+=1
        }
    }
    
    public func find(includedElement: Element -> Bool) -> Int? {
        for (position, element) in enumerate() {
            if includedElement(element) {
                return position
            }
        }
        return -1
    }
}

extension String {
    mutating func getDate() -> String{
        let dateFormatter = NSDateFormatter()
        let stringDateLong = self.substringWithRange(self.startIndex..<self.startIndex.advancedBy(19))
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.dateFromString(stringDateLong)
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        return dateFormatter.stringFromDate(date!)
    }
}