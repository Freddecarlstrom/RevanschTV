//
//  JSONConverter2.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 27/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONItem{
    init(json: JSON)
}

class JSONConverter{
    var type: YoutubeRequestType
    
    init(type: YoutubeRequestType){
        self.type = type
    }
    
    func convertJSONToItemArray(jsonArray: [JSON]) -> [JSONItem]{
        var JSONItemArray: [JSONItem] = []
        for json in jsonArray {
            var item: JSONItem
            
            switch type{
            case .Video, .MostRecentVideo:
                    item = Video(json: json)
            break
            case .Playlist:
                    item = Playlist(json: json)
            break
            case .Comments:
                item = Comment(json: json)
            break
            case .Replies:
                item = Reply(json: json)
            }
            JSONItemArray.append(item)
        }
        return JSONItemArray
    }
}