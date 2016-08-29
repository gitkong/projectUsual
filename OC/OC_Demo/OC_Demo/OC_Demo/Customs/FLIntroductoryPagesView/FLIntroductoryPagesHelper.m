//
//  FLIntroductoryPagesHelper.m
//  test
//
//  Created by 孔凡列 on 16/8/20.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLIntroductoryPagesHelper.h"
#import "FLIntroductoryPageView.h"

@interface FLIntroductoryPagesHelper ()
@property (nonatomic) UIWindow *rootWindow;
@property(nonatomic,strong)FLIntroductoryPageView *curIntroductoryPagesView;
@end

@implementation FLIntroductoryPagesHelper
+ (instancetype)shareInstance
{
    static FLIntroductoryPagesHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[FLIntroductoryPagesHelper alloc] init];
    });
    
    return shareInstance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+(void)showIntroductoryPageView:(NSArray *)imageArray
{
    if (![FLIntroductoryPagesHelper shareInstance].curIntroductoryPagesView) {
        [FLIntroductoryPagesHelper shareInstance].curIntroductoryPagesView =[[FLIntroductoryPageView alloc]initPagesViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) Images:imageArray];
    }
    
    [FLIntroductoryPagesHelper shareInstance].rootWindow = [self lastWindow];
    [[FLIntroductoryPagesHelper shareInstance].rootWindow addSubview:[FLIntroductoryPagesHelper shareInstance].curIntroductoryPagesView];
    
}

+ (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}

@end
