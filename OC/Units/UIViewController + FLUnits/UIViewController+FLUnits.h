/*
 *  @author Clarence-lie 孔凡列
 *
 *  QQ：279761135
 *
 *  gitHub：https://github.com/gitkong
 *  cocoaChina：http://code.cocoachina.com/user/index/upload/
 */


#import <UIKit/UIKit.h>

typedef enum {
    FLTransitionStylePush,
    FLTransitionStyleModal,
} FLTransitionStyle;

@interface UIViewController (FLUnits)

//@property (nonatomic,assign)FLTransitionStyle transitionStyle;
/**
 *  @author Clarence-lie, 16-08-23 10:08:23
 *
 *  判断跳转方式，Push OR Modal
 *
 *  @return
 */
- (FLTransitionStyle)fl_judgeTranstion;

@end
