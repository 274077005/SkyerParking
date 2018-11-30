//
//  AppDelegate.m
//  SkyerParking
//
//  Created by admin on 2018/6/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "AppDelegate.h"
#import "SKKeyboard.h"
#import "SKNavigation.h"
#import "skUserLoginViewController.h"
#import "skBaseNavViewController.h"
#import "skTabarViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "skJPUSHSet.h"
#import "skUUID.h"
#import "BMKMapInit.h"
#import "WXApiManager.h"
#import "skGetNetConfig.h"
#import <AlipaySDK/AlipaySDK.h>
#import "skZFUResult.h"
#import "skRootController.h"
#import "skModShareConfig.h"
#import "skIflyMSC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"程序入口");
    if ([skBundleID isEqualToString:@"com.skyer.TingCheDao"]) {//防逆向客户端验证
        //极光推送
        [[skJPUSHSet sharedskJPUSHSet] skJpushSet:launchOptions];
        //uuid的获取
        [skUUID skGetDeviceUUID];
        //初始化键盘管理器
        [SKKeyboard skMangerKeyboard];
        //初始化导航栏
        [SKNavigation skNavigationInit];
        //配置高德Key
        [AMapServices sharedServices].apiKey = kMapAPIKey;
        //初始化百度地图
        [BMKMapInit skInitBMKMap];
        //向微信注册,发起支付必须注册
        [WXApi registerApp:WXRegisterID enableMTA:YES];
        //第三方分享登录
        [skModShareConfig skShareRegist];
        //讯飞语音
        [[[skIflyMSC alloc] init] ifUserXunFei];
        //初始化程序的第一个页面
        [skRootController skFirstViewController];
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


//后台语音播报需要申请后台不杀生
- (void)applicationDidEnterBackground:(UIApplication *)application {
    application.applicationIconBadgeNumber=0;
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //更新token
    
    [skGetNetConfig skAPPLoginUpdateToken];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    [[skZFUResult sharedskZFUResult] skResult:url];

    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    
}


@end
