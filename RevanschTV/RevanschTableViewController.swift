//
//  UiTableViewController.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import UIKit

protocol VideosDelegate: class{
    func videoSelected(video: Video)
    func mostRecentDownloaded(topVideo: Video)
    func downloadMoreFromPlaylist(playlist: Playlist, index: Int)
}

class RevanschTableViewController: UITableViewController{
    weak var delegate: VideosDelegate?
    var lastPressed: (x: Int, y: Int) = (0,0)
    var mostRecentIsPopulated: Bool = false
    var model: [[Video]] = []
    var playlists: [Playlist] = []
    var canDownloadMore: [Bool] = []
    var storedOffsets = [Int: CGFloat]()

    func reloadPlaylists(playlists: [Playlist]){
        self.model = createEmptyVideoMatrix(playlists.count)
        self.canDownloadMore = createEmptyBoolArray(playlists.count)
        self.playlists = playlists
    }
    
    func reloadVideos(videos: [Video], canDownloadMore: Bool, index: Int){
        self.model[index].appendContentsOf(videos)
        self.canDownloadMore[index] = canDownloadMore
        self.tableView.reloadData()
        if !mostRecentIsPopulated && index == 0{
            mostRecentIsPopulated = true
            delegate?.mostRecentDownloaded(videos[0])
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaylistCell", forIndexPath: indexPath) as! PlaylistCell
        cell.playlistLabel?.text = playlists[indexPath.row].title.uppercaseString
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? PlaylistCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? PlaylistCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}

extension RevanschTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[collectionView.tag].count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let video: Video = model[collectionView.tag][indexPath.row]
        if(lastPressed.x != collectionView.tag || lastPressed.y != indexPath.row){
            lastPressed = (collectionView.tag, indexPath.row)
            delegate?.videoSelected(video)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("EpisodeCell", forIndexPath: indexPath) as! VideoCollectionViewCell
        let video = model[collectionView.tag][indexPath.item]
        cell.configureCell(video)

        if(indexPath.item==model[collectionView.tag].count-1 && canDownloadMore[collectionView.tag]){
            canDownloadMore[collectionView.tag] = false
            delegate?.downloadMoreFromPlaylist(playlists[collectionView.tag], index: collectionView.tag)
            
        }
        return cell
    }
}



