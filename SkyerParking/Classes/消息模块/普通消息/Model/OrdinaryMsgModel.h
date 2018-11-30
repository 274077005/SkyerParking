//
//  OrdinaryMsgModel.h
//  SkyerParking
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrdinaryMsgModel : NSObject
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * pushAccountName;
@property (nonatomic, assign) NSInteger pushClientType;
@property (nonatomic, strong) NSString * pushContent;
@property (nonatomic, assign) NSInteger pushId;
@property (nonatomic, assign) BOOL pushIsused;
@property (nonatomic, strong) NSString * pushLoginName;
@property (nonatomic, strong) NSString * pushRegistrationId;
@property (nonatomic, strong) NSString * pushTime;
@property (nonatomic, assign) NSInteger pushType;
@end
