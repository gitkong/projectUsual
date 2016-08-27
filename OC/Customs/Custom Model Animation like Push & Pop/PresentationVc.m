//
//  PresentationVc.m
//  customModal
//
//  Created by 孔凡列 on 16/5/4.
//  Copyright © 2016年 czebd. All rights reserved.
/////
///fff
#import "PresentationVc.h"

@implementation PresentationVc

#pragma mark - 设置大小的frame，自定义动画时无用
//- (CGRect)frameOfPresentedViewInContainerView{
//    return CGRectMake(10, 20, 200, 200);
//}

#pragma mark - 开始动画添加的
- (void)presentationTransitionWillBegin{
    self.presentedView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.presentedView];
}
- (void)presentationTransitionDidEnd:(BOOL)completed{
    CZLog(@"presentationTransitionDidEnd");
//    if (self.fromLeft) {
//        [self.presentedView removeFromSuperview];
//    }
}
- (void)dismissalTransitionWillBegin{
    CZLog(@"dismissalTransitionWillBegin");
}
#pragma mark - dismiss动画结束后移除的
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    [self.presentedView removeFromSuperview];
    //     NSLog(@"dismissalTransitionDidEnd");
}

@end