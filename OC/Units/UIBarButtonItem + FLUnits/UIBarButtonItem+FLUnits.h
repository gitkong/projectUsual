//
//  UIBarButtonItem+FLUnits.h
//
//  Created by 孔凡列 on 16/7/12.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <UIKit/UIKit.h>

//设置barButtonItem的文本内容
extern NSString *const FLTitleAttributeName;
//设置barButtonItem的文本字体
extern NSString *const FLTitleFontAttributeName;
//设置barButtonItem的文本默认颜色
extern NSString *const FLColorAttributeName;
//设置barButtonItem的文本高亮颜色
extern NSString *const FLHighLightColorAttributeName;

@interface UIBarButtonItem (FLUnits)
/**
 *  返回一个只是显示  图片  的barButtonItem
 *
 *  @param icon          默认显示图片
 *  @param HighlightIcon 高亮显示图片
 *  @param target        按钮的点击处理者
 *  @param action        响应事件
 *
 */
+ (instancetype)fl_barButtonItemWithIcon:(NSString *)icon HighlightIcon:(NSString *)HighlightIcon target:(id)target action:(SEL)action;

/**
 设置barButtonItem的文本内容  FLTitleAttributeName
 设置barButtonItem的文本字体  FLTitleFontAttributeName
 设置barButtonItem的文本默认颜色  FLColorAttributeName
 设置barButtonItem的文本高亮颜色  FLHighLightColorAttributeName
 */

/**
 *  返回一个显示文本、图标的item
 *
 *  @param attribute     设置按钮文本以及文本的颜色
 *  @param icon          默认显示的图标，设置为nil则无图标
 *  @param HighlightIcon 高亮状态下的图标
 *  @param target        按钮的点击处理者
 *  @param action        按钮响应事件
 */
+ (instancetype)fl_barButtonItemWithTitleAttribute:(NSDictionary *)attribute Icon:(NSString *)icon HighlightIcon:(NSString *)HighlightIcon target:(id)target action:(SEL)action;
@end
