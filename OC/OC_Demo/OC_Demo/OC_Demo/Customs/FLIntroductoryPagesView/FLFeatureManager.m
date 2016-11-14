//
//  FLFeatureManager.m
//  OC_Demo
//
//  Created by clarence on 16/11/8.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLFeatureManager.h"

@interface FLFeatureView ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *bigScrollView;
@property(nonatomic)NSArray *imageArray;
@property(nonatomic,weak)UIPageControl *pageControl;
@property (nonatomic,weak)UIView *lastFeatureView;
@end

@implementation FLFeatureView

- (instancetype)initPagesViewWithFrame:(CGRect)frame Images:(NSArray *)images{
    if (self = [super initWithFrame:frame]) {
        self.imageArray=images;
        [self loadPageView];
    }
    return self;
}

- (void)loadPageView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    scrollView.contentSize = CGSizeMake((_imageArray.count + 1)*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    scrollView.pagingEnabled = YES;//设置分页
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.bigScrollView = scrollView;
    
    for (int i = 0; i < _imageArray.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = view.bounds;
        UIImage *image = [UIImage imageNamed:_imageArray[i]];
        imageView.image = image;
        [view addSubview:imageView];
        [scrollView addSubview:view];
        
        if (i == _imageArray.count - 1) {
            self.lastFeatureView = view;
        }
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height * 0.92, 0, 40)];
    pageControl.numberOfPages = _imageArray.count;
    pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:pageControl];
    
    self.pageControl = pageControl;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.bigScrollView) {
        
        CGPoint offSet = scrollView.contentOffset;
        _pageControl.currentPage = offSet.x/(self.bounds.size.width);//计算当前的页码
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_pageControl.currentPage), scrollView.contentOffset.y) animated:YES];
    }
    if (scrollView.contentOffset.x == (_imageArray.count) *[UIScreen mainScreen].bounds.size.width) {
        [self removeFromSuperview];
    }
}

@end

@interface FLFeatureManager ()
@property (nonatomic,weak) UIWindow *rootWindow;
@property(nonatomic,strong)FLFeatureView *featureView;
@property (nonatomic,weak)UIView *lastFeatureView;
@property (nonatomic,weak)UITapGestureRecognizer *tapG;
@end

@implementation FLFeatureManager

+ (instancetype)shareManager{
    static FLFeatureManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[FLFeatureManager alloc] init];
        shareInstance.rootWindow = [self lastWindow];
    });
    
    return shareInstance;
}


- (void)fl_showFeatureView:(NSArray *)imageArray{
    if (!self.featureView) {
        self.featureView  = [[FLFeatureView alloc] initPagesViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) Images:imageArray];
        self.lastFeatureView = self.featureView.lastFeatureView;
        self.lastFeatureViewSwipToDismiss = NO;
        
    }
    [self.rootWindow addSubview:self.featureView];
    
}


- (void)fl_removeFeatureView{
    [self.featureView removeFromSuperview];
    self.featureView = nil;
}

#pragma mark -- Setter & Getter

- (void)setCurrentIndex:(NSInteger)currentIndex{
    NSAssert(currentIndex < self.featureView.imageArray.count, @"下标越界，请检查数组元素个数");
    self.featureView.pageControl.currentPage = currentIndex;
    [self.featureView.bigScrollView setContentOffset:CGPointMake(self.featureView.bounds.size.width * currentIndex, self.featureView.bigScrollView.contentOffset.y) animated:NO];
}

- (NSInteger)currentIndex{
    return self.featureView.pageControl.currentPage;
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    self.featureView.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    self.featureView.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setLastFeatureViewClickToDismiss:(BOOL)lastFeatureViewClickToDismiss{
    _lastFeatureViewClickToDismiss = lastFeatureViewClickToDismiss;
    
    if (lastFeatureViewClickToDismiss) {
        //添加手势
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
        singleRecognizer.numberOfTapsRequired = 1;
        self.tapG = singleRecognizer;
        [self.featureView.bigScrollView addGestureRecognizer:singleRecognizer];
    }
    else{
        if (self.tapG) {
            [self.featureView.bigScrollView removeGestureRecognizer:self.tapG];
        }
    }
}

- (void)setLastFeatureViewSwipToDismiss:(BOOL)lastFeatureViewSwipToDismiss{
    if (lastFeatureViewSwipToDismiss) {
        self.featureView.bigScrollView.contentSize = CGSizeMake((self.featureView.imageArray.count + 1)*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    else{
        self.featureView.bigScrollView.contentSize = CGSizeMake((self.featureView.imageArray.count)*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
}

- (void)handleSingleTapFrom{
    if (self.featureView.pageControl.currentPage == self.featureView.imageArray.count-1) {
        [self fl_removeFeatureView];
    }
}

#pragma mark -- private method

+ (UIWindow *)lastWindow{
    NSArray *windows = [UIApplication sharedApplication].windows;
    // 如果有弹窗
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}
@end
