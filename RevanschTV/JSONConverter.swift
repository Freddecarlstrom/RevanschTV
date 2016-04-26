//
//  JSONHelper.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SwiftyJSON

//--------------PARSE PLAYLISTS--------------
func JSONPlaylists(json: [JSON]) -> [Playlist]{
    var playlists: [Playlist] = []
    for item in json {
        let playlist = Playlist(title: item["snippet"]["title"].stringValue, id: item["id"]["playlistId"].stringValue)
        playlists.append(playlist)
    }
    playlists.sortInPlace({
        return $1.title > $0.title
    })
    return playlists.reverse()
}

//--------------PARSE VIDEOS--------------
func JSONVideos(json: [JSON]) -> [Video] {
    var videos: [Video] = []
    for item in json {
        let (title, seasonEpisode) = chopTitle(item["snippet"]["title"].stringValue)
        //For Most Recent Videos Download. JSON is different
        let id = item["snippet"]["resourceId"]["videoId"].stringValue
        let videoId = id == "" ? item["id"]["videoId"].stringValue : id
        
        let publishedAt = item["snippet"]["publishedAt"].stringValue
        let thumbnailUrl = item["snippet"]["thumbnails"]["medium"]["url"].stringValue
        
        let video = Video(title: title, published: getDate(publishedAt), seasonEpisode: seasonEpisode, videoId: videoId, thumbnailUrl: thumbnailUrl)
        video.color = colorForSeason(seasonEpisode)
        videos.append(video)
    }
    return videos
}

//longTitle format: "Revansch! - S00E00: Probotector (SNES)
func chopTitle(longTitle: String) -> (String, String){
    var toChop = longTitle
    toChop.replaceRange(toChop.startIndex..<toChop.startIndex.advancedBy(12), with: "")
    let titleArray = separate(toChop)
    let titleString = titleArray[1]
    let title = titleString[titleString.startIndex.advancedBy(1)..<titleString.endIndex]
    let seasonEpisode = titleArray[0]
    return (title, seasonEpisode)
}

func getDate(publishedAt: String) -> String{
    let dateFormatter = NSDateFormatter()
    let stringDateLong = publishedAt.substringWithRange(publishedAt.startIndex..<publishedAt.startIndex.advancedBy(19))
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let date = dateFormatter.dateFromString(stringDateLong)
    dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
    return dateFormatter.stringFromDate(date!)
    

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

//--------------PARSE COMMENTS--------------
func JSONComments(json: [JSON]) -> [Comment]{
    var comments: [Comment] = []
    for item in json {
        let name = item["snippet"]["topLevelComment"]["snippet"]["authorDisplayName"].stringValue
        let comment = item["snippet"]["topLevelComment"]["snippet"]["textDisplay"].stringValue.stringByReplacingOccurrencesOfString("\n", withString: "")
        let id = item["id"].stringValue
        let nbrOfReplies = item["snippet"]["totalReplyCount"].intValue
        let publishedAt = item["snippet"]["topLevelComment"]["snippet"]["publishedAt"].stringValue
        comments.append(Comment(name: name, comment: comment, id: id, nbrOfReplies: nbrOfReplies, publishedAt: getDate(publishedAt)))
    }
    return comments
}

//--------------PARSE REPLIES--------------
func JSONReplies(json: [JSON]) -> [Reply]{
    var replies: [Reply] = []
    for item in json {
        let name = item["snippet"]["authorDisplayName"].stringValue
        let comment = item["snippet"]["textDisplay"].stringValue.stringByReplacingOccurrencesOfString("\n", withString: "")
        let publishedAt = item["snippet"]["publishedAt"].stringValue
        replies.append(Reply(name: name, comment: comment, publishedAt: getDate(publishedAt)))
    }
    return replies
}

