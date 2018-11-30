//
//  skOrderParkModel.h
//  SkyerParking
//
//  Created by admin on 2018/9/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skOrderParkModel : NSObject
@property (nonatomic, assign) CGFloat beforeDiscountMoney;
@property (nonatomic, assign) NSInteger blance;
@property (nonatomic, strong) NSString * carType;
@property (nonatomic, strong) NSString * charge;
@property (nonatomic, assign) NSString * chargeMoney;
@property (nonatomic, strong) NSString * chargeName;
@property (nonatomic, strong) NSString * duration;
@property (nonatomic, strong) NSString * enterTime;
@property (nonatomic, strong) NSString * licPlateNo;
@property (nonatomic, assign) NSInteger orderId;
@property (nonatomic, strong) NSString * orderNo;
@property (nonatomic, assign) NSInteger orderStatus;
@property (nonatomic, strong) NSString * parkName;
@property (nonatomic, assign) BOOL payStatus;
@property (nonatomic, assign) NSInteger tingchebis;
@property (nonatomic, strong) NSString * workDateType;
@end
