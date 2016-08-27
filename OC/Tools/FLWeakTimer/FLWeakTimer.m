//
//  FLWeakTimer.m
//
//  Created by 孔凡列 on 15/9/13.
//  Copyright (c) 2015年 clarence. All rights reserved.
//

#import "FLWeakTimer.h"

//设置私有属性－延展
@interface FLWeakTimer ()
/**
 *  真正监听定时器的对象
 */
@property (nonatomic,weak)id aTarget;
/**
 *  真正监听定时器的对象回调方法
 */
@property (nonatomic,assign)SEL aSelector;
/**
 *  定时器
 */
@property (nonatomic,weak)NSTimer *timer;

@end

@implementation FLWeakTimer
/*****************************************方法一******************************************/
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

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo{
//    创建CZWeakTimerTarget对象
    FLWeakTimer *targetObject = [[FLWeakTimer alloc] init];
    targetObject.aTarget = aTarget;
    targetObject.aSelector = aSelector;
//    创建定时器
    targetObject.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:targetObject selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
    return targetObject.timer;
}
/**
 *  定时器的方法回调
 *
 *  @param timer 传入timer，此时这个timer在哪传过来的？？？？？？？，还有userInfo是描述什么而添加的
 *
 *  重要：此时这个timer参数就是当前创建的定时器，此时timer.userInfo就是实现self.aSelector方法中需要传入的参数，例如方法二：此时的timer.userInfo就是@[[weakTimerBlock copy],userInfo]这个数组，正好把这个数组传给timerBlock:方法的参数(NSArray *)userInfo
 *
 */
- (void)fire:(NSTimer *)timer{
//    判断此时target是否传控制器过来了
    if (self.aTarget) {
//        如果传过来了，就执行真正监听定时器的对象回调方法

        if (timer.isValid) {
//            判断此时这个定时器是否被销毁，如果没被销毁才执行
            [self.aTarget performSelector:self.aSelector withObject:timer.userInfo];
        }
        
    }
    else{
//        销毁时钟
        [self.timer invalidate];
        self.timer = nil;
    }
}

/*****************************************方法二******************************************/
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
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector block:(FLWeakTimerBlock)weakTimerBlock userInfo:(id)userInfo repeats:(BOOL)yesOrNo{
    /**
     *  调用上面的第一种方法,改变传入的参数
     *
     *  @param timerBlock:
     *
     *  @param userInfo:
     */
    return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(timerBlock:) userInfo:@[[weakTimerBlock copy],userInfo] repeats:yesOrNo];
}
/**
 *  类方法：定时回调block
 */
+ (void)timerBlock:(NSArray *)userInfo{
//    取得userInfo数组的第一个元素，就是外界传过来的block
    FLWeakTimerBlock block = userInfo[0];
//    如果block是有值的，就往下执行
    if (block) {
//        执行block，因为这个block是有参数的，就把外界传进来的参数userInfo－－就是数组的第二个元素
        block(userInfo[1]);
    }
}
/**
 *  监听FLWeakTimer对象销毁
 */
- (void)dealloc{
    NSLog(@"FLWeakTimer被销毁了");

}




@end
