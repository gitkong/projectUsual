//
//  FLAdvertiseHelper.h
//  test
//
//  Created by 孔凡列 on 16/8/20.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAdvertiseNotificationContants.h"
@interface FLAdvertiseHelper : NSObject

+ (instancetype)fl_sharedInstance;

+(void)fl_showAdvertiserView:(NSArray *)imageArray;

@end
