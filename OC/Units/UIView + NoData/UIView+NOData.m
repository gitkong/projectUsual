//
//  UIView+NOData.m
//  OC_Demo
//
//  Created by clarence on 16/10/29.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "UIView+NOData.h"

@implementation UIView (NOData)

static void (^_opreation)();

static UIView *_noDataView;

- (void)fl_showNoDataCustomView:(UIView *_Nullable)customView operation:(void (^_Nullable)())operation{
    _opreation = operation;
    _noDataView = customView;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsOperation)];
    [customView addGestureRecognizer:tapG];
    [self addSubview:customView];

}

- (void)fl_showNoDataView:(NSString *_Nullable)imageName text:(NSString *_Nullable)text operation:(void (^_Nullable)())operation{
    _opreation = operation;
    UIView *noDataView = ({
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *imageView = [[UIButton alloc] init];
        [imageView setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        imageView.bounds = CGRectMake(0, 0, self.bounds.size.width / 3, self.bounds.size.width / 3);
        
        imageView.center = CGPointMake(self.center.x, self.center.y - 20);
        [imageView addTarget:self action:@selector(respondsOperation) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, self.bounds.size.width, 60);
        label.textColor = [UIColor lightGrayColor];
        label.text = text;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.center = CGPointMake(self.center.x, CGRectGetMaxY(imageView.frame) + 30);
        [view addSubview:label];
        
        view;
    });
//    [self fl_showNoDataCustomView:noDataView operation:operation];
    _noDataView = noDataView;
    [self addSubview:noDataView];
}


- (void)fl_showNoDataViewOperation:(void (^_Nullable)())operation{
    [self fl_showNoDataView:@"background" text:@"什么都没有" operation:operation];
}

- (void)respondsOperation{
    if (_opreation) {
        _opreation();
    }
}

- (void)fl_hideNoDataView{
    [_noDataView removeFromSuperview];
    _noDataView = nil;
//    _opreation = nil;
}

@end
