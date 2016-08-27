//
//  NSString+FLUnits.h
//
//  Created by 孔凡列 on 16/7/12.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FLUnits)
#pragma mark - 获取当前文本所占据的宽和高
/**
 *  获取当前文本所占据的宽和高
 *
 *  @param maxSize    设置最大的宽和高限制
 *  @param attributes 通过字典设置文本字体,字体大小也会影响文本的宽度和高度
 *
 *  @return 返回CGSize
 */
- (CGRect)fl_textSizeWithMaxSize:(CGSize)maxSize attributes:(NSDictionary *)attributes;

#pragma mark - 判断字符串是否规范
- (BOOL)fl_isNullString;// 是否空字符串
- (BOOL)fl_isValidateEmail;// 邮箱
- (BOOL)fl_isValidateCarNo;// 车牌
- (BOOL)fl_isValidateString;// 合法字符（数字、字母、下划线）
- (BOOL)fl_isValidateIdentityCard;// 身份证
- (BOOL)fl_isValidateMobileNumber;// 手机号码

- (BOOL)fl_isHaveString:(NSString *)desStr;// 判断字符串中是否含有指定的字符串
- (BOOL)fl_isHaveChinese;// 判断字符串中是否含有中文
- (BOOL)fl_isAllNumber;// 判断是否全是数字

- (BOOL)fl_isAllChinese;// 判断是否全是中文
- (BOOL)fl_isStrongPassword;//密码强度必须包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10位

#pragma mark - 十六进制格式转换成颜色
- (UIColor *)fl_hexStringToColor;

#pragma mark - MD5加密
- (NSString *)fl_md5String;

@end


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
#pragma mark - 颜色&字体
@interface NSString (ColorAndFont)
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

#pragma mark - 给字符串添加中划线
/**
 *  添加中划线
 *
 *  @return 富文本
 */
- (NSMutableAttributedString *)fl_addCenterLine;

#pragma mark - 给字符串添加下划线
/**
 *  添加下划线
 *
 *  @return 富文本
 */
- (NSMutableAttributedString *)fl_addDownLine;
@end


