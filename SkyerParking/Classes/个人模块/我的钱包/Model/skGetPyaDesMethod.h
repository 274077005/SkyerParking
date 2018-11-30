//
//  skGetPyaDesMethod.h
//  SkyerParking
//
//  Created by admin on 2018/8/29.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, skGetPyaDes)
{
    skGetPyaDesBalance=1,//余额
    skGetPyaDesTCBI,//停车币
    
};
@interface skGetPyaDesMethod : NSObject
/**
 获取停车币或者余额消费详情
 
 @param type 1是余额,2是停车币
 */
+(void)skBizMemberConsumerDetails:(skGetPyaDes)type rows:(NSInteger)rows arrList:(getList)getList respData:(getRespData)resData;
@end
