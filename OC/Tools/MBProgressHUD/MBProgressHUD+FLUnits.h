//
//  MBProgressHUD+FLUnits.h
//  FLToolDemo
//
//  Created by 孔凡列 on 16/7/13.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (FLUnits)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUD;
@end
