//
//  plateModel.h
//  SkyerParking
//
//  Created by admin on 2018/9/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface plateModel : NSObject
@property (nonatomic, strong) NSString * cityAlias;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * driveLicNo;
@property (nonatomic, strong) NSString * idcardBack;
@property (nonatomic, strong) NSString * idcardFront;
@property (nonatomic, assign) BOOL isAutoPay;
@property (nonatomic, strong) NSString * isAutoPayName;
@property (nonatomic, assign) NSInteger isRealname;
@property (nonatomic, strong) NSString * isRealnameName;
@property (nonatomic, assign) NSInteger owner;
@property (nonatomic, strong) NSString * plateCardNo;
@property (nonatomic, assign) NSInteger plateId;
@property (nonatomic, strong) NSString * plateNo;
@property (nonatomic, strong) NSString * provAlias;
@end
