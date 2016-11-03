//
//  CZCommentTextView.m
//  commentViewDemo
//
//  Created by 孔凡列 on 16/3/17.
//  Copyright © 2016年 czebd. All rights reserved
//

#import "FLTextView.h"

@interface FLTextView()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation FLTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加提示文字
        UILabel *placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.font = self.font;
        [self insertSubview:placeholderLabel atIndex:0];
        self.placeholderLabel = placeholderLabel;
        
        // 2.监听textView文字改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEdit) name:UITextViewTextDidEndEditingNotification object:self];
        
    }
    return self;
}

- (void)setText:(NSString *)text{
    if (text) {
        if (![text isEqualToString:@""]) {
            self.placeholderLabel.hidden = YES;
            [super setText:text];
        }
    }
    else{
        self.placeholderLabel.hidden = NO;
        [super setText:nil];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    if (placeholder.length > 0) { // 需要显示
        self.placeholderLabel.hidden = NO;
        
        // 计算frame
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        CGFloat maxH = self.frame.size.height - 2 * placeholderY;
        CGRect placeholderRect = [placeholder boundingRectWithSize:CGSizeMake(maxW, maxH) options:0 attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil];
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderRect.size.width, placeholderRect.size.height);
    } else {
        self.placeholderLabel.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    _placeholderFont = placeholderFont;
    self.placeholderLabel.font = placeholderFont;
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;

}

- (void)textDidChange{
    self.placeholderLabel.hidden = (self.text.length != 0);
    // 限定70字
    if (self.text.length >= 40){
        self.text = [self.text substringToIndex:40];
    }
    else{
//        self.editable = YES;
    }
}

- (void)textDidEndEdit{
    if (self.textContentBlock) {
        self.textContentBlock(self.text);
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
}

@end
