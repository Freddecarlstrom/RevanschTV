//
//  ColorRandom.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//
import UIKit
import Foundation

func generateRandomData() -> [[UIColor]] {
    return [[UIColor.blueColor(), UIColor.redColor() ], [UIColor.brownColor()]]
}

func generateStrings() -> [[String]] {
    return [["Blå", "Röd"], ["Brun"]]
}
extension UIColor {
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}