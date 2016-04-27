//
//  CommentsTableViewController.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 22/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import UIKit
import Foundation

protocol CommentsDelegate: class{
    func downloadMoreComments()
}

class CommentsTableViewController: UITableViewController {
    var comments: [Comment] = []
    var allCommentsAndReplies: [CommentItem] = []
    weak var delegate: CommentsDelegate?
    var canDownloadMoreComments: Bool = false
    
    func reloadComments(nextPageToken: String, comments: [Comment]){
        self.allCommentsAndReplies.appendContentsOf(comments)
        self.reloadDataWithAnimation(UIViewAnimationOptions.Autoreverse)
        self.canDownloadMoreComments = nextPageToken != ""
    }
    
    func reloadReplies(replies: [Reply], comment: Comment){
        let index = allCommentsAndReplies.find{
            return comment.isEqual($0)
        }
        self.allCommentsAndReplies.insertContentsOf(replies.reverse(), at: index!+1)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCommentsAndReplies.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let commentItem = allCommentsAndReplies[indexPath.row]
        let identifier = commentItem is Comment ? "CommentCell" : "ReplyCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! CommentTableCell
        cell.configureCell(commentItem)
        if(indexPath.row == allCommentsAndReplies.count-1 && canDownloadMoreComments){
            canDownloadMoreComments = false
            delegate?.downloadMoreComments()
        }
        return cell
    }
}
