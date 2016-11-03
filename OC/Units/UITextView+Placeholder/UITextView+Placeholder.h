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

@interface UITextView (Placeholder)
/**
 *  @author Clarence
 *
 *  水印
 */
@property (nonatomic,copy)NSString *fl_placeholder;
/**
 *  @author Clarence
 *
 *  水印字体，默认systemFontSize
 */
@property (nonatomic,strong)UIFont *fl_placeholderFont;
/**
 *  @author Clarence
 *
 *  水印颜色，默认lightGrayColor
 */
@property (nonatomic,strong)UIColor *fl_placeholderColor;

@end
