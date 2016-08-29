//
//  UINavigationBar+NavigationBarBackground.h
//
//  Created by 孔凡列 on 16/7/12.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (NavigationBarBackground)

/**
 *  设置NavigationBar的私有属性backgroundView的背景颜色
 *
 */
- (void)fl_setBackgroundViewWithColor:(UIColor *)backgroundColor;


/**
 *  设置NavigationBar的背景透明度
 * */
- (void)fl_setBackgroundViewWithAlpha:(CGFloat)alpha;

/**
 *  重设NavigationBar的背景样式为默认的样式
 */
- (void)fl_resetBackgroundDefaultStyle;

@end
