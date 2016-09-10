//
//  FLTransitionAnimation.m
//  Custom Modal
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLTransitionAnimation.h"
@import UIKit;

@interface FLTransitionAnimation () <UIViewControllerAnimatedTransitioning>

@end

@implementation FLTransitionAnimation
// 动画执行的时间
static const CGFloat duration = 0.3;
/**
 *  @author 孔凡列, 16-09-02 04:09:30
 *
 *  返回动画执行的时间
 *
 *  @param transitionContext 实现动画效果时可以从参数transitionContext中获取到切换时的上下文信息，比方说从哪个VC切换到哪个VC等
 *
 *  @return return value description
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return duration;
}

/**
 *  @author 孔凡列, 16-09-02 04:09:25
 *
 *  执行具体动画
 *
 *  @param transitionContext 上下文信息
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.fl_transitionAnimationType == FLTransitionAnimationTypePresent) {
        // 1.get toView
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        // 2.change frame
        __block CGRect tempFrame = toView.frame;
        if (self.fl_presentDirectionType == FLPresentDirectionTypeFromRight) {
            tempFrame.origin.x = toView.frame.size.width;
        }
        else if (self.fl_presentDirectionType == FLPresentDirectionTypeFromLeft) {
            tempFrame.origin.x = -toView.frame.size.width;
        }
        toView.frame = tempFrame;
        // 3.begin animation
        [UIView animateWithDuration:duration animations:^{
            tempFrame.origin.x = 0;
            toView.frame = tempFrame;
        } completion:^(BOOL finished) {
            // 4.Tell context that we completed
            [transitionContext completeTransition:YES];
        }];
    }
    else if (self.fl_transitionAnimationType == FLTransitionAnimationTypeDismiss){
        // 1.get toView
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        // 2.change frame
        __block CGRect tempFrame = fromView.frame;
        // 3.begin animation
        [UIView animateWithDuration:duration animations:^{
            if (self.fl_dismissDirectionType == FLDismissDirectionTypeFromRight) {
                tempFrame.origin.x = -fromView.frame.size.width;
            }
            else if (self.fl_dismissDirectionType == FLDismissDirectionTypeFromLeft) {
                tempFrame.origin.x = fromView.frame.size.width;
            }
            fromView.frame = tempFrame;
        } completion:^(BOOL finished) {
            // 4.Tell context that we completed
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
