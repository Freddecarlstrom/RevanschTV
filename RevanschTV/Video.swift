//
//  Video.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Video: JSONItem {
    var title: String
    var published: String
    var seasonEpisode: String
    var videoId: String
    var thumbnail: UIImage!
    var color: UIColor!
    
    required init(json: JSON) {
        let (title, seasonEpisode) = chopTitle(json["snippet"]["title"].stringValue)
        self.title = title
        self.seasonEpisode = seasonEpisode
        self.color = colorForSeason(seasonEpisode)
        //For Most Recent Videos Download. JSON is different
        let id = json["snippet"]["resourceId"]["videoId"].stringValue
        self.videoId = id == "" ? json["id"]["videoId"].stringValue : id
        
        var date = json["snippet"]["publishedAt"].stringValue
        self.published = date.getDate()
    
        let thumbnailUrl = json["snippet"]["thumbnails"]["medium"]["url"].stringValue
        let url = NSURL(string: thumbnailUrl)
        self.thumbnail = UIImage(data: NSData(contentsOfURL: url!)!)
    }
}

func chopTitle(longTitle: String) -> (String, String){
    var toChop = longTitle
    toChop.replaceRange(toChop.startIndex..<toChop.startIndex.advancedBy(12), with: "")
    let titleArray = separate(toChop)
    let titleString = titleArray[1]
    let title = titleString[titleString.startIndex.advancedBy(1)..<titleString.endIndex]
    let seasonEpisode = titleArray[0]
    return (title, seasonEpisode)
}

//For screwy titles.
func separate(longTitle: String) -> [String]{
    let firstTry: [String] = longTitle.componentsSeparatedByString(":")
    var titleArray: [String] = firstTry.count >= 2 ? firstTry : longTitle.componentsSeparatedByString("-")
    if(titleArray.count < 2){
        titleArray.append(" \(titleArray[0])")
        titleArray[0] = " EXTRA"
    }
    return titleArray
}