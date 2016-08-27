    //
//  CZCarouselView.m
//  caolin
//
//  Created by 孔凡列 on 15/11/24.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import "CZCarousel.h"
/*
 *  UICollectionViewCell
 */
@implementation CZCarouselView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        CZLog(@"_imageView.frame = %@",NSStringFromCGRect(_imageView.frame));
        [self addSubview:_imageView];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame{
//    frame.origin.y -= 10;
//    [super setFrame:frame];
//}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    CZLog(@"_imageView.frame = %@",NSStringFromCGRect(_imageView.frame));
//    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//}

@end

@implementation CZCarouselPageControlOfNumber

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pageControl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_pageControl];
    }
    return self;
}

@end


/*
 *  轮播
 */

#define DY 1000

@interface CZCarousel()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *carousel;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControl;
//自定义 UIPageControl
@property (nonatomic, strong) CZCarouselPageControlOfNumber *pageControlOfNumber;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger realItems;
@end

@implementation CZCarousel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // 创建UI 方法
        
        [self createCarouselUI];
        
        // 默认是创建定时器的
        self.createTimer = YES;
    }
    return self;
}

/*
 *  创建View 中 UI
 */
-(void)createCarouselUI
{
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = (CGSize){self.frame.size.width,self.frame.size.height};
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _carousel = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:_flowLayout];
    _carousel.backgroundColor = [UIColor clearColor];
    _carousel.pagingEnabled = YES;
    _carousel.scrollEnabled = YES;
    _carousel.showsHorizontalScrollIndicator = NO;
    _carousel.showsVerticalScrollIndicator = NO;
    [_carousel registerClass:[CZCarouselView class] forCellWithReuseIdentifier:@"CZWheelCell"];
    _carousel.dataSource = self;
    _carousel.delegate = self;
    [self addSubview:_carousel];
    
}



/*
 *  当使用时候执行pageControlFrame 属性时则 创建 UIPageControl 指示器
    并添加到CZCarousel显示
 */

-(void)setPageControlFrame:(CGRect)pageControlFrame
{
    //创建指示器
    if (_pageType == 0) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = pageControlFrame;
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
    }else if (_pageType == 1){
        _pageControlOfNumber = [[CZCarouselPageControlOfNumber alloc]initWithFrame:pageControlFrame];
        _pageControlOfNumber.currentPage = 0;
        [self addSubview:_pageControlOfNumber];
        
    }
    
}

#pragma mark - setter & getter
- (void)setCreateTimer:(BOOL)createTimer{
    _createTimer = createTimer;
}

-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

-(void)setPageControlBackGroundColor:(UIColor *)pageControlBackGroundColor
{
    if (_pageType == 0) {
        _pageControl.backgroundColor = [UIColor clearColor];
    }
    else if (_pageType == 1){
        _pageControlOfNumber.backgroundColor = pageControlBackGroundColor;
    }
    
}
-(void)setPageControlOfNumberFont:(UIFont *)pageControlOfNumberFont
{
    _pageControlOfNumber.pageControl.font = pageControlOfNumberFont;
}

-(void)setPageContolOfNumberFontColor:(UIColor *)pageContolOfNumberFontColor
{
    _pageControlOfNumber.pageControl.textColor = pageContolOfNumberFontColor;
}



-(void)reloadData
{
    if (_isAutoScroll == YES) {
        [self createTimer];
    }
    
    if (_pageType == 0) {
        _pageControl.numberOfPages = [_delegate numberOfCarousel:self];
    }else if(_pageType == 1){
        _pageControlOfNumberCurrentTotal = [_delegate numberOfCarousel:self];
        _pageControlOfNumber.pageControl.text = [NSString stringWithFormat:@"%d / %ld",1,_pageControlOfNumberCurrentTotal];
    }
    
    _numberOfItems = [_delegate numberOfCarousel:self];
    
    _realItems = _numberOfItems *DY;
    
    [self.carousel reloadData];
    
    if (_carousel.contentOffset.x == 0 &&  _realItems) {
        [_carousel scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_realItems * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _realItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger itemIndex = indexPath.row % _numberOfItems;
    return [_delegate carousel:collectionView viewForItemAtIndex:indexPath itemsIndex:itemIndex identifire:@"CZWheelCell"];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)index
{
    if ([self.delegate respondsToSelector:@selector(carouselScrollView:didSelectItemAtIndex:)]) {
        [self.delegate carouselScrollView:self didSelectItemAtIndex:index.row % _numberOfItems];
    }
}


/*
 *  创建定时器
 */

- (void)createTimer
{
    // 先把之前的定时器销毁
    [self.timer invalidate];
    self.timer = nil;
    
    if (_createTimer == YES) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_carouseScrollTimeInterval target:self selector:@selector(autoCarouselScroll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

/*
 * 执行定时器方法
 */

- (void)autoCarouselScroll
{
    if (0 == _realItems) return;
    int currentIndex = _carousel.contentOffset.x / _flowLayout.itemSize.width;
    int startIndex = currentIndex + 1;
    if (startIndex == _realItems) {
        startIndex = _realItems * 0.5;
        [_carousel scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:startIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_carousel scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:startIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    int itemIndex = (scrollView.contentOffset.x + self.carousel.frame.size.width * 0.5) / self.carousel.frame.size.width;
    if (!self.numberOfItems) return;
    int indexOnPageControl = itemIndex % self.numberOfItems;
    
    if (_pageType == 0) {
        _pageControl.currentPage = indexOnPageControl;
    }
    else if (_pageType == 1){
        _pageControlOfNumber.pageControl.text = [NSString stringWithFormat:@"%d / %ld",indexOnPageControl+1,_pageControlOfNumberCurrentTotal];
        self.pageControlOfNumber.currentPage = indexOnPageControl;
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self createTimer];
}


@end
