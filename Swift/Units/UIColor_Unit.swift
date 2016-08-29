
//
//  UIColor_Unit.swift
//  Day8-Random Color Gradient
//
//  Created by 孔凡列 on 16/7/14.
//  Copyright © 2016年 clarence. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    class func fl_randomColor() -> UIColor{
        return UIColor.init(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1.0)
    }
    
    class func fl_sameRGB(r : CGFloat,alpha : CGFloat) -> UIColor {
        return UIColor.init(red: r / 255.0, green: r, blue: r, alpha: alpha)
    }
}
