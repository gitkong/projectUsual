//
//  FLAnimatedTransitioning.m
//  customModal
//
//  Created by 孔凡列 on 16/5/4.
//  Copyright © 2016年 czebd. All rights reserved.
//rrrrr

#import "FLAnimatedTransitioning.h"
#import <UIKit/UIKit.h>
@implementation FLAnimatedTransitioning

// 动画执行的时间
static const CGFloat duration = 0.3;

#pragma mark - 返回动画执行的时间
- (NSTimeInterval)transitionDuration:(id )transitionContext{
    return duration;
}

#pragma mark - 执行动画的具体实例
- (void)animateTransition:(id )transitionContext{
    
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        __block CGRect tempFrame = toView.frame;
        if (self.presentDirectionType == FLPresentedDirectionTypeFromRight) {
            tempFrame.origin.x = toView.frame.size.width;
        }
        else if (self.presentDirectionType == FLPresentedDirectionTypeFromLeft) {
            tempFrame.origin.x = -toView.frame.size.width;
        }
        
        toView.frame = tempFrame;
        
        [UIView animateWithDuration:duration animations:^{
            tempFrame.origin.x = 0;
            toView.frame = tempFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else{
        UIView *toView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        __block CGRect tempFrame = toView.frame;
        [UIView animateWithDuration:duration animations:^{
            if (self.presentDirectionType == FLPresentedDirectionTypeFromRight) {
                tempFrame.origin.x = toView.frame.size.width;
            }
            else if (self.presentDirectionType == FLPresentedDirectionTypeFromLeft) {
                tempFrame.origin.x = -toView.frame.size.width;
            }
            toView.frame = tempFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    
}

@end