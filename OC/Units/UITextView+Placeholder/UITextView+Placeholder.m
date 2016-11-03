/*
 * author 孔凡列
 *
 * gitHub https://github.com/gitkong
 * cocoaChina http://code.cocoachina.com/user/
 * 简书 http://www.jianshu.com/users/fe5700cfb223/latest_articles
 * QQ 279761135
 * 喜欢就给个like 和 star 喔~
 */

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

@implementation UITextView (Placeholder)

static char fl_static_placeholder;

static char fl_static_placeholderFont;

static char fl_static_placeholderColor;

- (void)setFl_placeholder:(NSString *)fl_placeholder{
    objc_setAssociatedObject(self, &fl_static_placeholder, fl_placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    // 设置水印
    [self fl_placeholderLabel].text = fl_placeholder;
    // 系统默认text是空字符串，如果有输入内容，就隐藏水印，不再显示，防止输入后再赋值新的水印后显示出来
    if (![self.text isEqualToString:@""]) {
        [self fl_placeholderLabel].hidden = YES;
    }
    else{
        [self fl_placeholderLabel].hidden = NO;
    }
}

- (NSString *)fl_placeholder{
    return objc_getAssociatedObject(self, &fl_static_placeholder);
}

- (void)setFl_placeholderFont:(UIFont *)fl_placeholderFont{
    objc_setAssociatedObject(self, &fl_static_placeholderFont, fl_placeholderFont, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self fl_placeholderLabel].font = fl_placeholderFont;
}

- (UIFont *)fl_placeholderFont{
    return objc_getAssociatedObject(self, &fl_static_placeholderFont);
}

- (void)setFl_placeholderColor:(UIColor *)fl_placeholderColor{
    objc_setAssociatedObject(self, &fl_static_placeholderColor, fl_placeholderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self fl_placeholderLabel].textColor = fl_placeholderColor;
}

- (UIColor *)fl_placeholderColor{
    return objc_getAssociatedObject(self, &fl_static_placeholderColor);
}

#pragma mark -- private method

- (UILabel *)fl_placeholderLabel{
    if (![self valueForKey:@"_placeholderLabel"]) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        // 水印label的字体必须要设置，不然水印label会向上偏移，一般来说，水印字体和textView的字体一致，但问题是，如果不设置textView的字体，系统默认返回一个nil，此处如果没有设置，默认给textView一个字体
        if (!self.font) {
            self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        }
        label.font = self.font;
        label.textColor = [UIColor lightGrayColor];
        [label sizeToFit];
        [self addSubview:label];
        [self setValue:label forKey:@"_placeholderLabel"];
    }
    return [self valueForKey:@"_placeholderLabel"];
}



@end
