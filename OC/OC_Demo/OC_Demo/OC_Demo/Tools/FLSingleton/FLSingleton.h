// ## :拼接前后两个字符串
#define FLSingleton_h(name)  +(instancetype)shared##name;
#if __has_feature(objc_arc) // arc
    #define FLSingleton_m(name) \
    +(instancetype)shared##name{ \
        return [[self alloc] init]; \
    }\
    \
    - (id)copyWithZone:(NSZone *)zone{\
    return self;\
    }\
    \
    + (instancetype)allocWithZone:(struct _NSZone *)zone {\
    static id instance;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        instance = [super allocWithZone:zone];\
    });\
    return instance;\
    }

#else // 非arc
    #define FLSingleton_m(name) \
    +(instancetype)shared##name{ \
    return [[self alloc] init]; \
    }\
    \
    - (id)copyWithZone:(NSZone *)zone{\
        return self;\
    }\
    \
    + (instancetype)allocWithZone:(struct _NSZone *)zone {\
    static id instance;\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    instance = [super allocWithZone:zone];\
    });\
    return instance;\
    }\
    - (oneway void)release {\
        \
    }\
    \
    - (instancetype)autorelease {\
        return self;\
    }\
    \
    - (instancetype)retain {\
        return self;\
    }
#endif