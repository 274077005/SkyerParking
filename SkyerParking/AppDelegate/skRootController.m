//
//  skRootController.m
//  SkyerParking
//
//  Created by admin on 2018/8/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skRootController.h"
#import "skShowViewController.h"
#import "AppDelegate.h"
#import "skUserLoginViewController.h"
#import "GuidanceViewController.h"
#import "skTabarViewController.h"
#import "skValiMobile.h"
#import "SFHFKeychainUtils.h"
#import "skGetNetConfig.h"
#import "skJPUSHSet.h"

@implementation skRootController
+(void)skFirstViewController{
    
    skAppDelegate.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    skAppDelegate.window.backgroundColor=[UIColor whiteColor];
    [skAppDelegate.window makeKeyAndVisible];
    skShowViewController *firstView=[[skShowViewController alloc] init];
    skAppDelegate.window.rootViewController=firstView;
    //获取网络配置文件
    [skGetNetConfig skAppStartApply:^(skResponeModel *model) {
        [self skStarAppViewController];
    } failure:^(NSError * _Nullable error) {
        [self skStarAppViewController];
    }];
}
+(void)skStarAppViewController{
    
    NSString *version1=[[NSUserDefaults standardUserDefaults] objectForKey:skAPPVersionSave];
    
    NSString *version2=skAppVersion;
    
    //版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
    NSInteger version3=[self compareVersion:version1 to:version2];
    if (version3<0) {//有新的版本
        [self skGuidanceViewController];
    }else{
        //如果自动登录就直接登录
        if ([[NSUserDefaults standardUserDefaults] objectForKey:skAutoLogin]) {
            [self login];
        }else{
            [self skTabbarViewController];
        }
        
    }
    
}
+(void)skLoginViewController{
    skUserLoginViewController *view=[[skUserLoginViewController alloc] init];

    skBaseNavViewController *viewNav=[[skBaseNavViewController alloc] initWithRootViewController:view];
    
    [skVSView.navigationController presentViewController:viewNav animated:YES completion:nil];
}
+(void)skTabbarViewController{
    
    skTabarViewController *view=[[skTabarViewController alloc] init];
    
    skAppDelegate.window.rootViewController=view;
    
}
//引导页
+(void)skGuidanceViewController{
    GuidanceViewController *view=[[GuidanceViewController alloc] init];
    skAppDelegate.window.rootViewController=view;
}
+(void)skUserLoginOutViewController{
    skUser.phone=@"";//退出登录就清空用户账号
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:skAutoLogin];
    [skVSView.navigationController popToRootViewControllerAnimated:YES];
}
/**
 比较两个版本号的大小
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 */
+ (NSInteger)compareVersion:(NSString *)v1 to:(NSString *)v2 {
    // 都为空，相等，返回0
    if (!v1 && !v2) {
        return 0;
    }
    
    // v1为空，v2不为空，返回-1
    if (!v1 && v2) {
        return -1;
    }
    
    // v2为空，v1不为空，返回1
    if (v1 && !v2) {
        return 1;
    }
    
    // 获取版本号字段
    NSArray *v1Array = [v1 componentsSeparatedByString:@"."];
    NSArray *v2Array = [v2 componentsSeparatedByString:@"."];
    // 取字段最少的，进行循环比较
    NSInteger smallCount = (v1Array.count > v2Array.count) ? v2Array.count : v1Array.count;
    
    for (int i = 0; i < smallCount; i++) {
        NSInteger value1 = [[v1Array objectAtIndex:i] integerValue];
        NSInteger value2 = [[v2Array objectAtIndex:i] integerValue];
        if (value1 > value2) {
            // v1版本字段大于v2版本字段，返回1
            return 1;
        } else if (value1 < value2) {
            // v2版本字段大于v1版本字段，返回-1
            return -1;
        }
        
        // 版本相等，继续循环。
    }
    
    // 版本可比较字段相等，则字段多的版本高于字段少的版本。
    if (v1Array.count > v2Array.count) {
        return 1;
    } else if (v1Array.count < v2Array.count) {
        return -1;
    } else {
        return 0;
    }
    
    return 0;
}
+(void)login{
    
    NSString *userName=[SFHFKeychainUtils getPasswordForUsername:skLoginUserName andServiceName:skLoginUserName error:nil];
    NSString *userPWD=[SFHFKeychainUtils getPasswordForUsername:skLoginUserPWD andServiceName:skLoginUserPWD error:nil];
    
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/login"];
    
    NSDictionary *parame=@{@"phone":userName,
                           @"passwd":[userPWD skMD5:userPWD],
                           @"clientType":skClientType,
                           @"version":skAppVersion,
                           @"IMEI":[skUUID skGetDeviceIMEI],
                           @"pushRegistrerId":[skJPUSHSet sharedskJPUSHSet].skRegistrationID?[skJPUSHSet sharedskJPUSHSet].skRegistrationID:@"12345"
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        [UserLoginModel mj_objectWithKeyValues:responseObject.data];
        //不管成功或者失败都跳到首页
        [self skTabbarViewController];
        
    } failure:^(NSError * _Nullable error) {
        [self skLoginViewController];
    }];
}
@end
