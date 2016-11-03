//
//  UINavigationBar+NavigationBarBackground.m
//
//  Created by 孔凡列 on 16/7/12.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "UINavigationBar+NavigationBarBackground.h"

#import <objc/runtime.h>

@implementation UINavigationBar (NavigationBarBackground)

static char navigationBar_BackgroundImage;

-(UIImage*)navigationBarBackgroundImage{
    return objc_getAssociatedObject(self, &navigationBar_BackgroundImage);
}

-(void)setNavigationBarBackgroundImage:(UIImage*)navigationBarBackgroundImage{
    objc_setAssociatedObject(self, &navigationBar_BackgroundImage, navigationBarBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)fl_setBackgroundViewWithColor:(UIColor *)backgroundColor{
    // 没有才创建
    if (!self.navigationBarBackgroundImage) {
        self.barStyle = UIBarStyleBlack;
        // 透明
        [self fl_setBackgroundViewSubViewAlpha:0];
        // 设置图片背景
        [self fl_backgroundView:[[UIImage alloc] init]];
    }
    // KVC
    UIView *backgroundViewObject = [self valueForKey:@"backgroundView"];
    // 设置背景颜色
    backgroundViewObject.layer.backgroundColor = backgroundColor.CGColor;

}

- (void)fl_setBackgroundViewWithAlpha:(CGFloat)alpha{
    if (!self.navigationBarBackgroundImage) {
        [self fl_backgroundView:[[UIImage alloc] init]];
    }
    UIView *backgroundViewObject = [self valueForKey:@"backgroundView"];
    
    backgroundViewObject.alpha = alpha;
    
}


- (void)fl_resetBackgroundDefaultStyle{
    if (self.navigationBarBackgroundImage) {
        [self fl_backgroundView:nil];
    }
    [self fl_setBackgroundViewSubViewAlpha:1];
    self.barStyle = UIBarStyleDefault;
}


-(void)fl_setBackgroundViewSubViewAlpha:(CGFloat)alpha{
    // 通过KVC拿到这个属性，然后对其子控件进行修改
    UIView *backgroundViewObject = [self valueForKey:@"backgroundView"];
    for (UIView* childView in backgroundViewObject.subviews) {
        childView.alpha = alpha;
    }
}

#pragma mark -- private method
- (void)fl_backgroundView:(UIImage *)image{
    // 保存
    self.navigationBarBackgroundImage = image;
    [self setBackgroundImage:image
               forBarMetrics:UIBarMetricsDefault];
}

@end
