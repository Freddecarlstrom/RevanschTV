//
//  XMLParser.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 10/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import SWXMLHash

class XMLParser{
    
    func parseXML(dataToParse: NSData) throws -> [XMLItem]{
        let xml = SWXMLHash.parse(dataToParse)
        
        let items: [XMLItem] = try xml["feed"]["entry"].value()
        print("Parse SUCCESS!")
        return items
    }
    
    func parseXMLPlaylist(parse: NSData) throws -> [XMLPlaylist]{
        print(parse)
        let xml = SWXMLHash.parse(parse)
        print("BLA: \(xml)")
        let items: [XMLPlaylist] = try xml["items"].value()
        print("PARSE SUCCESS")
        return items
    }
}