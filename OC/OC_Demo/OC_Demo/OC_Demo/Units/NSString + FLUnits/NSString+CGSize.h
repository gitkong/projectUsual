//
//  NSString+CGSize.h
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CGSize)
/**
 *  @author 孔凡列, 16-08-30 01:08:05
 *
 *  返回一段字符串的size
 *
 *  @param maxSize    maxSize description
 *  @param attributes attributes description
 *
 *  @return return value description
 */
- (CGRect)fl_textSizeWithMaxSize:(CGSize)maxSize attributes:(NSDictionary *)attributes;
/**
 *  @author 孔凡列, 16-08-30 01:08:39
 *
 *  返回指定字符串的height
 *
 *  @param maxWidth maxWidth description
 *  @param textFont textFont description
 *
 *  @return return value description
 */
- (CGFloat)fl_textHeightWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)textFont;
/**
 *  @author 孔凡列, 16-08-30 01:08:02
 *
 *  返回指定字符串的width
 *
 *  @param textFont textFont description
 *
 *  @return return value description
 */
- (CGFloat)fl_textWidthWithFont:(UIFont *)textFont;

@end
