/*
 * author 孔凡列
 *
 * gitHub https://github.com/gitkong
 * cocoaChina http://code.cocoachina.com/user/
 * 简书 http://www.jianshu.com/users/fe5700cfb223/latest_articles
 * QQ 279761135
 * 喜欢就给个like 和 star 喔~
 */

#import <UIKit/UIKit.h>

@interface FLFeatureView : UIView

@end
/**
 *  @author Clarence
 *
 *  新特性管理，默认左滑最后一张会移除新特性
 */
@interface FLFeatureManager : NSObject
/**
 *  @author Clarence
 *
 *  点击最后一张新特性页面会移除新特性，默认关闭(必须在show之后设置)
 */
@property (nonatomic,assign)BOOL lastFeatureViewClickToDismiss;
/**
 *  @author Clarence
 *
 *  左滑最后一张新特性页面会移除新特性，默认关闭(必须在show之后设置)
 */
@property (nonatomic,assign)BOOL lastFeatureViewSwipToDismiss;
/**
 *  @author Clarence
 *
 *  最后一页的新特性页，默认已经有一张特性图，可添加新控件(必须在show之后设置)
 *  注意：此时lastFeatureView 的 x值并不是0
 */
@property (nonatomic,weak,readonly)UIView *lastFeatureView;
/**
 *  @author Clarence
 *
 *  当前的页面，可设置(必须在show之后设置)
 */
@property (nonatomic,assign)NSInteger currentIndex;
/**
 *  @author Clarence
 *
 *  默认pageControl点的颜色(必须在show之后设置)
 */
@property(nonatomic,strong)UIColor *pageIndicatorTintColor;
/**
 *  @author Clarence
 *
 *  当前选中的pageControl点的颜色(必须在show之后设置)
 */
@property(nonatomic,strong)UIColor *currentPageIndicatorTintColor;
/**
 *  @author Clarence
 *
 *  单例
 */
+ (instancetype)shareManager;
/**
 *  @author Clarence
 *
 *  显示新特性页面，传入图片名数组
 */
- (void)fl_showFeatureView:(NSArray *)imageArray;
/**
 *  @author Clarence
 *
 *  移除新特性页面
 */
- (void)fl_removeFeatureView;

@end
