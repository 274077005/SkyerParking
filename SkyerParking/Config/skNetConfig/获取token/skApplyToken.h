//
//  skApplyToken.h
//  SkyerParking
//
//  Created by admin on 2018/7/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skApplyToken : NSObject

/**
 获取token

 @param success 成功返回数据
 */
+(void)applyToken:(void (^)(skResponeModel *model))success
          failure:(Failure)failure;

/**
 更新token

 @param success 成功返回数据
 */
+(void)reApplyToken:(void (^)(skResponeModel *model))success
            failure:(Failure)failure;
/**
 获取本地时间戳
 
 @return 时间戳字符串
 */
+(NSTimeInterval)getCurrentTimestamp;
@end
