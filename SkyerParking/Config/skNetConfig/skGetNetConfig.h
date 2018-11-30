//
//  skGetNetConfig.h
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skGetNetConfig : NSObject

/**
 app启动的时候获取配置文件
 */
+(void)skAppStartApply:(void (^)(skResponeModel *model))success
               failure:(Failure)failure;

/**
 app登录的时候获取配置文件
 */
+(void)skAPPLoginUpdateToken;
//获取URL
+(NSString *)skGetURL;
@end
