//
//  userLoginDispose.h
//  SkyerParking
//
//  Created by admin on 2018/8/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userLoginDispose : NSObject
@property (nonatomic,strong) NSString *loginPhone;
@property (nonatomic,strong) NSString *loginPwd;
@property (nonatomic,strong) RACSignal *btnEnableSignal;
-(void)setUp;
@end
