//
//  FLAnimatedTransitioning.h
//  customModal
//
//  Created by 孔凡列 on 16/5/4.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    FLPresentedDirectionTypeFromLeft,// 从左往右
    FLPresentedDirectionTypeFromRight// 从右往左
}FLPresentedDirectionType;

@interface FLAnimatedTransitioning : NSObject

// 是否是开始modal进来的
@property (nonatomic , assign) BOOL presented;


@property (nonatomic,assign)FLPresentedDirectionType presentDirectionType;



@end
