//
//  FLTranlucentRootViewController.m
//  OC_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLTranlucentRootViewController.h"

@interface FLTranlucentRootViewController ()
/**
 *  @author 孔凡列, 16-09-01 10:09:38
 *
 *  假的UINavigationBar
 */
@property (nonatomic,strong)UIView *navBar;
@end

@implementation FLTranlucentRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // key code
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.navBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉分割线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

#pragma mark -- private method
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark -- Setter & Getter
- (UIView *)navBar{
    if (_navBar == nil) {
        _navBar = [[UIView alloc] init];
        _navBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        _navBar.alpha = 0.0;
    }
    return _navBar;
}

- (void)setFl_navBarColor:(UIColor *)fl_navBarColor{
    _fl_navBarColor = fl_navBarColor;
    self.navBar.backgroundColor = fl_navBarColor;
    self.navBar.alpha = 1.0;
}


@end
