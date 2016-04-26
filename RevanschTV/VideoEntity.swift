//
//  VideoEntity.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 11/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

//
//  VideoEntity.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 10/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class VideoEntity: NSManagedObject {
    
    let thumbnailURLBegin: String = "https://i4.ytimg.com/vi/"
    let thumbnailURLEnd: String = "/hqdefault.jpg"
    
    func fillWithInfo(item: XMLItem){
        self.videoId = item.id
        parseTitle(item.title)
        parseDate(item.getDate())
        downloadImageData()
    }
    
    func parseTitle(title: String){
        var value = title
        value.replaceRange(value.startIndex..<value.startIndex.advancedBy(12), with: "")
        let titleArray: [String] = value.componentsSeparatedByString(":")
        let titleString = titleArray[1]
        self.title = titleString[titleString.startIndex.advancedBy(1)..<titleString.endIndex]
        self.seasonEpisode = titleArray[0]
    }
    
    func parseDate(date: NSDate){
        self.datePublished = date
        self.datePublishedString = NSDateFormatter.localizedStringFromDate(date, dateStyle: .MediumStyle, timeStyle: .ShortStyle)
    }
    
    func downloadImageData(){
        let urlString = "\(self.thumbnailURLBegin)\(self.videoId!)\(self.thumbnailURLEnd)"
        print("Downloading image: \(urlString)")
        let url = NSURL(string: urlString)!
        self.setImageData(UIImage(data:NSData(contentsOfURL: url)!)!)
    }
    
    func setImageData(image: UIImage){
        self.thumbnailData = UIImageJPEGRepresentation(image,0.2)!
    }
    
    func getImage() -> UIImage {
        return UIImage(data: thumbnailData!)!
    }
    
}

