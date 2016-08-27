//
//  FLAdvertiseHelper.m
//  test
//
//  Created by 孔凡列 on 16/8/20.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLAdvertiseHelper.h"
#import "FLAdvertiseView.h"
@implementation FLAdvertiseHelper
+ (instancetype)fl_sharedInstance
{
    static FLAdvertiseHelper* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FLAdvertiseHelper new];
    });
    
    return instance;
}


+(void)fl_showAdvertiserView:(NSArray *)imageArray
{
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示,没有，则下载后显示并保存
    [[FLAdvertiseHelper fl_sharedInstance] getAdvertisingImage:imageArray];
    
}


/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage:(NSArray *)imageArray
{
    //随机取一张
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
    else{
        FLAdvertiseView *advertiseView = [[FLAdvertiseView alloc] initWithFrame:kAdMain_Screen_Bounds];
        advertiseView.filePath = filePath;
        [advertiseView fl_show];
    }
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}


/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kAdUserDefaults setValue:imageName forKey:adImageName];
            [kAdUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
            
            dispatch_async(dispatch_get_main_queue(), ^{
                FLAdvertiseView *advertiseView = [[FLAdvertiseView alloc] initWithFrame:kAdMain_Screen_Bounds];
                advertiseView.filePath = filePath;
                [advertiseView fl_show];
            });
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kAdUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}
@end
