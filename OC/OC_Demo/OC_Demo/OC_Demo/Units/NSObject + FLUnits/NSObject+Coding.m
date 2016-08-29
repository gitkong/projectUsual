//
//  NSObject+Coding.m
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "NSObject+Coding.h"
#import <objc/runtime.h>
@implementation NSObject (Coding)

- (void)encode:(NSCoder *)encoder{
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [encoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

- (void)decode:(NSCoder *)decoder{
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [self setValue:[decoder decodeObjectForKey:key] forKey:key];
    }
}
@end
