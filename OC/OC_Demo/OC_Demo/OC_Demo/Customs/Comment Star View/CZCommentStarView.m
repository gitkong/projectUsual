//
//  CZCommentStarView.m
//  commentStarDemo
//
//  Created by 孔凡列 on 16/3/7.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "CZCommentStarView.h"

@interface CZCommentStarView ()
@property(strong,nonatomic) IBOutlet UIImageView *img_star1;
@property(strong,nonatomic) IBOutlet UIImageView *img_star2;
@property(strong,nonatomic) IBOutlet UIImageView *img_star3;
@property(strong,nonatomic) IBOutlet UIImageView *img_star4;
@property(strong,nonatomic) IBOutlet UIImageView *img_star5;

// 存放这5个图片的数组
@property (nonatomic,strong)NSMutableArray *imgArrM;
@end

@implementation CZCommentStarView



+ (instancetype)instanceStarView{
    CZCommentStarView *commentStarView = [[NSBundle mainBundle] loadNibNamed:@"CZCommentStarView" owner:self options:nil].lastObject;
    [commentStarView.imgArrM addObject:commentStarView.img_star1];
    [commentStarView.imgArrM addObject:commentStarView.img_star2];
    [commentStarView.imgArrM addObject:commentStarView.img_star3];
    [commentStarView.imgArrM addObject:commentStarView.img_star4];
    [commentStarView.imgArrM addObject:commentStarView.img_star5];
    
    
    return commentStarView;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if((point.x>0 && point.x<self.frame.size.width)&&(point.y>0 && point.y<self.frame.size.height)){
        self.canAddStar = YES;
        [self changeStarForegroundViewWithPoint:point];
        
    }else{
        self.canAddStar = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(self.canAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self changeStarForegroundViewWithPoint:point];
        
    }
    return;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.canAddStar){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self changeStarForegroundViewWithPoint:point];
        
    }
    
    self.canAddStar = NO;
    return;
}


-(void)changeStarForegroundViewWithPoint:(CGPoint)point{
    
    NSInteger count = 0;
    count += [self changeImg:point.x image:self.img_star1];
    count += [self changeImg:point.x image:self.img_star2];
    count += [self changeImg:point.x image:self.img_star3];
    count += [self changeImg:point.x image:self.img_star4];
    count += [self changeImg:point.x image:self.img_star5];
    if(count==0){
        count = 1;
        [self.img_star1 setImage:[UIImage imageNamed:FL_STAR_SELECTED]];
    }
    
    // 创建临时数组
    NSMutableArray *tempArrM = [NSMutableArray array];
    // 遍历数组
    for (NSInteger index = 0; index < self.imgArrM.count; index ++) {
        UIImageView *imageView = self.imgArrM[index];
        if (imageView.highlighted == YES) {
            [tempArrM addObject:imageView];
        }
    }
    self.count = tempArrM.count;
    //    CZLog(@"count------------- = %zd",self.count);
    if (self.starCountBlock) {
        self.starCountBlock(self.count == 0 ? 5 : self.count);
    }
}


-(NSInteger)changeImg:(float)x image:(UIImageView*)img{
    // 要拿到父类才可以判断
    if(x>= img.superview.frame.origin.x ){
        [img setImage:[UIImage imageNamed:FL_STAR_NORMAL]];
        img.highlighted = YES;
        return 2;
    }else{
        [img setImage:[UIImage imageNamed:FL_STAR_SELECTED]];
        img.highlighted = NO;
        return 1;
    }
}



#pragma mark - setter & getter
- (void)setCount:(NSInteger)count{
    _count = count;
    
    // 遍历数组
    for (NSInteger index = 0; index < self.imgArrM.count; index ++) {
        // 先全部为不选状态
        UIImageView *imageView = self.imgArrM[index];
        [imageView setImage:[UIImage imageNamed:FL_STAR_SELECTED]];
    }
    // 有多少个选多少个
    // 最多5星
    if (count > 5) {
        count = 5;
        _count = count;
    }
    for (NSInteger index = 1; index <= count; index ++) {
        UIImageView *imageView = self.imgArrM[index - 1];
        if (imageView) {
            [imageView setImage:[UIImage imageNamed:FL_STAR_NORMAL]];
        }
    }
}

- (NSMutableArray *)imgArrM{
    if (_imgArrM == nil) {
        _imgArrM = [NSMutableArray array];
    }
    return _imgArrM;
}

@end
