//
//  NSString+Line.h
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Line)

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
