//
//  UIView_Unit.swift
//  Day6-Get user's current location
//
//  Created by 孔凡列 on 16/7/11.
//  Copyright © 2016年 clarence. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    var fl_x : CGFloat {
        get {
            return frame.origin.x
        }
        
        set(newX) {
            var rect = frame
            rect.origin.x = newX
            frame = rect
        }
    }
    
    var fl_y : CGFloat {
        get {
            return frame.origin.y
        }
        
        set(newY) {
            var rect = frame
            rect.origin.y = newY
            frame = rect
        }
    }
    
    var fl_width : CGFloat {
        get {
            return frame.size.width
        }
        
        set(newW) {
            var rect = frame
            rect.size.width = newW
            frame = rect
        }
    }
    
    var fl_height : CGFloat {
        get {
            return frame.size.height
        }
        
        set(newH) {
            var rect = frame
            rect.size.width = newH
            frame = rect
        }
    }
    
    
    var fl_centerX : CGFloat {
        get {
            return center.x
        }
        
        set(newCenterX) {
            var cen = center
            cen.x = newCenterX
            center = cen
        }
    }
    
    var fl_centerY : CGFloat {
        get {
            return center.y
        }
        
        set(newCenterY) {
            var cen = center
            cen.y = newCenterY
            center = cen
        }
    }
    
    var fl_top : CGFloat {
        get {
            return self.fl_y
        }
        
        set(newTop) {
            var rect = frame
            rect.origin.y = newTop
            frame = rect
        }
    }
    
    var fl_bottom : CGFloat {
        get {
            return self.fl_y + self.fl_height
        }
        
        set(newTop) {
            var rect = frame
            rect.origin.y = newTop - self.fl_height
            frame = rect
        }
    }
    
    var fl_left : CGFloat {
        get {
            return self.fl_x
        }
        
        set(newLeft) {
            var rect = frame
            rect.origin.x = newLeft
            frame = rect
        }
    }
    
    var fl_right : CGFloat {
        get {
            return self.fl_x + self.fl_width
        }
        
        set(newRight) {
            var rect = frame
            rect.origin.x = newRight - fl_width
            frame = rect
        }
    }
    
    func getFirstResponder() -> UIView {
        if self.isFirstResponder() {
            return self
        }
        for view in self.subviews {
            return view.getFirstResponder()
        }
        return UIView()
    }
}