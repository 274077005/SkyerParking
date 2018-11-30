//
//  userCenterInfoModel.h
//  SkyerParking
//
//  Created by admin on 2018/8/29.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userCenterInfoModel : NSObject
@property (nonatomic, strong) NSString * alipay;
@property (nonatomic, assign) CGFloat balance;
@property (nonatomic, strong) NSString * birthDay;
@property (nonatomic, strong) NSString * checkPassedTime;
@property (nonatomic, assign) CGFloat coins;
@property (nonatomic, strong) NSString * driveLicNo;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString * headPic;
@property (nonatomic, strong) NSString * idcardBack;
@property (nonatomic, strong) NSString * idcardFront;
@property (nonatomic, strong) NSString * idcardNo;
@property (nonatomic, assign) BOOL isAutoPay;
@property (nonatomic, assign) BOOL isOnline;
@property (nonatomic, assign) NSInteger isRealname;
@property (nonatomic, strong) NSString * loginIp;
@property (nonatomic, strong) NSString * loginName;
@property (nonatomic, assign) NSString * memberId;
@property (nonatomic, strong) NSString * memberName;
@property (nonatomic, strong) NSString * memberNo;
@property (nonatomic, strong) NSString * memberPhoto;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * qq;
@property (nonatomic, strong) NSString * registTime;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) CGFloat tingchebis;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, assign) NSInteger vipLevel;
@property (nonatomic, strong) NSString * wechat;
@property (nonatomic, strong) NSString * weibo;
@end
