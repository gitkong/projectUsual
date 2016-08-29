//
//  NSString+Attribute.m
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "NSString+Attribute.h"

@implementation NSString (Attribute)

- (FLRangeFormatType)fl_checkRange:(NSRange)range{
    NSInteger loc = range.location;
    NSInteger len = range.length;
    if (loc>=0 && len>0) {
        if (range.location + range.length <= self.length) {
            return FLRangeCorrect;
        }
        else{
            NSLog(@"The range out-of-bounds!");
            return FLRangeOut;
        }
    }
    else{
        NSLog(@"The range format is wrong: NSMakeRange(a,b) (a>=0,b>0). ");
        return FLRangeError;
    }
}

- (NSMutableAttributedString *)fl_changeColor:(UIColor *)color
                                     andRange:(NSRange)range{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self fl_checkRange:range] == FLRangeCorrect) {
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
        else{
            NSLog(@"color is nil");
        }
        
    }
    return attributedStr;
}


- (NSMutableAttributedString *)fl_changeFont:(UIFont *)font
                                    andRange:(NSRange)range{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self fl_checkRange:range] == FLRangeCorrect) {
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:range];
        }
        else{
            NSLog(@"font is nil...");
        }
    }
    return attributedStr;
}


- (NSMutableAttributedString *)fl_changeColor:(UIColor *)color
                                 andColorRang:(NSRange)colorRange
                                      andFont:(UIFont *)font
                                 andFontRange:(NSRange)fontRange{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if ([self fl_checkRange:colorRange] == FLRangeCorrect) {
        if (color) {
            [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:colorRange];
        }
        else{
            NSLog(@"color is nil");
        }
    }
    if ([self fl_checkRange:fontRange] == FLRangeCorrect) {
        if (font) {
            [attributedStr addAttribute:NSFontAttributeName value:font range:fontRange];
        }
        else{
            NSLog(@"font is nil...");
        }
    }
    return attributedStr;
}

- (NSMutableAttributedString *)fl_changeColor:(UIColor *)color andRanges:(NSArray<NSValue *> *)ranges{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (color) {
        [ranges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [(NSValue *)obj rangeValue];
            if ([self fl_checkRange:range] == FLRangeCorrect) {
                [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            else{
                NSLog(@"index:%ld",idx);
            }
            
        }];
    }
    else{
        NSLog(@"color is nil...");
    }
    return attributedStr;
}

- (NSMutableAttributedString *)fl_changeFont:(UIFont *)font andRanges:(NSArray<NSValue *> *)ranges{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (font) {
        [ranges enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSRange range = [(NSValue *)obj rangeValue];
            if ([self fl_checkRange:range] == FLRangeCorrect) {
                [attributedStr addAttribute:NSFontAttributeName value:font range:range];
            }
            else{
                NSLog(@"index:%ld",idx);
            }
            
        }];
    }
    else{
        NSLog(@"font is nil...");
    }
    return attributedStr;
}

- (NSMutableAttributedString *)fl_changeColorAndFont:(NSArray<NSDictionary *> *)changes{
    __block NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    [changes enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *color = obj[FLColorKey];
        UIFont *font = obj[FLFontKey];
        NSArray<NSValue *> *ranges = obj[FLRangeKey];
        if (!color) {
            NSLog(@"warning: NSColorKey -> nil! index:%ld",idx);
        }
        if (!font) {
            NSLog(@"warning: NSFontKey -> nil! index:%ld",idx);
        }
        if (ranges.count>0) {
            [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSRange range = [obj rangeValue];
                if ([self fl_checkRange:range] == FLRangeCorrect) {
                    if (color) {
                        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                    }
                    if (font) {
                        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
                    }
                }
                else{
                    NSLog(@"index:%ld",idx);
                }
                
            }];
        }
        else{
            NSLog(@"warning: NSRangeKey -> nil! index:%ld",idx);
        }
    }];
    return attributedStr;
    
}

- (NSMutableAttributedString *)fl_changeWithStr:(NSString *)str andColor:(UIColor *)color andFont:(UIFont *)font{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    NSUInteger length = self.length;
    while (length > str.length) {
        NSRange range = [self rangeOfString:str options:NSBackwardsSearch range:NSMakeRange(0, length)];
        if ([self fl_checkRange:range] == FLRangeCorrect) {
            if (color) {
                [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
            }
            if (font) {
                [attributedStr addAttribute:NSFontAttributeName value:font range:range];
            }
            length = range.location;
        }
        else{
            NSLog(@"error");
        }
    }
    return attributedStr;
}


@end
