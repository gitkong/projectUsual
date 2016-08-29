//
//  CZCarouselView.h
//  caolin
//
//  Created by 孔凡列 on 15/11/24.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  用于显示轮播中内容的View
 */

@interface CZCarouselView : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

@end

@interface CZCarouselPageControlOfNumber : UIView

@property (assign,nonatomic) NSInteger currentPage;
@property (strong,nonatomic) UILabel *pageControl;

@end


/*
 *  delegate
 */
@class CZCarousel;

@protocol CZCarouselDelegate <NSObject>

@required
/*
 *  此方法为 CZCarousel 轮播内容的数量
 */
- (NSInteger)numberOfCarousel:(CZCarousel *)wheel;
/*
 *  此方法为 用于CZCarousel 轮播内容的显示
 */
- (CZCarouselView *)carousel:(UICollectionView *)carousel viewForItemAtIndex:(NSIndexPath*)index itemsIndex:(NSInteger)itemsIndex identifire:(NSString *)identifire;
@optional
/*
 *  此方法为 用于CZCarousel 轮播的点击方法
 */
- (void)carouselScrollView:(CZCarousel *)carouselScrollView didSelectItemAtIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, CZCarouselPageType)
{
    CZCarouselPageTypeOfNone,               //默认系统 UIPageControl 样式
    CZCarouselPageTypeOfNumber,             //自定义熟数字样式 PageControl
};



@interface CZCarousel : UIView

@property (nonatomic, weak) id<CZCarouselDelegate> delegate;
@property (nonatomic, assign) CGFloat carouseScrollTimeInterval;
@property (nonatomic, readonly) NSInteger numberOfItems;

/**
 *  添加属性--判断是否需要创建定时器
 */
@property (nonatomic,assign,getter=isCreateTimer)BOOL createTimer;

/*
 *  设置系统默认 UIPageControl 的位置、 背景颜色 、指示器顶层颜色 、指示器底层颜色
 */
@property (nonatomic, assign) CGRect pageControlFrame;
//两种样式的PageControl 共用背景颜色的属性
@property (nonatomic, strong) UIColor *pageControlBackGroundColor;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, assign) NSInteger pageControlOfNumberCurrentTotal;

/*
 *  当PageControl 为显示数字类型时 有如下属性
 */

//设置数字类型 PageControl 的字体
@property (nonatomic, strong) UIFont *pageControlOfNumberFont;
@property (nonatomic, strong) UIColor *pageContolOfNumberFontColor;


//设置是否使用自动滚动
@property (nonatomic, assign) BOOL isAutoScroll;

@property (nonatomic, assign) CZCarouselPageType pageType;


/*
 *  重用方法
 */
-(void)reloadData;

@end
