/*
 * author 孔凡列
 *
 * gitHub https://github.com/gitkong
 * cocoaChina http://code.cocoachina.com/user/
 * 简书 http://www.jianshu.com/users/fe5700cfb223/latest_articles
 * QQ 279761135
 * 喜欢就给个like 和 star 喔~
 */

#import <Foundation/Foundation.h>

@interface NSTimer (Block)
/**
 *  @author 孔凡列, 16-10-11 07:10:28
 *
 *  创建定时器，不管子线程还是主线程直接创建，无需添加到运行循环或者开启运行循环
 *
 *  @param interval 执行间隔
 *  @param repeat   是否重复执行block回调
 *  @param handle  block回调
 *
 *  @return 返回时间对象
 */
+ (NSTimer *)fl_timer:(NSTimeInterval)interval repeat:(BOOL)repeat handle:(void(^)(NSTimer *timer))handle;

@end
