//
//  Video.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import UIKit

class Video: CustomStringConvertible  {
    var title: String
    var published: String
    var seasonEpisode: String
    var videoId: String
    var thumbnail: UIImage!
    var color: UIColor!
    
    init(title: String, published: String, seasonEpisode: String, videoId: String, thumbnailUrl: String){
        self.title = title
        self.published = published
        self.seasonEpisode = seasonEpisode
        self.videoId = videoId
        if(thumbnailUrl != ""){
        self.getImage(thumbnailUrl)
        }
    }
    
    private func getImage(stringURL: String){
        let url = NSURL(string: stringURL)
        self.thumbnail = UIImage(data: NSData(contentsOfURL: url!)!)
    }
    
    var description: String{
        return "\(seasonEpisode) : \(title)"
    }
}