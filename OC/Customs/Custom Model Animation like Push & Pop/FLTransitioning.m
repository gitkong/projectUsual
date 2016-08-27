//
//  FLTransitioning.m
//  customModal
//
//  Created by 孔凡列 on 16/5/4.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "FLTransitioning.h"
#import "FLAnimatedTransitioning.h"
#import "PresentationVc.h"

@interface FLTransitioning ()

@end

@implementation FLTransitioning

static id _instance = nil;

+ (instancetype) sharedTransitioning{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

#pragma mark - PrsentView的
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    PresentationVc *vc = [[PresentationVc alloc] initWithPresentedViewController:presented presentingViewController:presenting];
//    if (self.fromLeft) {
//        vc.fromLeft = YES;
//    }
//    else{
//        vc.fromLeft = NO;
//    }
    return vc;
}


#pragma mark - 开始动画调用
- (id )animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    FLAnimatedTransitioning *startA = [[FLAnimatedTransitioning alloc] init];
    startA.presented = YES;
    if (self.fromLeft) {
        startA.presentDirectionType = FLPresentedDirectionTypeFromLeft;
    }
    else{
        startA.presentDirectionType = FLPresentedDirectionTypeFromRight;
    }
    return startA;
}

#pragma mark - disMiss调用
- (id )animationControllerForDismissedController:(UIViewController *)dismissed{
    FLAnimatedTransitioning *endA = [[FLAnimatedTransitioning alloc] init];
    endA.presented = NO;
    endA.presentDirectionType = FLPresentedDirectionTypeFromRight;
    return endA;
}

@end