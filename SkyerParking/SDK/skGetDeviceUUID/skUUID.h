//
//  skUUID.h
//  SkyerParking
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFHFKeychainUtils.h"
#import "DYDeviceInfo.h"


@interface skUUID : NSObject
/**
 获取UUID
 
 @return UUID
 */
+(NSString*)skGetDeviceUUID;

/**
 伪造的IMEI

 @return 返回IMEI
 */
+(NSString *)skGetDeviceIMEI;
@end
