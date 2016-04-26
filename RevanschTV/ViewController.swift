//
//  ViewController.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 09/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import UIKit

class ViewController: UIViewController, VideoTableViewDelegate{
    var XMLItems: [XMLItem]!
    @IBOutlet weak var topVideo: UIWebView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var seasonAndEpisodeLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var videoTable: UITableView?
    let dataController: DataController = DataController()
    let connection: AlamoConnection = AlamoConnection()
    let tableViewModel: TableViewModel = TableViewModel()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.tintColor = UIColor.whiteColor()
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topVideo?.scrollView.scrollEnabled = false
        tableViewModel.videoDelegate = self
        tableViewModel.savedVideos = dataController.fetchData()
        videoTable?.registerNib(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        videoTable?.delegate = tableViewModel
        videoTable?.dataSource = tableViewModel
        videoTable?.addSubview(self.refreshControl)
        downloadPlaylists()
    }
    
    func downloadPlaylists(){
        let parsingModel = ParsingModel()
        connection.downloadPlaylistInfo() {
        (playlists) in
           // self.downloadVideos(playlists, index: 0)
        }
        refreshControl.endRefreshing()
    }
    
    func downloadVideos(playLists: [String], index: Int){
        connection.downloadVideos(playLists[0]){
            videosXML in
            
        }
    }
    func pressFirstItemInTable(){
        let path: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        videoTable?.selectRowAtIndexPath(path, animated: true, scrollPosition: UITableViewScrollPosition.Top)
        tableViewModel.tableView(videoTable!, didSelectRowAtIndexPath: path)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
    }
    
    func itemPressed(item: VideoEntity){
        print("Updating top video: \(item.title!)")
        let videoURL : NSURL = NSURL(string: "https://www.youtube.com/embed/\(item.videoId!)")!
        let URLRequest : NSURLRequest = NSURLRequest(URL: videoURL)
        self.topVideo!.loadRequest(URLRequest)
        titleLabel?.text = item.title
        seasonAndEpisodeLabel?.text = item.seasonEpisode
        dateLabel?.text = item.datePublishedString
    }
}

