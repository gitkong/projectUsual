//
//  FLSwipeLeftinteravtiveTransiition.h
//  OC_Demo
//
//  Created by clarence on 16/9/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLSwipeLeftinteravtiveTransiition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;
@end
