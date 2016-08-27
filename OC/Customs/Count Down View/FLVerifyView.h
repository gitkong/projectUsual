//
//  FLVerifyView.h
//  verifyButtonDemo
//
//  Created by 孔凡列 on 15/12/25.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import <UIKit/UIKit.h>
#define FLVerifyViewNormalText @"获取验证码"
#define FLVerifyViewCountDownEndText @"重新获取"
#define FLVerifyViewCountDownUnitText @"秒"
typedef void (^VerifyCountDownCompete)();
@class FLVerifyView;
@protocol FLVerifyViewDelegate <NSObject>
@optional
- (void)fl_didClickVerifyView:(FLVerifyView *)verifyView;

- (void)fl_countDownCompleteInVerifyView:(FLVerifyView *)verifyView;

@end

@interface FLVerifyView : UIView
/**
 *  倒计时时间戳，默认60秒
 */
@property (nonatomic,assign)NSInteger fl_countDownTime;

/**
 *  开始显示的文本
 */
@property (nonatomic,strong)UILabel *fl_normalLabel;
/**
 *  倒计时结束显示的文本
 */
@property (nonatomic,strong)UILabel *fl_countDownCompleteLabel;

/**
 *  倒计时完成回调
 */
@property (nonatomic,copy)VerifyCountDownCompete fl_verifyCountDownCompete;

@property (nonatomic,weak)id <FLVerifyViewDelegate>fl_delegate;


// 销毁
- (void)invalidateVeritifyView;


@end
