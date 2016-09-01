//
//  SecondViewController.swift
//  Swift_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController ,UIViewControllerTransitioningDelegate{
    let transitionController = FLSlideInteractiveTransition()
    weak var delegate : FLDismissDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "second vc"
        view.backgroundColor = UIColor.grayColor()
        
        let btn = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = UIColor.redColor()
        btn.addTarget(self, action: #selector(SecondViewController.dismiss), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btn)
        
        navigationController?.navigationBar.setBackgroundImage(self.imageWithColor(UIColor.orangeColor()), forBarMetrics: .Default)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func imageWithColor(color : UIColor) -> UIImage {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func dismiss() {
        delegate?.clickToDismiss()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let vc = ThirdViewController()
//        presentViewController(vc, animated: true, completion: nil)
        let nav = UINavigationController.init(rootViewController: vc)
//        presentViewController(nav, animated: true, completion: nil)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FLNormalDismissAnimation()
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transitionController.interacting ? transitionController : nil
    }
    
}
// NSObjectProtocol 或者class，发现自己封装的轮播器里面的delegate也没有用这些，还是可以，为什么
protocol FLDismissDelegate : NSObjectProtocol{
    func clickToDismiss() -> ()
}

