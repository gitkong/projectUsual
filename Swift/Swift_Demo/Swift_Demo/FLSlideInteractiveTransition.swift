//
//  FLSlideInteractiveTransition.swift
//  Swift_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

import UIKit

class FLSlideInteractiveTransition: UIPercentDrivenInteractiveTransition {

    var interacting : Bool = true
    
    private var shouldComplete : Bool = true
    
    private var presentVc : UIViewController?
    
    func writeToViewController(viewController : UIViewController) -> () {
        presentVc = viewController
        // 添加手势
        let panG = UIPanGestureRecognizer.init(target: self, action: #selector(FLSlideInteractiveTransition.handleGesture(_:)))
        viewController.view.addGestureRecognizer(panG)
    }
    
    func handleGesture(gesture : UIPanGestureRecognizer) -> () {
        let translation = gesture.translationInView(gesture.view?.superview)
        switch gesture.state {
        case .Began:
            interacting = true
            presentVc?.dismissViewControllerAnimated(true, completion: nil)
            break
        case .Changed:
            var fraction = translation.y / 400
            fraction = CGFloat(fminf(Float(fmaxf(Float(fraction), Float(0.0))), Float(1.0)))
            shouldComplete = fraction > 0.5
            updateInteractiveTransition(fraction)
            break
        case .Ended,.Cancelled:
            interacting = false
            if !shouldComplete || gesture.state == UIGestureRecognizerState.Cancelled {
                cancelInteractiveTransition()
            }
            else{
                finishInteractiveTransition()
            }
            break
        default:
            break
        }
    }
}
