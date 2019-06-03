//
//  UIColor+Giphy.swift
//  GiphyViewer
//
//  Created by Enrique Bermúdez on 6/2/19.
//  Copyright © 2019 Enrique Bermúdez. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var randomGiphyColor: UIColor {
        
        var colors = [UIColor(red: 252.0/255, green: 77.0/255, blue: 83.0/255, alpha: 1.0),
                     UIColor(red: 133.0/255, green: 0.0/255, blue: 255.0/255, alpha: 1.0),
                     UIColor(red: 33.0/255, green: 255.0/255, blue: 135.0/255, alpha: 1.0),
                     UIColor(red: 254.0/255, green: 244.0/255, blue: 75.0/255, alpha: 1.0)]
        return colors[Int(arc4random_uniform(UInt32(colors.count)))]

    }
}
