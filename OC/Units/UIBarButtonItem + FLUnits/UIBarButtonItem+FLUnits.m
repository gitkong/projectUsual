//
//  UIBarButtonItem+FLUnits.m
//
//  Created by 孔凡列 on 16/7/12.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "UIBarButtonItem+FLUnits.h"
//设置barButtonItem的文本内容
NSString *const FLTitleAttributeName = @"FLTitleAttributeName";
//设置barButtonItem的文本字体
NSString *const FLTitleFontAttributeName = @"FLTitleFontAttributeName";
//设置barButtonItem的文本默认颜色
NSString *const FLColorAttributeName =  @"FLColorAttributeName";
//设置barButtonItem的文本高亮颜色
NSString *const FLHighLightColorAttributeName = @"FLHighLightColorAttributeName";

@implementation UIBarButtonItem (FLUnits)
/**
 *  返回一个只是显示  图片  的barButtonItem
 *
 *  @param icon          默认显示图片
 *  @param HighlightIcon 高亮显示图片
 *  @param target        按钮的点击处理者
 *  @param action        响应事件
 *
 */
+ (instancetype)fl_barButtonItemWithIcon:(NSString *)icon HighlightIcon:(NSString *)HighlightIcon target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:HighlightIcon] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //    设置按钮的大小
    [btn sizeToFit];
    return [[self alloc] initWithCustomView:btn];
}



/**
 设置barButtonItem的文本内容  FLTitleAttributeName
 设置barButtonItem的文本默认颜色  FLColorAttributeName
 设置barButtonItem的文本高亮颜色  FLHighLightColorAttributeName
 */

/**
 *  返回一个显示
 *
 *  @param attribute     设置按钮文本以及文本的颜色
 *  @param icon          默认显示的图标，设置为nil则无图标
 *  @param HighlightIcon 高亮状态下的图标
 *  @param target        按钮的点击处理者
 *  @param action        按钮响应事件
 */
+ (instancetype)fl_barButtonItemWithTitleAttribute:(NSDictionary *)attribute Icon:(NSString *)icon HighlightIcon:(NSString *)HighlightIcon target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    设置按钮的文本
    [btn setTitle:attribute[FLTitleAttributeName] forState:UIControlStateNormal];
    //    设置按钮的文本字体
    btn.titleLabel.font = attribute[FLTitleFontAttributeName];
    //    设置按钮普通状态下的图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    //    设置按钮高亮状态下的图标
    [btn setImage:[UIImage imageNamed:HighlightIcon] forState:UIControlStateHighlighted];
    //    设置按钮的普通状态下的文本颜色
    [btn setTitleColor:attribute[FLColorAttributeName] forState:UIControlStateNormal];
    //    设置按钮的高亮状态的文本颜色
    [btn setTitleColor:attribute[FLHighLightColorAttributeName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //    设置按钮的大小
    [btn sizeToFit];
    //    返回创建自定义的UIBarButtonItem
    return [[self alloc] initWithCustomView:btn];
}
@end
