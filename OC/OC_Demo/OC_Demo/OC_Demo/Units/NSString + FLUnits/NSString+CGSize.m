//
//  NSString+CGSize.m
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "NSString+CGSize.h"

@implementation NSString (CGSize)


- (CGRect)fl_textSizeWithMaxSize:(CGSize)maxSize attributes:(NSDictionary *)attributes{
    return [self boundingRectWithSize:maxSize options:0 attributes:attributes context:nil];
}

- (CGFloat)fl_textHeightWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)textFont {
    return [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : textFont} context:nil].size.height;
}

- (CGFloat)fl_textWidthWithFont:(UIFont *)textFont {
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:0 attributes:@{NSFontAttributeName : textFont} context:nil].size.width;
}

@end
