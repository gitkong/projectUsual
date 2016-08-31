//
//  UIViewController_FLUnits.swift
//  Swift_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum FLTransationStyle : String{
        case modal = "modal"
        case push = "push"
    }
    /**
     多层present 嵌套，返回到首次present的控制器
     
     - author: 孔凡列
     - date: 16-09-01 02:09:03
     */
    func fl_dismissToTop() {
        var viewController = self as UIViewController
        // find
        while (viewController.presentingViewController != nil) {
            if viewController.isKindOfClass(UIViewController.self) {
                viewController = viewController.presentingViewController!
            }
            else {
                break
            }
        }
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    /**
     截屏,暂不提供
     
     - author: 孔凡列
     - date: 16-09-01 02:09:30
     
     - returns: return value description
     */
    private func fl_snip() -> UIImageView {
        UIGraphicsBeginImageContext(self.view.bounds.size)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageView = UIImageView.init(image: image)
        return imageView
    }
    
    /**
     判断跳转的方式，是modal还是push
     
     - author: 孔凡列
     - date: 16-09-01 02:09:08
     
     - returns: return value description
     */
    func fl_transationStyle() -> FLTransationStyle {
        var viewControllers : [UIViewController] = (self.navigationController?.viewControllers)!
        if self.isKindOfClass(UINavigationController.self) {
            let nav = self as! UINavigationController
            viewControllers = nav.viewControllers
        }
        if viewControllers.count > 1 {
            if viewControllers.last == self {
                return FLTransationStyle.push
            }
            else{
                return FLTransationStyle.modal
            }
        }
        else{
            return FLTransationStyle.modal
        }
    }
}