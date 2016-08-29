//
//  toolsMacros.h
//
//  Created by 孔凡列 on 16/7/11.
//  Copyright © 2016年 czebd. All rights reserved.
//

#ifndef ToolsMacros_h
#define ToolsMacros_h

// 打印调试
#ifdef DEBUG
#define FLLog(...) NSLog(__VA_ARGS__)
#else
#define FLLog(...)
#endif

// block __weak & __strong 的使用
#define FLWeakSelf(sel) __weak typeof(sel) weak##sel = sel;
#define FLStrongSelf(sel) __strong typeof(sel) sel = weak##sel;

//取色器取颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define SAME_RGB(r) RGB(r,r,r)
#define RANDOM_RGB [UIColor colorWithRed:arc4random_uniform(256) / 255.0  green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

//获取系统时间戳
#define CURRENTTIME [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

// iPhone设备宽度
#define IPHONE5 (([UIScreen mainScreen].bounds.size.width == 320) ? 1 : 0)
#define IPHONE6 (([UIScreen mainScreen].bounds.size.width == 375) ? 1 : 0)
#define IPHONE6plus (([UIScreen mainScreen].bounds.size.width == 414) ? 1 : 0)

// 缓存文件路径
#define kPATH_TEMP                   NSTemporaryDirectory()
#define kPATH_DOCUMENT               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kPATH_CACHE                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#endif /* toolsMacros_h */
