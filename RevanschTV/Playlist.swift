//
//  Playlist.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation

class Playlist {
    var title: String
    var id: String
    
    init(title: String, id: String){
        self.title = title
        self.id = id
    }
    
    func isEqual(playlist: Playlist) -> Bool {
        return playlist.id == self.id
    }
}