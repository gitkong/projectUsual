//
//  CZCommentTextView.h
//  commentViewDemo
//
//  Created by 孔凡列 on 16/3/17.
//  Copyright © 2016年 czebd. All rights reserved
//

#import <UIKit/UIKit.h>

typedef void(^TextContentBlock)(NSString *textContent);

@interface FLTextView : UITextView

@property (nonatomic, strong) UIFont *placeholderFont;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) UIColor *placeholderColor;

// 利用block传递text出去
@property (nonatomic,copy)TextContentBlock textContentBlock;

@end
