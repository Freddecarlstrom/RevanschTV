//
//  VideoModel.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 10/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SWXMLHash

struct XMLItem: XMLIndexerDeserializable{
    var published: String
    var id: String
    var title: String
    
    static func deserialize(node: XMLIndexer) throws -> XMLItem{
        return try XMLItem(
            published: node["published"].value(),
            id: node["yt:videoId"].value(),
            title: node["title"].value())
    }
    
    func getDate() -> NSDate{
        let dateFormatter = NSDateFormatter()
        let stringDate = published.substringWithRange(published.startIndex..<published.startIndex.advancedBy(19))
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.dateFromString(stringDate)!
    }
}