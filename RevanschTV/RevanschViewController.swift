//
//  RevanschViewController.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import UIKit
import Foundation

class RevanschViewController: UIViewController{
    @IBOutlet var webview: UIWebView?
    var loadingView: UIView?
    var currentVideo: Video!
    var nextPageTokens: [String] = []
    var tableVC: RevanschTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview?.scrollView.scrollEnabled = false
        startLoadingView()
        downloadPlaylists()
    }
    
    private func startLoadingView(){
        loadingView = LoadingView.instanceFromNib()
        loadingView?.frame = CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height)
        loadingView?.center = self.view.center
        view.addSubview(loadingView!)
    }

    private func downloadPlaylists(){
        let type: YoutubeRequestType = .Playlist
        AlamoConnection(requestType: type).download(){
        (nextPageToken, responseArray) in
            var playlists = responseArray as! [Playlist]
            playlists.insert(Playlist(title: MostRecentVideoName, id: "ID"), atIndex: 0)
            self.nextPageTokens = createEmptyStringArray(playlists.count)
            self.tableVC.reloadPlaylists(playlists)
            self.fillVideos(playlists)
        }
    }
   
    private func fillVideos(playlists: [Playlist]){
        for i in 0...playlists.count-1{
            print(playlists[i].title)
            self.downloadVideos(playlists[i], index: i)
        }
    }
    
    private func downloadVideos(playlist: Playlist, index: Int){
        let token = nextPageTokens[index]
        let type: YoutubeRequestType = playlist.title == MostRecentVideoName ? .MostRecentVideo(nextPageToken: token) : .Video(playlistID: playlist.id, nextPageToken: token)
        AlamoConnection(requestType: type).download(){
            (nextPageToken, responseArray) in
            let videos = responseArray as! [Video]
            self.nextPageTokens[index] = nextPageToken
            self.tableVC.reloadVideos(videos, canDownloadMore: nextPageToken != "", index: index)
        }
    }
    
    private func updateTopView(video: Video){
        self.currentVideo = video
        let videoURL : NSURL = NSURL(string: "https://www.youtube.com/embed/\(video.videoId)")!
        let URLRequest : NSURLRequest = NSURLRequest(URL: videoURL)
        self.webview?.loadRequest(URLRequest)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RevanschTableSegue" {
            let table =  segue.destinationViewController as! RevanschTableViewController
            self.tableVC = table
            table.delegate = self
        }
        if segue.identifier == "CommentsSegue" {
            let commentVC = segue.destinationViewController as! CommentsViewController
            commentVC.video = self.currentVideo
        }
    }
}

extension RevanschViewController: VideosDelegate {
    
    func videoSelected(video: Video) {
        updateTopView(video)
    }
    
    func mostRecentDownloaded(topVideo: Video){
        updateTopView(topVideo)
        self.loadingView?.removeFromSuperview()
    }
    
    func downloadMoreFromPlaylist(playlist: Playlist, index: Int) {
        downloadVideos(playlist, index: index)
    }
}
