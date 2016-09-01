//
//  FLTranslucentBaseController.m
//  OC_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLTranslucentBaseController.h"
#import "FLTranslucentNavigationBar.h"
#import "FLTranslucentNavigationController.h"
typedef enum{
    FLActionStatusViewAppear,
    FLActionStatusViewDisappear
}FLActionStatus;
@interface FLTranslucentBaseController ()
// 当前导航栏是否透明
@property (nonatomic,assign)BOOL currentBarTranslucent;

// 假的nav
@property (nonatomic,strong)FLTranslucentNavigationBar *bar;

@end

@implementation FLTranslucentBaseController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    if (!self.currentBarTranslucent) {
        self.currentBarTranslucent = self.navigationController.navigationBar.translucent;
    }
    self.navigationController.navigationBar.translucent = YES;
    [self removeFalseBar];
    if (![self.navigationController isKindOfClass:[FLTranslucentNavigationController class]]) {
        NSLog(@"不是配套导航控制器");
    }
    FLTranslucentNavigationController *nav = (FLTranslucentNavigationController *)self.navigationController;
    if (nav.fl_shouldAddFalseNavigationBar) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self addFalseBarStatus:FLActionStatusViewAppear];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    if (!self.fl_isUserTranslucentNavigationBar) {
        self.navigationController.navigationBar.barStyle = [UINavigationBar appearance].barStyle;
        self.navigationController.navigationBar.translucent = self.currentBarTranslucent;
        [self.navigationController.navigationBar setBackgroundImage:[[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    }
    else{
        self.navigationController.navigationBar.translucent = YES;
    }
    [self removeFalseBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeFalseBar];
    FLTranslucentNavigationController *nav = (FLTranslucentNavigationController *)self.navigationController;
    if (nav.fl_shouldAddFalseNavigationBar) {
        [self addFalseBarStatus:FLActionStatusViewDisappear];
    }
}

- (void)addFalseBarStatus:(FLActionStatus)status{
    if (self.fl_isUserTranslucentNavigationBar) {
        self.bar.shadowImage = [[UIImage alloc] init];
        [self.bar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        self.bar.translucent = YES;
    }
    else{
        [self.bar setBackgroundImage:[[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
        self.bar.translucent = self.currentBarTranslucent;
    }
    self.bar.barStyle = [UINavigationBar appearance].barStyle;
    [self.view addSubview:self.bar];
    self.bar.frame = CGRectMake(0, self.bar.translucent ? 0 : (status == FLActionStatusViewAppear ? 0 : -64), [UIScreen mainScreen].bounds.size.width, 64);
    
}

- (void)removeFalseBar{
    [self.bar removeFromSuperview];
    self.bar = nil;
}

#pragma mark -- Setter & Getter
- (FLTranslucentNavigationBar *)bar{
    if (_bar == nil) {
        _bar = [[FLTranslucentNavigationBar alloc] init];
    }
    return _bar;
}

- (void)setFl_isUserTranslucentNavigationBar:(BOOL)fl_isUserTranslucentNavigationBar{
    _fl_isUserTranslucentNavigationBar = fl_isUserTranslucentNavigationBar;
    [self addFalseBarStatus:FLActionStatusViewAppear];
}

@end
