//
//  Playlist.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SwiftyJSON

class Playlist: JSONItem{
    var title: String
    var id: String
    
    required init(json: JSON){
        self.title = json["snippet"]["title"].stringValue
        self.id = json["id"]["playlistId"].stringValue
    }
    
    init(){
        self.title = MostRecentVideoName
        self.id = "0"
    }
    
    func isEqual(playlist: Playlist) -> Bool {
        return playlist.id == self.id
    }
}