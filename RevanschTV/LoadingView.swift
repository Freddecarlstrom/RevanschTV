//
//  LoadingView.swift
//  RevanschTV
//
//  Created by Fredrik Carlström on 18/04/16.
//  Copyright © 2016 Fredrik Carlström. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "LoadingView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
}
