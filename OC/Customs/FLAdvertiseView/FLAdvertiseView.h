//
//  FLAdvertiseView.h
//  test
//
//  Created by 孔凡列 on 16/8/20.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kAdscreenWidth [UIScreen mainScreen].bounds.size.width
#define kAdscreenHeight [UIScreen mainScreen].bounds.size.height
#define kAdMain_Screen_Bounds [[UIScreen mainScreen] bounds]
#define kAdUserDefaults [NSUserDefaults standardUserDefaults]

static NSString *const adImageName = @"adImageName";



@interface FLAdvertiseView : UIView
/** 显示广告页面方法*/
- (void)fl_show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;
@end
