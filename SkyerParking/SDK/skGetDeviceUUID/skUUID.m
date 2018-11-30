//
//  skUUID.m
//  SkyerParking
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skUUID.h"
#define skDeviceUUID @"skDeviceUUID"
#import "skParameDealMethod.h"

@implementation skUUID

+(NSString *)skGetDeviceUUID{
    
    NSString *skUUID=[SFHFKeychainUtils getPasswordForUsername:skDeviceUUID andServiceName:skDeviceUUID error:nil];
    
    if (skUUID==nil) {
        skUUID=[DYDeviceInfo dy_getDeviceUUID];
        [SFHFKeychainUtils storeUsername:skDeviceUUID andPassword:skUUID forServiceName:skDeviceUUID updateExisting:YES error:nil];
    }
    return skUUID;
}

+(NSString *)skGetDeviceIMEI{
    
    NSString *skUUID=[self skGetDeviceUUID];
    //加密变成安卓和后台和
    skUUID=[skParameDealMethod MD5:skUUID];
    //清除测试
    //    [SFHFKeychainUtils deleteItemForUsername:skDeviceUUID andServiceName:skDeviceUUID error:nil];
    NSLog(@"IMEI=%@",skUUID);
    return skUUID;
}

@end
