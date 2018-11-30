//
//  skWXPayModel.h
//  SkyerParking
//
//  Created by admin on 2018/7/24.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skWXPayModel : NSObject
//微信支付模型
@property (nonatomic, strong) NSString * appid;
@property (nonatomic, strong) NSString * noncestr;
@property (nonatomic, strong) NSString * package;
@property (nonatomic, strong) NSString * partnerid;
@property (nonatomic, strong) NSString * prepayid;
@property (nonatomic, strong) NSString * sign;
@property (nonatomic, assign) int timestamp;
@end
