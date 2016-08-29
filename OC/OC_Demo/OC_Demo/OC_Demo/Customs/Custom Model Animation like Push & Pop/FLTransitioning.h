//
//  FLTransitioning.h
//  customModal
//
//  Created by 孔凡列 on 16/5/4.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FLTransitioning : NSObject <UIViewControllerTransitioningDelegate>

// 创建一个单例实例

+ (instancetype) sharedTransitioning;

@property (nonatomic,assign,getter=isFromLeft)BOOL fromLeft;

@end
