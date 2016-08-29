//
//  NSString+Judge.h
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Judge)
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
@end
