/*
 *  @author Clarence-lie 孔凡列
 *
 *  QQ：279761135
 *
 *  gitHub：https://github.com/gitkong
 *  cocoaChina：http://code.cocoachina.com/user/index/upload/
 *  简书 ： http://www.jianshu.com/users/fe5700cfb223/latest_articles
 *  喜欢给个like & star呗~
 */

#import <Foundation/Foundation.h>
/**
 *  @author Clarence-lie, 16-09-08 21:09:07
 *
 *  子类继承，对应不同的控制器所需的参数，添加对应的属性到子类中，默认层级都是同一级，子类可重写fl_remotePushModel方法，对应不同的字典转模型
 *
 *  注意一点：子类中所添加的属性，应该都为对象，基本数据类型不行喔，而且后台返回的都是对象，基本数据用NSNumber包装
 */
@interface FLRemotePushModel : NSObject
/**
 *  @author Clarence-lie, 16-09-08 22:09:01
 *
 *  需要跳转的类名，后台返回
 */
@property (nonatomic,copy)NSString *className;
/**
 *  @author Clarence-lie, 16-09-08 22:09:38
 *
 *  字典转模型，可重写,根据不同格式转模型(如果重写，需要调用父类)
 *
 *  @param dict 后台返回的字典（json）
 *
 *  @return 返回一个模型
 */
+ (instancetype)fl_remotePushModel:(NSDictionary *)dict;

@end

@interface FLRemotePushManager : NSObject

+ (instancetype)fl_shareInstance;
/**
 *  @author Clarence-lie, 16-09-08 22:09:59
 *
 *  根据模型内容跳转到指定界面
 *
 *  @param remotePushModel FLRemotePushModel子类
 */
- (void)fl_pushWithRemotePushModel:(FLRemotePushModel *)remotePushModel;

@end
