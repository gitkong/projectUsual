//
//  FLTransitionManager.m
//  Custom Modal
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLTransitionManager.h"
// 具体动画实例
#import "FLTransitionAnimation.h"
// 自定义用来控制 controller 之间的跳转特效 控制器
#import "FLPresentationController.h"

@interface FLTransitionManager ()

@end

@implementation FLTransitionManager

static FLTransitionManager *_instance = nil;
+ (instancetype)shareManager{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
            // 设置默认值
            _instance.fl_presentType = FLPresentTypeFromRight;
            _instance.fl_dismissType = FLDismissTypeFromLeft;
        });
    }
    return _instance;
}

/**
 *  @author 孔凡列, 16-09-02 05:09:10
 *
 *  present 调用
 *
 *  @param presented  被 present 的控制器
 *  @param presenting 正在 present 的控制器
 *  @param source     The view controller whose presentViewController:animated:completion: method was called. 就是调present那个控制器
 *
 *  @return 返回一个动画实例
 */
- (id )animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    FLTransitionAnimation *presentA = [[FLTransitionAnimation alloc] init];
    presentA.fl_transitionAnimationType = FLTransitionAnimationTypePresent;
    if (self.fl_presentType == FLPresentTypeFromLeft) {
        presentA.fl_presentDirectionType = FLPresentDirectionTypeFromLeft;
    }
    else{
        presentA.fl_presentDirectionType = FLPresentDirectionTypeFromRight;
    }
    return presentA;
}

/**
 *  @author 孔凡列, 16-09-02 05:09:20
 *
 *  dismiss 调用
 *
 *  @param dismissed 要dismiss的控制器
 *
 *  @return 返回一个动画实例
 */
- (id )animationControllerForDismissedController:(UIViewController *)dismissed{
    FLTransitionAnimation *dismissA = [[FLTransitionAnimation alloc] init];
    dismissA.fl_transitionAnimationType = FLTransitionAnimationTypeDismiss;
    if (self.fl_dismissType == FLDismissTypeFromLeft) {
        dismissA.fl_dismissDirectionType = FLDismissDirectionTypeFromLeft;
    }
    else if (self.fl_dismissType == FLDismissTypeFromRight){
        dismissA.fl_dismissDirectionType = FLDismissDirectionTypeFromRight;
    }
    return dismissA;
}

/**
 *  @author 孔凡列, 16-09-02 05:09:19
 *
 *  返回一个 用来控制 controller 之间的跳转特效 的控制器 （注意此API是 iOS8之后才有）
 *
 *  @param presented  被 present 的控制器
 *  @param presenting 正在 present 的控制器
 *  @param source     谁调present
 *
 *  @return 返回一个 用来控制 controller 之间的跳转特效 的控制器
 */
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    return [[FLPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
