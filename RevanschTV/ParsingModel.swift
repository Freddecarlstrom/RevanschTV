//
//  DataDownloadModel.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation

class ParsingModel{
    let dataController: DataController = DataController()

func parse(jsonData: NSData) -> [VideoEntity] {
    print("Trying to Parse XML")
    var XMLItems: [XMLItem] = []
    do{
        XMLItems = try XMLParser().parseXML(jsonData)
    }
    catch {
        print("Parse FAIL")
    }
    return fillTableWithNew(XMLItems)
}

func fillTableWithNew(var XMLItems: [XMLItem]) -> [VideoEntity]{
    var video: VideoEntity
    var keepAddingItems: Bool
    var savedVideos: [VideoEntity] = []
    //Jävla Star Wars utan :
    XMLItems.removeLast()
    for item in XMLItems {
        (keepAddingItems, video) = dataController.saveFeedItem(item)
        if(keepAddingItems){
            savedVideos.append(video)
        }
        else{
            break;
        }
    }
    return savedVideos;
}
}