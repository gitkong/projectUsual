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

#import "FLRemotePushManager.h"
#import <objc/runtime.h>
@import UIKit;
@implementation FLRemotePushModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+ (instancetype)fl_remotePushModel:(NSDictionary *)dict{
    FLRemotePushModel *model = [[self alloc] initWithDict:dict];
    return model;
}

#pragma mark - private method

/**
 *  @author Clarence-lie, 16-09-08 22:09:33
 *
 *  通过字符串来创建该字符串的getter方法
 *
 *  @param propertyName 属性名
 *
 *  @return 对应的getter方法
 */
- (SEL)fl_creatGetterWithPropertyName: (NSString *) propertyName{
    //1.返回get方法: oc中的get方法就是属性的本身
    return NSSelectorFromString(propertyName);
}

/**
 *  @author Clarence-lie, 16-09-08 22:09:49
 *
 *  获取指定属性名对应的值
 *
 *  @param propertyName 属性名
 *
 *  @return 属性值
 */
- (id)fl_getValueByPropertyName:(NSString *)propertyName{
    //获取get方法
    SEL getSel = [self fl_creatGetterWithPropertyName:propertyName];
    
    if ([self respondsToSelector:getSel]) {
        
        //获得方法的签名
        NSMethodSignature *signature = [self methodSignatureForSelector:getSel];
        
        //从签名获得调用对象
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        
        //设置target
        [invocation setTarget:self];
        
        //设置selector
        [invocation setSelector:getSel];
        
        //接收返回的值
        NSObject *__unsafe_unretained returnValue = nil;
        
        //发消息
        [invocation invoke];
        
        //接收返回值
        [invocation getReturnValue:&returnValue];
        
        return returnValue;
    }
    else{
        return nil;
    }
}


@end

@implementation FLRemotePushManager
+ (instancetype)fl_shareInstance{
    static FLRemotePushManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)fl_pushWithRemotePushModel:(FLRemotePushModel *)remotePushModel{
    [self fl_push:remotePushModel];
}


#pragma mark - private method
/**
 *  @author Clarence-lie, 16-09-08 22:09:04
 *
 *  跳转控制器
 *
 *  @param remotePushModel 跳转所需参数模型
 */
- (void)fl_push:(FLRemotePushModel *)remotePushModel{
    // 类名
    NSString *class = remotePushModel.className;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass){
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建控制器对象
    id instance = [[newClass alloc] init];
    
    // 获取模型的属性名数组（不包含父类的className属性）
    NSArray *remotePushModelPropertyArr = [self fl_getRemoteModelProperty:remotePushModel];
    
    [remotePushModelPropertyArr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 检测这个控制器对象是否存在该属性
        NSString *error = [NSString stringWithFormat:@"%@模型中属性%@ 在 %@控制器中没有或者属性名不一样",remotePushModel.class,obj,remotePushModel.className];
        NSAssert([self fl_checkIsExistPropertyWithInstance:instance verifyPropertyName:obj], error);
        // 获取属性名对应的value 利用kvc赋值
        [instance setValue:[remotePushModel fl_getValueByPropertyName:obj] forKey:obj];
    }];
    
    
    // 跳转控制器
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabVc = (UITabBarController *)vc;
        UINavigationController *nav = (UINavigationController *)tabVc.viewControllers[tabVc.selectedIndex];
        [nav pushViewController:instance animated:YES];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)vc;
        [nav pushViewController:instance animated:YES];
    }
}

/**
 *  @author Clarence-lie, 16-09-08 22:09:34
 *
 *  检测控制器对象是否存在该属性（与模型的比较）
 *
 *  @param instance           对象
 *  @param verifyPropertyName 有效的属性名
 *
 *  @return YES OR NO
 */
- (BOOL)fl_checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName{
    
    unsigned int outCount, i;
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}

/**
 *  @author 孔凡列, 16-09-10 02:09:07
 *
 *  获取模型的属性名数组
 *
 *  @param remotePushModel 模型
 *
 *  @return 模型属性名数组
 */
- (NSArray *)fl_getRemoteModelProperty:(FLRemotePushModel *)remotePushModel{
    unsigned int outCount, i;
    // 获取模型对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([remotePushModel
                                                           class], &outCount);
    // 属性名数组
    NSMutableArray *propertyArrM = [NSMutableArray array];
    for (i = 0; i < outCount; i ++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // className 不需要添加到里面，父类属性，肯定是第一个，除非手动更改了
        if (![propertyName isEqualToString:propertyArrM.firstObject]) {
            [propertyArrM addObject:propertyName];
        }
    }
    
    free(properties);
    
    return propertyArrM;
}

@end
