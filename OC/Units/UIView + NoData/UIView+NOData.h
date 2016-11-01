//
//  UIView+NOData.h
//  OC_Demo
//
//  Created by clarence on 16/10/29.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 使用注意点：显示另一个无数据界面前必须fl_hideNoDataView当前的无数据界面
 */
@interface UIView (NOData)
#pragma mark - YES-显示无数据页面

/**
 自定义无数据显示界面

 @param customView 自定义界面
 @param operation  点击界面操作
 */
- (void)fl_showNoDataCustomView:(UIView *_Nullable)customView operation:(void (^_Nullable)())operation;

/**
 显示默认无数据界面

 @param imageName 图片名
 @param text      图片下方提示文字
 @param operation 点击图片操作
 */
- (void)fl_showNoDataView:(NSString *_Nullable)imageName text:(NSString *_Nullable)text operation:(void (^_Nullable)())operation;

/**
 显示默认无数据界面，内置默认值，可在m文件中修改

 @param operation 点击图片操作
 */
- (void)fl_showNoDataViewOperation:(void (^_Nullable)())operation;

/**
 隐藏无数据界面
 */
- (void)fl_hideNoDataView;

@end
