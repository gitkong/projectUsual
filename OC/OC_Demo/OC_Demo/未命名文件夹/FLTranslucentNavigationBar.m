//
//  FLTranslucentNavigationBar.m
//  OC_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLTranslucentNavigationBar.h"

@implementation FLTranslucentNavigationBar

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            if (view.subviews.count > 1) {
                UIImageView *bottomLine = (UIImageView *)view.subviews[1];
                bottomLine.hidden = YES;
            }
        }
    }
}

@end
