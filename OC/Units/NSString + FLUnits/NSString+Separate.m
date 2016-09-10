//
//  NSString+Separate.m
//  OC_Demo
//
//  Created by clarence on 16/9/11.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "NSString+Separate.h"

@implementation NSString (Separate)

- (NSArray<NSString *> *)fl_separateByCharacters:(NSString *)characters{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:characters];
    return [self componentsSeparatedByCharactersInSet:characterSet];
}

@end
