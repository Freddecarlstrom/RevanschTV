//
//  VideoEntity+CoreDataProperties.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 11/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension VideoEntity {

    @NSManaged var datePublished: NSDate?
    @NSManaged var datePublishedString: String?
    @NSManaged var hasBeenPlayed: NSNumber?
    @NSManaged var seasonEpisode: String?
    @NSManaged var thumbnailData: NSData?
    @NSManaged var title: String?
    @NSManaged var videoId: String?

}
