//
//  getNearParkData.h
//  SkyerParking
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "nearParkModel.h"

@interface getNearParkData : NSObject
typedef void (^ _Nullable getNearList)(NSArray *arrList);

/**
 获取停车场数组

 @param latitude 精度
 @param longitude 维度
 @param keyword 关键字
 @param list 返回的数组
 */
+(void)parksNearByLatitude:(double)latitude longitude:(double)longitude keyword:(NSString *)keyword page:(int)page rows:(int)rows arrList:(getNearList)list ;
@end
