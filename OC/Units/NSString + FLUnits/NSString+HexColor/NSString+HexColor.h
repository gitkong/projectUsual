//
//  NSString+HexColor.h
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface NSString (HexColor)

#pragma mark - 十六进制格式转换成颜色
- (UIColor *)fl_hexStringToColor;

@end
