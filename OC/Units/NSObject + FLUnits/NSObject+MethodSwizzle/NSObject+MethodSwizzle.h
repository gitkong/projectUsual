//
//  NSObject+MethodSwizzle.h
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzle)

// 返回所有方法数组
+(NSArray*)fl_methodList;

#pragma mark - 交换方法
+ (BOOL)fl_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;

+ (BOOL)fl_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_;


@end
