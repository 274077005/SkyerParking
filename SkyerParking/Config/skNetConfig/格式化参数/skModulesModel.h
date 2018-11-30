//
//  basicModel.h
//  SkyerParking
//
//  Created by admin on 2018/7/5.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface skModulesModel : NSObject

SkyerSingletonH(skModulesModel)

@property (nonatomic,strong) NSString *systemId;
@property (nonatomic,strong) NSString *clientId;
@property (nonatomic,strong) NSString *clientName;
@property (nonatomic,strong) NSString *accessKey;
@property (nonatomic,strong) NSString *readTimeout;
@property (nonatomic,strong) NSString *enName;
@property (nonatomic,strong) NSString *gzip;
@property (nonatomic,strong) NSString *securityKey;
@property (nonatomic,strong) NSString *entranceUrl;
@property (nonatomic,strong) NSString *connTimeout;
@property (nonatomic,strong) NSString *intfName;
//服务器申请的token(注意,申请和更新的是accessToken,是用来做数据签名的,还有一个token是用户登录的token)
//@property (nonatomic,strong) NSString *accessToken;



@end
