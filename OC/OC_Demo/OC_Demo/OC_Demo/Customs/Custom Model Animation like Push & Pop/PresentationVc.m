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
{
    UIView *coverView;
}

#pragma mark - 设置大小的frame，自定义动画时无用
- (CGRect)frameOfPresentedViewInContainerView{
    return CGRectMake(10, 20, 200, 200);
}

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        // 添加一些特效什么的~~~这里简单添加了一个遮盖的view，简单做效果演示
        coverView = [[UIView alloc] init];
        coverView.backgroundColor = [UIColor redColor];
        coverView.alpha = 0.0;
    }
    return self;
}

/**
 *  @author 孔凡列, 16-09-02 05:09:36
 *
 *  准备present
 */
- (void)presentationTransitionWillBegin{
    NSLog(@"present will begin");
    // 最重要的 最重要的 最重要的 添加要present的view到容器里面，不然无法present，因为系统都不知道present什么
    [self.containerView addSubview:self.presentedView];
    
    // 简单添加效果
    coverView.frame = self.containerView.bounds;
    [self.containerView addSubview:coverView];
    
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        coverView.alpha = 1;
    } completion:nil];
}
/**
 *  @author 孔凡列, 16-09-02 06:09:12
 *
 *  present 结束
 *
 *  @param completed completed description
 */
- (void)presentationTransitionDidEnd:(BOOL)completed{
    NSLog(@"present did end");
    if(!completed){
        [coverView removeFromSuperview];
    }
}
/**
 *  @author 孔凡列, 16-09-02 06:09:15
 *
 *  准备 dismiss
 */
- (void)dismissalTransitionWillBegin{
    
    NSLog(@"dismiss will begin");
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentingViewController.transitionCoordinator;
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        coverView.alpha = 0.0;
    } completion:nil];
}
/**
 *  @author 孔凡列, 16-09-02 06:09:18
 *
 *  dismiss 结束
 *
 *  @param completed completed description
 */
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    NSLog(@"dismiss did end");
    if(completed){
        [coverView removeFromSuperview];
    }
}

@end