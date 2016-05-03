//
//  AlamoConnection.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 09/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let MostRecentVideoName = "Senaste Videos"
let MaxResults = 8

enum YoutubeRequestType{
    case Playlist
    case MostRecentVideo(nextPageToken: String)
    case Video(playlistID: String, nextPageToken: String)
    case Comments(videoID: String, nextPageToken: String)
    case Replies(commentID: String)
    
    func URL(API_KEY: String, CHANNEL_ID: String) -> String {
        switch self {
        case Playlist:
            return "search?part=snippet&channelId=\(CHANNEL_ID)&maxResults=50&order=title&type=playlist&fields=items(id%2Csnippet)&"
        case Video:
            return "playlistItems?part=snippet&maxResults=\(MaxResults)&fields=items%2CnextPageToken&"
        case .MostRecentVideo:
            return "search?part=snippet&channelId=\(CHANNEL_ID)&maxResults=\(MaxResults)&order=date&type=video&fields=items(id%2Csnippet)%2CnextPageToken&"
        case Comments:
            return "commentThreads?part=snippet&maxResults=\(MaxResults+2)&order=time&textFormat=plainText&fields=items%2CnextPageToken&"
        case Replies:
            return "comments?part=snippet&maxResults=100&textFormat=plainText&fields=items&"
        }
    }
    
    var extra: String {
        switch self {
        case .Playlist:
            return ""
        case .MostRecentVideo(let nextPageToken):
            return "pageToken=\(nextPageToken)"
        case .Video(let playlistID, let nextPageToken):
            return "pageToken=\(nextPageToken)&playlistId=\(playlistID)"
        case .Comments(let videoID, let nextPageToken):
            return "pageToken=\(nextPageToken)&videoId=\(videoID)"
        case .Replies(let commentID):
            return "parentId=\(commentID)"
        }
    }
}

class AlamoConnection{
    let API_KEY = "AIzaSyDxSSk2Mwx19DKnOA_9BIvfq9_kOaT-tWk"
    let CHANNEL_ID = "UCAMUxJo6JRmxI0W8kEBhI8w"
    let BASE_URL = "https://www.googleapis.com/youtube/v3/"
    var URL:String!
    let requestType: YoutubeRequestType!

    init(requestType: YoutubeRequestType){
        self.requestType = requestType
        self.URL = "\(BASE_URL)\(requestType.URL(API_KEY, CHANNEL_ID: CHANNEL_ID))\(requestType.extra)&key=\(API_KEY)"
    }
    
    func download(completionHandler: (String, Array<JSONItem>, Bool) -> Void){
        print("Downloading...")
        Alamofire.request(.GET, self.URL).responseJSON {
            response in
            switch response.result {
                
            case .Success(let json):
                let jsonArray = JSON(json)
                let nextPageToken: String = jsonArray["nextPageToken"].stringValue
                let responseArray = JSONConverter(type: self.requestType).convertJSONToItemArray(jsonArray["items"].array!)
                completionHandler(nextPageToken, responseArray, true)
            case .Failure(let error):
                print(error)
                completionHandler("",[],false)
            }

        }
    }
}
