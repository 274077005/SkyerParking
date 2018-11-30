//
//  skParameDealMethod.h
//  SkyerParking
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CommonCrypto/CommonDigest.h>
#import "skApplyClientModel.h"
#import "skModulesModel.h"

@interface skParameDealMethod : NSObject

/**
 初始化子模块

 @param intfName 接口
 */
+(void) skInitMudlesWithInterface:(NSString *)intfName;
+(void) skInitMudlesWithInterfaceForskApplyToken:(NSString *)intfName;
/**
 参数格式化

 @param parame 参数
 @return 返回格式话参数
 */
+(NSString *)skRequestParameterseFormatting:(NSDictionary *)parame;
/**
 MD5加密
 
 @param input 输入参数
 @return 返回加密的结果
 */
+ (NSString *) MD5:(NSString *) input;

@end
