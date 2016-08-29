//
//  UIFont+FLUnits.m
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "UIFont+FLUnits.h"

@implementation UIFont (FLUnits)

+ (CGFloat)fl_systemFontSize{
    UIFont *newFont = [self preferredFontForTextStyle:UIFontTextStyleBody];
    UIFontDescriptor *ctfFont = newFont.fontDescriptor;
    NSNumber *fontNumber = [ctfFont objectForKey:@"NSFontSizeAttribute"];
    return fontNumber.floatValue;
}

@end
