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
            return "search?part=snippet&channelId=\(CHANNEL_ID)&maxResults=50&order=date&type=playlist&fields=items(id%2Csnippet)&key=\(API_KEY)"
        case Video:
            return "playlistItems?part=snippet&maxResults=\(MaxResults)&fields=items%2CnextPageToken&key=\(API_KEY)&"
        case .MostRecentVideo:
            return "search?part=snippet&channelId=\(CHANNEL_ID)&maxResults=\(MaxResults)&order=date&type=video&fields=items(id%2Csnippet)%2CnextPageToken&key=\(API_KEY)&"
        case Comments:
            return "commentThreads?part=snippet&maxResults=\(MaxResults+2)&order=time&textFormat=plainText&fields=items%2CnextPageToken&key=\(API_KEY)&"
        case Replies:
            return "comments?part=snippet&maxResults=100&textFormat=plainText&fields=items&key=\(API_KEY)&"
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
        self.URL = "\(BASE_URL)\(requestType.URL(API_KEY, CHANNEL_ID: CHANNEL_ID))\(requestType.extra)"
    }
    
    func download(completionHandler: (String, Array<AnyObject>) -> Void){
        print("Downloading...")
        Alamofire.request(.GET, self.URL).responseJSON {
            response in
            switch response.result {
                
            case .Success(let json):
                let jsonArray = JSON(json)
                var nextPageToken: String = ""
                var responseArray: Array<AnyObject> = []
                
                switch self.requestType! {
                case .Playlist:
                    print("Playlists")
                    responseArray = JSONPlaylists(jsonArray["items"].array!)
                break
                case .Video, .MostRecentVideo:
                    print("Video")
                    nextPageToken = jsonArray["nextPageToken"].stringValue
                    responseArray = JSONVideos(jsonArray["items"].array!)
                break
                case .Comments:
                    print("Comments")
                    nextPageToken = jsonArray["nextPageToken"].stringValue
                    responseArray = JSONComments(jsonArray["items"].array!)
                break
                case .Replies:
                    print("Replies")
                    responseArray = JSONReplies(jsonArray["items"].array!)
                break
                }
                completionHandler(nextPageToken, responseArray)
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }

        }
    }
}
