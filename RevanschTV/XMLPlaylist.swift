//
//  XMLPlaylist.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SWXMLHash

struct XMLPlaylist: XMLIndexerDeserializable{
    var title: String
    var published: String
    
    static func deserialize(node: XMLIndexer) throws -> XMLPlaylist{
        return try XMLPlaylist(
            title: node["title"].value(),
            published: node["publishedAt"].value()
           )
    }
    
    func getDate() -> NSDate{
        let dateFormatter = NSDateFormatter()
        let stringDate = published.substringWithRange(published.startIndex..<published.startIndex.advancedBy(19))
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.dateFromString(stringDate)!
    }
}