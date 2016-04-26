//
//  TableViewDelegate.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import UIKit

protocol VideoTableViewDelegate: class {
    func itemPressed(item: VideoEntity)
}

class TableViewModel: NSObject, UITableViewDataSource, UITableViewDelegate{
    var savedVideos: [VideoEntity]!
    let cellColors = [UIColor.init(hexString: "232323"),UIColor.init(hexString: "131313")]
    var lastPressed: Int = -1
    weak var videoDelegate: VideoTableViewDelegate?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedVideos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:VideoTableViewCell = tableView.dequeueReusableCellWithIdentifier("VideoTableViewCell")! as! VideoTableViewCell
        let video: VideoEntity = self.savedVideos[indexPath.row]
        cell.titleLabel?.text = video.title
        cell.seasonAndEpisodeLabel?.text = video.seasonEpisode
        cell.thumbnail?.image = video.getImage()
        cell.dateLabel?.text = video.datePublishedString
        cell.backgroundColor = cellColors[indexPath.row%2]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(lastPressed != indexPath.row){
            videoDelegate?.itemPressed(savedVideos[indexPath.row])
            lastPressed = indexPath.row
        }
    }
    
    func addVideos(videos: [VideoEntity]){
        var index = 0
        for video in videos {
            savedVideos.insert(video, atIndex: index)
            index+=1
        }
    }
}

extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        var isGreater = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        return isGreater
    }
}
