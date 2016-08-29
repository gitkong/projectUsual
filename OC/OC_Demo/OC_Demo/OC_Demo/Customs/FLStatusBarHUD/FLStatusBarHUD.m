//
//  FLStatusBar.m
//  logistic
//
//  Created by 孔凡列 on 16/2/24.
//  Copyright © 2016年 clarence All rights reserved.
//

#import "FLStatusBarHUD.h"
@implementation FLStatusBarHUD

#define FLStatusBarWidth [UIScreen mainScreen].bounds.size.width
/*------------------------全局变量-----------------------*/
/** 全局窗口 */
static UIWindow *_window;
/** 全局按钮 */
static UIButton *_button;
/** loading状态下的label */
static UILabel *_loadingLabel;
/** 定时器 */
static NSTimer *_timer;
/** 指示器 */
static UIActivityIndicatorView *_indicatorView;
/*------------------------常量-----------------------*/
/** 状态栏整个的高度 */
static CGFloat const FLStatusBarHeight = 40;
/** 按钮左边的间距 */
static CGFloat const FLStatusBarImageEdgeLeftInsert = 10;
/** 动画时间 */
static NSTimeInterval const FLAnimationDuration = 0.25;
/** 消息停留时间 */
static NSTimeInterval const FLMessageDuration = 2;
/** 文字的大小*/
static CGFloat const FLStatusBarTitleFontSize = 12;


/** 显示消息的方法 */
+ (void)fl_showMessage:(NSString *)message image:(UIImage *)image autoDismiss:(BOOL)flag{
//    if (_window) {
//        return;
//    }
    //停止定时器
    [self invalidateTimer];
    // 隐藏状态栏
    _window = nil;
    //设置窗口
    [self setupWindow];
    //创建按钮
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.titleLabel.font = [UIFont systemFontOfSize:FLStatusBarTitleFontSize];
    [_button setTitle:message forState:UIControlStateNormal];
    if (image) {
        [_button setImage:image forState:UIControlStateNormal];
    }
    _button.titleEdgeInsets = UIEdgeInsetsMake(0, FLStatusBarImageEdgeLeftInsert, 0, 0);
    _button.frame = _window.bounds;
    [_window addSubview:_button];
    if (flag) {
        //开启定时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:FLMessageDuration target:self selector:@selector(fl_hide) userInfo:nil repeats:NO];
    }
    else{
        [_timer invalidate];
        _timer = nil;
    }
}

/** 显示成功的文字和图片 */
+ (void)fl_showSuccessWithStatus:(NSString *)status image:(UIImage *)image autoDismiss:(BOOL)flag{
    
    [self fl_showMessage:status image:image autoDismiss:flag];
    
    
}
/** 显示成功的文字采用默认的图片 */
+ (void)fl_showSuccessWithStatus:(NSString *)status autoDismiss:(BOOL)flag {
    
    [self fl_showMessage:status image:[UIImage imageNamed:@"FLStatusBarHUD.bundle/success"]autoDismiss:flag];
}

/** 显示失败的文字 */
+ (void)fl_showErrorWithStatus:(NSString *)status autoDismiss:(BOOL)flag {
    
    [self fl_showMessage:status image:[UIImage imageNamed:@"FLStatusBarHUD.bundle/error"] autoDismiss:flag];
}

+ (void)fl_showStatus:(NSString *)status autoDismiss:(BOOL)flag{
    
    [self fl_showMessage:status image:nil autoDismiss:flag];
    
}

/** 显示失败的文字和图片 */
+ (void)fl_showErrorWithStatus:(NSString *)status image:(UIImage *)image autoDismiss:(BOOL)flag {
    
    [self fl_showMessage:status image:image autoDismiss:flag];
}
/** 显示正在加载的文字 */
+ (void)fl_showLoadingWithStatus:(NSString *)status {
    
    [self invalidateTimer];
    [self setupWindow];
    _loadingLabel = [[UILabel alloc] init];
    _loadingLabel.text = status;
    _loadingLabel.frame = _window.bounds;
    _loadingLabel.textAlignment = NSTextAlignmentCenter;
    _loadingLabel.font = [UIFont systemFontOfSize:FLStatusBarTitleFontSize];
    _loadingLabel.textColor = [UIColor whiteColor];
    [_window addSubview:_loadingLabel];
    CGSize loadingLabelTextSize = [_loadingLabel.text sizeWithAttributes:@{NSFontAttributeName:_loadingLabel.font}];
    //创建网络状态指示器
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //开启动画
    [_indicatorView startAnimating];
    CGRect frame = _indicatorView.frame;
    frame.origin.x = (FLStatusBarWidth - loadingLabelTextSize.width) * 0.5 - _indicatorView.frame.size.width;
    frame.origin.y = (40 - _indicatorView.bounds.size.height) / 2;
    _indicatorView.frame = frame;
    
    [_window addSubview:_indicatorView];
}

#pragma mark - 内部方法
+ (void)setupWindow{
    
    _window.hidden = YES;
    _window = [[UIWindow alloc]init];
    
    _window.frame = CGRectMake(0, -FLStatusBarHeight, FLStatusBarWidth, FLStatusBarHeight);
    _window.backgroundColor = [UIColor orangeColor];
    _window.windowLevel = UIWindowLevelStatusBar;
    //window比较特殊hidden等于NO 就会将window显示出来
    _window.hidden = NO;
    //动画
    [UIView animateWithDuration:FLAnimationDuration animations:^{
        _window.transform = CGAffineTransformMakeTranslation(0, FLStatusBarHeight);
    }];
}


/** 隐藏状态栏 */
+ (void)fl_hide {
    if (_indicatorView) {
        //开启动画
        [_indicatorView stopAnimating];
    }
    [UIView animateWithDuration:FLAnimationDuration animations:^{
        _window.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self invalidateTimer];
        _window = nil;
    }];
}
/** 销毁定时器 */
+ (void)invalidateTimer {
    [_timer invalidate];
    _timer = nil;
}


+ (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    _window.backgroundColor = backgroundColor;
    
}

@end
