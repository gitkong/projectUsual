//
//  FLStatusBar.h
//  logistic
//
//  Created by 孔凡列 on 16/2/24.
//  Copyright © 2016年 clarence All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLStatusBarHUD : NSObject
/** 背景颜色 */
+ (void)setBackgroundColor:(UIColor *)backgroundColor;

/** 显示文字 */
+ (void)fl_showStatus:(NSString *)status autoDismiss:(BOOL)flag;
/** 显示成功的文字和图片 */
+ (void)fl_showSuccessWithStatus:(NSString *)status image:(UIImage *)image autoDismiss:(BOOL)flag;
/** 显示成功的文字采用默认的图片 */
+ (void)fl_showSuccessWithStatus:(NSString *)status autoDismiss:(BOOL)flag;
/** 显示失败的文字 */
+ (void)fl_showErrorWithStatus:(NSString *)status autoDismiss:(BOOL)flag;
/** 显示失败的文字和图片 */
+ (void)fl_showErrorWithStatus:(NSString *)status image:(UIImage *)image autoDismiss:(BOOL)flag;
/** 显示正在加载的文字 */
+ (void)fl_showLoadingWithStatus:(NSString *)status;

+ (void)fl_hide;



@end
