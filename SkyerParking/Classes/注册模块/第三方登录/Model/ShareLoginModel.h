//
//  ShareLoginModel.h
//  SkyerParking
//
//  Created by admin on 2018/9/7.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareLoginModel : NSObject
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) RACSignal *btnEnableSignal;
@property (nonatomic, assign) BOOL isGetCode;//是否可以获取验证码
@end
