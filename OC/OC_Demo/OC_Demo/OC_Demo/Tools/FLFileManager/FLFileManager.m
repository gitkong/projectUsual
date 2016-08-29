//
//  FLFileManager.m
//
//  Created by 孔凡列 on 15/10/31.
//  Copyright © 2015年 clarence. All rights reserved.
//

#import "FLFileManager.h"
@implementation FLFileManager

/**
 *  类方法-解档，获得用户账号/用户信息/微博信息
 *
 *  @return 返回用户账号/用户信息模型
 */
+ (id)objectKeyedUnarchiverWithFileName:(NSString *)fileName{
    // 获得沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接文件名
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    return object;
}
/**
 *  类方法-归档，保存 用户账号/用户信息 到沙盒中
 *
 *  @param object 用户账号/用户信息/微博信息
 *  @param name    指定保存的文件名字
 */
+ (void)objectKeyArchiverWithObject:(id)object fileName:(NSString *)name{
    // 获得沙盒路径
//    NSCachesDirectory
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接文件名
    NSString *filePath = [path stringByAppendingPathComponent:name];
    // 取出账号
    [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}


+ (void)deleteFileWithFileName:(NSString *)fileName{
    // 获得沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 拼接文件名
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    // 如果没有就找NSCachesDirectory
    if (![fileManager fileExistsAtPath:filePath]) {
        path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        filePath = [path stringByAppendingPathComponent:fileName];
    }
    
    [fileManager removeItemAtPath:filePath error:nil];
}

// 创建文件
+ (void)createFileWithFileName:(NSString *)fileName{
    // 获得沙盒路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 拼接文件名
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
}

@end
