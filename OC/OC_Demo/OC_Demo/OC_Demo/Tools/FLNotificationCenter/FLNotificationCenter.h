//
//  CZNotificationCenter.h
//  logistics
//
//  Created by 孔凡列 on 16/4/1.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLNotificationCenter : NSObject
/**
 *  只是发通知
 *
 *  @param notificationName 通知名
 */
+ (void)postNotificationName:(nonnull NSString *)notificationName;

/**
 *  发通知
 *
 *  @param notificationName 通知名
 *  @param object           传递的参数
 */
+ (void)postNotificationName:(nonnull NSString *)notificationName object:(nullable id)object;

/**
 *  发通知
 *
 *  @param notificationName 通知名
 *  @param object           传递的参数
 *  @param userInfo         传递的字典附加信息
 */
+ (void)postNotificationName:(nonnull NSString *)notificationName object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

/**
 *  接收通知
 *
 *  @param observer         通知接收者
 *  @param selector         方法
 *  @param notificationName 通知名
 *  @param object           传递参数
 */
+ (void)addObserver:(nonnull id)observer selector:(nonnull SEL)selector name:(nullable NSString *)notificationName object:(nullable id)object;

/**
 *  移除通知
 */
+ (void)removeObserver:(nonnull id)observer;

+ (void)removeObserver:(nonnull id)observer name:(nullable NSString *)notificationName object:(nullable id)object;

+ (void)removeObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath context:(nullable void *)content;

+ (void)removeObserver:(nonnull NSObject *)observer forKeyPath:(nonnull NSString *)keyPath;
@end
