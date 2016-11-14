//
//  AppDelegate.m
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FLIntroductoryPagesHelper.h"
#import "FLFeatureManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible ];
    
    [[FLFeatureManager shareManager] fl_showFeatureView:@[@"recordBackgroundImage 1",@"recordBackgroundImage 2",@"recordBackgroundImage 3"]];
//    [FLFeatureManager shareManager].currentIndex = 2;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点我移除新特性" forState:UIControlStateNormal];
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 200) / 2, [UIScreen mainScreen].bounds.size.height - 80, 200, 30);
//    btn.center = [FLFeatureManager shareManager].lastFeatureView.center;
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [[FLFeatureManager shareManager].lastFeatureView addSubview:btn];
//    [FLFeatureManager shareManager].lastFeatureViewClickToDismiss = NO;
    [FLFeatureManager shareManager].lastFeatureViewSwipToDismiss = YES;
    
    return YES;
}

- (void)click{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要移除吗？" message:nil delegate:nil cancelButtonTitle:@"NO" otherButtonTitles: nil];
    [alert show];
//    [[FLFeatureManager shareManager] fl_removeFeatureView];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
