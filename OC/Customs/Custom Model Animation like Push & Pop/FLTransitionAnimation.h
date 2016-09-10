//
//  FLTransitionAnimation.h
//  Custom Modal
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>

// present or dismiss
typedef enum{
    FLTransitionAnimationTypePresent,
    FLTransitionAnimationTypeDismiss
}FLTransitionAnimationType;

// present direction
typedef enum{
    FLPresentDirectionTypeFromLeft,
    FLPresentDirectionTypeFromRight
}FLPresentDirectionType;

// present direction
typedef enum{
    FLDismissDirectionTypeFromLeft,
    FLDismissDirectionTypeFromRight
}FLDismissDirectionType;


@interface FLTransitionAnimation : NSObject

/**
 *  @author 孔凡列, 16-09-02 02:09:13
 *
 *  present or dismiss
 */
@property (nonatomic,assign)FLTransitionAnimationType fl_transitionAnimationType;
/**
 *  @author 孔凡列, 16-09-02 04:09:56
 *
 *  present direction
 */
@property (nonatomic,assign)FLPresentDirectionType fl_presentDirectionType;
/**
 *  @author 孔凡列, 16-09-02 04:09:05
 *
 *  dismiss direction
 */
@property (nonatomic,assign)FLDismissDirectionType fl_dismissDirectionType;

@end
