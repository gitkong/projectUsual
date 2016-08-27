//
//  FLBundleVersion.m
//  test
//
//  Created by clarence on 16/8/24.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "FLBundleVersion.h"

@implementation FLBundleVersion

+ (instancetype)shareBundleVersion{
    static FLBundleVersion *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FLBundleVersion alloc] init];
    });
    return instance;
}

/**
 *  @author 孔凡列, 16-08-24 18:08:35
 *
 *  本地的bundleVersion 是否最新
 *
 *  @return 最新返回YES，否则NO
 */
- (BOOL)isLocalBundleVersionRecently{
    // Bundle version is the internal version number of your app.
    // Short version string is the publically visible version of your app.
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if (version) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"localBundleVersion"] isEqualToString:version]) {
            // 相等，最新
            [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"localBundleVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
        else{
            return NO;
        }
    }
    return NO;
}

/**
 *  @author 孔凡列, 16-08-24 18:08:35
 *
 *  app stone的bundleVersion 是否最新
 *
 *  @return 最新返回YES，否则NO
 */

- (BOOL)isNetworkBundleVersionRecently{
    NSAssert(self.appId, @"需要提供AppStore上的appID");
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",self.appId]];
    __block BOOL flag = YES;
    // 在主线程处理，保证先请求后return
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (response) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                NSArray *arr = [json objectForKey:@"results"];
                NSString *version = [arr.firstObject objectForKey:@"version"];
                if ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] isEqualToString:version]) {
                    flag = YES;
                }
                else{
                    flag = NO;
                }
            }
            else{
                flag = NO;
            }
            
        }] resume];
    });
    return flag;
}


@end
