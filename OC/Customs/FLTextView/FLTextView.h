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

typedef void(^TextContentBlock)(NSString *textContent);

@interface FLTextView : UITextView

/**
 *  @author Clarence
 *
 *  水印
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  @author Clarence
 *
 *  水印字体
 */
@property (nonatomic, strong) UIFont *placeholderFont;
/**
 *  @author Clarence
 *
 *  水印颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  @author Clarence
 *
 *  结束编辑的时候利用block传递text出去
 */
@property (nonatomic,copy)TextContentBlock textContentBlock;

@end
