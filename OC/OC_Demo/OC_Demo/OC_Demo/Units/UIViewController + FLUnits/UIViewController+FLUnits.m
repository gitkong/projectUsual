/*
 *  @author Clarence-lie 孔凡列
 *
 *  QQ：279761135
 *
 *  gitHub：https://github.com/gitkong
 *  cocoaChina：http://code.cocoachina.com/user/index/upload/
 */

#import "UIViewController+FLUnits.h"
#import <objc/runtime.h>
@implementation UIViewController (FLUnits)

static char fl_tarnsitionStyle;

- (void)setTransitionStyle:(FLTransitionStyle)transitionStyle{
    objc_setAssociatedObject(self, &fl_tarnsitionStyle, @(transitionStyle), OBJC_ASSOCIATION_ASSIGN);
    
}

- (FLTransitionStyle)transitionStyle{
    NSNumber *style = objc_getAssociatedObject(self, &fl_tarnsitionStyle);
    switch (style.integerValue) {
        case 0:
            return FLTransitionStylePush;
            break;
            
        default:
            return FLTransitionStyleModal;
            break;
    }
}

- (FLTransitionStyle)fl_judgeTranstion{
    //    判断是被push还是被modal出来的;
    
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self;
        viewcontrollers = nav.viewControllers;
    }
    if (viewcontrollers.count>1) {
        
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            return FLTransitionStylePush;
        }
        else{
            return FLTransitionStyleModal;
        }
    }
    else{
        //present方式
        return FLTransitionStyleModal;
    }
}



@end
