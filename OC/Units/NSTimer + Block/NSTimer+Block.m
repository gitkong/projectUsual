//
//  NSTimer+Block.m
//  FLTimerDemo
//
//  Created by clarence on 16/10/11.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)
+ (NSTimer *)fl_timer:(NSTimeInterval)interval repeat:(BOOL)repeat handle:(void(^)(NSTimer *timer))handle{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(operationBlock:) userInfo:handle repeats:repeat];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    if ([NSRunLoop currentRunLoop] != [NSRunLoop mainRunLoop]) {
        /**
         *  @author 孔凡列, 16-09-21 08:09:06
         *
         *  子线程就开启当前线程的运行循环
         */
        [[NSRunLoop currentRunLoop] run];
    }
    return timer;
}

+ (void)operationBlock:(NSTimer *)timer{
    void(^block)(NSTimer *timer) = timer.userInfo;
    block(timer);
}
@end
