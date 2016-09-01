//
//  FLTranslucentNavigationController.m
//  OC_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLTranslucentNavigationController.h"
#import "FLTranslucentBaseController.h"
@interface FLTranslucentNavigationController ()

@end

@implementation FLTranslucentNavigationController

//- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
//    if (self = [super initWithRootViewController:rootViewController]) {
//        [self pushViewController:rootViewController animated:NO];
//    }
//    return self;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    FLTranslucentBaseController * currentVc = (FLTranslucentBaseController *)self.viewControllers.lastObject;
    if (self.viewControllers.count > 0) {
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    FLTranslucentBaseController *vc = (FLTranslucentBaseController *)viewController;
    if (!vc.fl_isUserTranslucentNavigationBar && currentVc == nil ? YES : !currentVc.fl_isUserTranslucentNavigationBar) {
        self.fl_shouldAddFalseNavigationBar = NO;
    }
    else{
        self.fl_shouldAddFalseNavigationBar = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    FLTranslucentBaseController * currentVc = (FLTranslucentBaseController *)self.viewControllers.lastObject;
    FLTranslucentBaseController *previousVc = (FLTranslucentBaseController *)self.viewControllers[self.viewControllers.count - 2];
    if (!currentVc.fl_isUserTranslucentNavigationBar && !previousVc.fl_isUserTranslucentNavigationBar){
        self.fl_shouldAddFalseNavigationBar = NO;
    }
    else{
        self.fl_shouldAddFalseNavigationBar = YES;
    }
    
    return [super popViewControllerAnimated:animated];
}

@end
