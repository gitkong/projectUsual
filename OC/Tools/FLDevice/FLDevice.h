//
//  CZDeviceModel.h
//  logistics
//
//  Created by 孔凡列 on 16/3/31.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLDevice : NSObject
/**
 *  获得手机型号（具体）
 */
+ (NSString*)deviceVersion;
/**
 *  获取手机MAC地址
 */
+ (NSString *)getMacAddress;

+ (NSString *) get_uuid;

//获取手机的网络的ip地址
+ (NSString *)getIPAddress;

@end
