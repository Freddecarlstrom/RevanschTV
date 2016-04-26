//
//  CommentsViewController.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 20/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import UIKit
import Foundation

class CommentsViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var seasonEpisodeLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var loadingView: UIActivityIndicatorView?
    var commentsVC: CommentsTableViewController!
    var video: Video!
    var nextPageToken: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel?.text = video.title
        self.seasonEpisodeLabel?.text = video.seasonEpisode
        self.dateLabel?.text = video.published
        self.nextPageToken = ""
        self.downloadComments()
    }
    
    private func downloadComments(){
        loadingView?.hidden = false
        let type: YoutubeRequestType = .Comments(videoID: self.video.videoId, nextPageToken: nextPageToken)
        AlamoConnection(requestType: type).download(){
        (nextPageToken, responseArray) in
            let comments = responseArray as! [Comment]
            self.nextPageToken = nextPageToken
            self.commentsVC.reloadComments(nextPageToken, comments: comments)
            self.fillReplies(comments)
        }
    }
    
    private func fillReplies(comments: [Comment]){
        for index in 0..<comments.count {
            if(comments[index].nbrOfReplies > 0){
                self.downloadReplies(comments[index])
            }
        }
        self.loadingView?.hidden = true
    }
    
    private func downloadReplies(comment: Comment){
    let type: YoutubeRequestType = .Replies(commentID: comment.id)
        AlamoConnection(requestType: type).download(){
        (nextPageToken, responseArray) in
            let replies = responseArray as! [Reply]
            self.commentsVC.reloadReplies(replies, comment: comment)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "CommentsTableSegue" {
            let comments =  segue.destinationViewController as! CommentsTableViewController
            comments.delegate = self
            self.commentsVC = comments
        }
    }
    
}

extension CommentsViewController: CommentsDelegate{
    func downloadMoreComments() {
        downloadComments()
    }
}
