//
//  CommentTableCell.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 22/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import UIKit
import Foundation

class CommentTableCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var commentLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    
    func configureCell(commentItem: CommentItem){
        self.nameLabel?.text = commentItem.name
        self.commentLabel?.text = commentItem.comment
        self.dateLabel?.text = commentItem.publishedAt
    }
}