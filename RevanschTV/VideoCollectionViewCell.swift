//
//  VideoCollectionViewCell.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 17/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import Foundation
import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var title: UILabel?
    @IBOutlet weak var seasonEpisode: UILabel?
    @IBOutlet weak var colorView: UIView?
    @IBOutlet weak var colorViewTop: UIView?
    var titleString: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func configureCell(video: Video){
        self.title?.text = video.title
        self.seasonEpisode?.text = video.seasonEpisode
        self.backgroundColor = video.color
        self.thumbnail?.image = video.thumbnail
        self.colorView?.hidden = true
        self.colorViewTop?.backgroundColor = video.color
    }
}
