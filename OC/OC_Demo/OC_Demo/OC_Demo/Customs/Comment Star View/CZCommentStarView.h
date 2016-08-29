//
//  CZCommentStarView.h
//  commentStarDemo
//
//  Created by 孔凡列 on 16/3/7.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FL_STAR_NORMAL @"star"

#define FL_STAR_SELECTED @"starh"

typedef void(^StarCountBlock)(NSInteger starCount);

@interface CZCommentStarView : UIView

@property(nonatomic,assign)NSInteger count;// count 至少为1

@property BOOL canAddStar;


@property (nonatomic,copy)StarCountBlock starCountBlock;

+ (instancetype)instanceStarView;


@end
