//
//  UITextField+FLPlaceholder.m
//  FLToolDemo
//
//  Created by 孔凡列 on 16/7/13.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "UITextField+FLPlaceholder.h"
//#import <objc/runtime.h>

//static char fl_placeholderColor;
//static char fl_placeholderFont;

@implementation UITextField (FLPlaceholder)

- (void)setFl_placeholderColor:(UIColor *)fl_placeholderColor{
//    objc_setAssociatedObject(self, &fl_placeholderColor, fl_placeholderColor, OBJC_ASSOCIATION_RETAIN);
    [self setValue:fl_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)fl_placeholderColor{
//    UIColor *color = objc_getAssociatedObject(self, &fl_placeholderColor);
    return [self valueForKeyPath:@"_placeholderLabel.textColor"];
}


- (void)setFl_placeholderFont:(UIFont *)fl_placeholderFont{
//    objc_setAssociatedObject(self, &fl_placeholderFont, fl_placeholderFont, OBJC_ASSOCIATION_RETAIN);
    [self setValue:fl_placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

- (UIFont *)fl_placeholderFont{
//    return objc_getAssociatedObject(self, &fl_placeholderFont);
    return [self valueForKeyPath:@"_placeholderLabel.font"];
}

@end
