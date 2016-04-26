//
//  DataController.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 10/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataController{
    var titlesSaved: [String]!
    
    func saveFeedItem(item: XMLItem) ->  (Bool, VideoEntity){
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let videoItem = NSEntityDescription.insertNewObjectForEntityForName("VideoEntity", inManagedObjectContext: managedContext) as! VideoEntity
        videoItem.fillWithInfo(item)
        let successfullSave = self.save(videoItem, context:managedContext)
        return (successfullSave, videoItem)
    }
        
    func save(item: VideoEntity, context: NSManagedObjectContext) -> Bool {
        do {
            print("Trying to save item \(item.title!)")
            try context.save()
            }
        catch {
            print("Save FAIL: Video already exists!")
            return false
        }
        print("Save SUCCESS")
        return true
    }
    
    func fetchData() -> [VideoEntity]{
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "VideoEntity")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let savedVideos = results as! [VideoEntity]
            print("Found Saved Data")
            return savedVideos
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return []
        }
    }
    
 

}