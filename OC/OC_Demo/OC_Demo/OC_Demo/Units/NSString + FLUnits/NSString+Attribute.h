//
//  NSString+Attribute.h
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
static NSString  *const FLColorKey = @"color";
static NSString  *const FLFontKey = @"font";
static NSString  *const FLRangeKey = @"range";
/**
 range的校验结果
 */
typedef enum
{
    FLRangeCorrect = 0,
    FLRangeError = 1,
    FLRangeOut = 2,
    
}FLRangeFormatType;
@interface NSString (Attribute)
#pragma mark - 校验NSRange
/**
 *  校验范围（NSRange）
 *
 *  @param range Range
 *
 *  @return 校验结果：RangeFormatType
 */
- (FLRangeFormatType)fl_checkRange:(NSRange)range;

#pragma mark - 改变单个范围字体的大小和颜色
/**
 *  改变字体的颜色
 *
 *  @param color 颜色（UIColor）
 *  @param range 范围（NSRange）
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)fl_changeColor:(UIColor *)color
                                     andRange:(NSRange)range;


/**
 *  改变字体大小
 *
 *  @param font  字体大小(UIFont)
 *  @param range 范围(NSRange)
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)fl_changeFont:(UIFont *)font
                                    andRange:(NSRange)range;


/**
 *   改变字体的颜色和大小
 *
 *  @param colors      字符串的颜色
 *  @param colorRanges 需要改变颜色的字符串范围
 *  @param fonts       字体大小
 *  @param fontRanges  需要改变字体大小的字符串范围
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */

- (NSMutableAttributedString *)fl_changeColor:(UIColor *)color
                                 andColorRang:(NSRange)colorRange
                                      andFont:(UIFont *)font
                                 andFontRange:(NSRange)fontRange;

#pragma mark - 改变多个范围内的字体和颜色

/**
 *  改变多段字符串为一种颜色
 *
 *  @param color  字符串的颜色
 *  @param ranges 范围数组:[NSValue valueWithRange:NSRange]
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)fl_changeColor:(UIColor *)color andRanges:(NSArray<NSValue *> *)ranges;

/**
 *  改变多段字符串为同一大小
 *
 *  @param font   字体大小
 *  @param ranges 范围数组:[NSValue valueWithRange:NSRange]
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)fl_changeFont:(UIFont *)font andRanges:(NSArray<NSValue *> *)ranges;
/**
 *  用于多个位置颜色和大小改变
 *
 *  @param changes 对应属性改变的数组.示例:@[@{XCColorKey:UIColor,XCFontKey:UIFont,XCRangeKey:NSArray<NSValue *>}];
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)fl_changeColorAndFont:(NSArray<NSDictionary *> *)changes;


#pragma mark - 对特定字符进行改变
/**
 *  对相应的字符串进行改变
 *
 *  @param str   需要改变的字符串
 *  @param color 字体颜色
 *  @param font  字体大小
 *
 *  @return 转换后的富文本（NSMutableAttributedString）
 */
- (NSMutableAttributedString *)fl_changeWithStr:(NSString *)str andColor:(UIColor *)color andFont:(UIFont *)font;
@end
