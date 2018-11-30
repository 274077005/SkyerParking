//
//  RegisterModel.h
//  SkyerParking
//
//  Created by admin on 2018/7/12.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *pwd;
@property (nonatomic,strong) NSString *pwdAgain;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *isGetCode;//如果是1就要等待60秒再能获取验证码
@property (nonatomic,strong) RACSignal *btnEnableSignal;

@end
