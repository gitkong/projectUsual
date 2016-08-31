//
//  FLNormalDismissAnimation.swift
//  Swift_Demo
//
//  Created by clarence on 16/8/31.
//  Copyright © 2016年 clarence. All rights reserved.
//

import UIKit

class FLNormalDismissAnimation: NSObject ,UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.2
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 1.获取目标控制器
        let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        // 2.设置初始位置
        let finalFrame = transitionContext.finalFrameForViewController(toVc!)
        toVc!.view.frame = CGRectOffset(finalFrame, 0, 0)
        
        // 3.添加目标控制器的view到容器中
        let constainView = transitionContext.containerView()
        constainView!.addSubview(toVc!.view)
        
        // 4.开始动画
        let duration = self.transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            toVc?.view.frame = finalFrame
        }) { (true) in
            transitionContext.finishInteractiveTransition()
        }
        
        
        
    }
}
