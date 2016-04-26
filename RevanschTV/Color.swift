//
//  ColorSeason.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 24/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//
import UIKit
import Foundation

let commentColor: UIColor = UIColor(red:0.12, green:0.12, blue:0.12, alpha:1.0)
let replyColor: UIColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)


let alpha = CGFloat(0.25)
let colorArray: [UIColor] = [UIColor(red:0.42, green:0.15, blue:0.34, alpha: alpha),    //Other
                             UIColor(red:0.04, green:0.58, blue:1.0, alpha: alpha),     //Season 1
                             UIColor(red:0.38, green:0.89, blue:0.32, alpha: alpha),    //Season 2
                             UIColor(red:0.99, green:0.15, blue:0.0, alpha: alpha),     //Season 3
                             UIColor(red:0.04, green:0.2, blue:0.93, alpha: alpha),     //Season 4
                             UIColor(red:0.85, green:0.52, blue:1.0, alpha: alpha)]     //Season 5


func colorForSeason(seasonEpisode: String) -> UIColor{
    if(seasonEpisode[seasonEpisode.startIndex] == "S"){
        let season: String = seasonEpisode[seasonEpisode.startIndex.advancedBy(1)..<seasonEpisode.startIndex.advancedBy(3)]
        return colorArray[Int(season)!%colorArray.count]
    }
    else{
        return colorArray[0]
    }
}