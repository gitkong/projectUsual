//
//  FLFileManager.h
//
//  Created by 孔凡列 on 15/10/31.
//  Copyright © 2015年 clarence. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FLFileManager : NSObject

/**
 *  类方法-解档，获得用户账号/用户信息
 *
 *  @return 返回用户账号/用户信息模型
 */
+ (id)objectKeyedUnarchiverWithFileName:(NSString *)fileName;
/**
 *  类方法-归档，保存 用户账号/用户信息 到沙盒中
 *
 *  @param object 用户账号/用户信息
 *  @param name    指定保存的文件名字
 */
+ (void)objectKeyArchiverWithObject:(id)object fileName:(NSString *)name;


+ (void)deleteFileWithFileName:(NSString *)fileName;

// 创建文件
+ (void)createFileWithFileName:(NSString *)fileName;
@end
