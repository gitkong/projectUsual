//
//  FLIntroductoryPagesHelper.h
//  test
//
//  Created by 孔凡列 on 16/8/20.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLIntroductoryPageView;
@interface FLIntroductoryPagesHelper : NSObject

+ (instancetype)shareInstance;

+(void)showIntroductoryPageView:(NSArray *)imageArray;
@end
