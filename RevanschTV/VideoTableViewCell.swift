//
//  TableViewCell.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 10/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var seasonAndEpisodeLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    let selectionView: UIView = UIView()
    let selectionColor: UIColor = UIColor.init(hexString: "9D7F94")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionView.backgroundColor = selectionColor
        selectedBackgroundView = selectionView
    }
    
}

extension UIColor{
    convenience init (hexString:String) {
        var cleanString:String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cleanString.hasPrefix("#")) {
            cleanString = cleanString.substringFromIndex(cleanString.startIndex.advancedBy(1))
        }
        
        if (cleanString.characters.count != 6) {
            self.init()
        }
        else{
            var rgbValue = UInt32()
            let scanner = NSScanner(string: cleanString)
            scanner.scanHexInt(&rgbValue)
            
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16)/255.0,
                green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0,
                blue: CGFloat(rgbValue & 0xFF)/255.0,
                alpha: 1.0)
        }
    }
}

