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

@interface UINavigationBar (NavigationBarBackground)

/**
 *  @author Clarence
 *
 *  设置NavigationBar的私有属性backgroundView的背景颜色
 */
- (void)fl_setBackgroundViewWithColor:(UIColor *)backgroundColor;


/**
 *  @author Clarence
 *
 *  设置NavigationBar的背景透明度
 */
- (void)fl_setBackgroundViewWithAlpha:(CGFloat)alpha;

/**
 *  @author Clarence
 *
 *  设置NavigationBar的背景透明度
 */
- (void)fl_resetBackgroundDefaultStyle;

@end
