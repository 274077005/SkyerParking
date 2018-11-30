//
//  AdvertisingModel.h
//  SkyerParking
//
//  Created by admin on 2018/8/29.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisingModel : NSObject
@property (nonatomic, assign) NSInteger adId;
@property (nonatomic, strong) NSString * advertisingNo;
@property (nonatomic, strong) NSString * advertisingPic;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) BOOL isFlag;
@end
