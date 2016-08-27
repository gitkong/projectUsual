//
//  CZCacheManager.h
//  clearCacheDemo
//
//  Created by 孔凡列 on 16/2/27.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLCacheManager : NSObject
//获得缓存
+ (NSString *)getCache;
// 清除缓存
+ (void)clearCache;

@end
