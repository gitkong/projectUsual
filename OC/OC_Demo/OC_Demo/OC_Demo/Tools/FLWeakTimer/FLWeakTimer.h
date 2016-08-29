//
//  FLWeakTimer.h
//
//  Created by 孔凡列 on 15/9/13.
//  Copyright (c) 2015年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  自定义block的创建
 *
 *  @param userInfo 外界传入的参数，id类型，可以传任意东西
 */
typedef void(^FLWeakTimerBlock)(id userInfo);

@interface FLWeakTimer : NSObject
/**
 *  类方法：重写系统提供的NSTimer的创建方法
 *
 *  描述：实现这个方法，外界不需要手动开启时钟，不需要手动添加到runLoop中
 *
 *  重要：外界不需要手动销毁定时器，此时定时器不会对监听的target进行强引用，此时这个target（控制器）可以被销毁。当定时器所在的控制器被销毁的时候，定时器就会被销毁
 *
 *  @param ti        定时器的时间间隔
 *  @param aTarget   监听定时器的对象
 *  @param aSelector 监听定时器的对象回调方法
 *  @param userInfo  监听定时器的对象回调方法的参数（如果方法有参数，传参，如果没，传nil）
 *  @param yesOrNo   是否重复执行（一般YES）
 *
 *  @return 返回一个新的NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
/**
 *  类方法：自定义创建NSTimer的创建方法
 *
 *  描述：实现这个方法，外界不需要手动开启时钟，不需要手动添加到runLoop中
 *
 *  重要：此时使用这个方法，外界必须要手动销毁定时器，此时定时器不会对监听的target进行强引用，此时这个target（控制器）可以被销毁，但定时器不会跟着target控制器的销毁而销毁。
 *
 *
 *  @param ti             定时器的时间间隔
 *  @param aTarget        监听定时器的对象
 *  @param aSelector      监听定时器的对象回调方法
 *  @param weakTimerBlock 要实现的功能代码的block
 *  @param userInfo       监听定时器的对象回调方法的参数（如果方法有参数，传参，如果没，传nil）
 *  @param yesOrNo        是否重复执行（一般YES）
 *
 *  @return 返回一个新的NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector block:(FLWeakTimerBlock)weakTimerBlock userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
@end
