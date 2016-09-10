//
//  FLTransitionManager.h
//  Custom Modal
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
// present direction
typedef enum{
    FLPresentTypeFromLeft,
    FLPresentTypeFromRight
}FLPresentType;

// present direction
typedef enum{
    FLDismissTypeFromLeft,
    FLDismissTypeFromRight
}FLDismissType;

@interface FLTransitionManager : NSObject <UIViewControllerTransitioningDelegate>

/**
 *  @author 孔凡列, 16-09-02 04:09:56
 *
 *  present direction
 */
@property (nonatomic,assign)FLPresentType fl_presentType;
/**
 *  @author 孔凡列, 16-09-02 04:09:05
 *
 *  dismiss direction
 */
@property (nonatomic,assign)FLDismissType fl_dismissType;

// 创建一个单例实例

+ (instancetype)shareManager;

@end
