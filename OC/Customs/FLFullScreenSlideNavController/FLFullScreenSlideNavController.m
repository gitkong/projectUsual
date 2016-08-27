//
//  FLFullScreenSlideNavController.m
//  FLToolDemo
//
//  Created by 孔凡列 on 16/7/24.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "FLFullScreenSlideNavController.h"

@interface FLFullScreenSlideNavController ()<UIGestureRecognizerDelegate>

@end

@implementation FLFullScreenSlideNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.拿到接收者
    id target = self.interactivePopGestureRecognizer.delegate;
    // 2.拿到侧滑触发的方法
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    // 3.获得添加系统边缘触发手势的view
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    // 4.创建pan手势。作用范围的全屏
    UIPanGestureRecognizer *fullScreenPan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handler];
    fullScreenPan.delegate = self;
    [targetView addGestureRecognizer:fullScreenPan];
    
    // 5.关闭边缘触发手势，防止与原来的边缘手势冲突
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

// 防止导航控制器只有一个rootViewCOntroller的时候触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count == 1 ? NO : YES;
}

@end
