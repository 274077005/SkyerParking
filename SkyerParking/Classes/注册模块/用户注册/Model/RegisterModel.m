//
//  RegisterModel.m
//  SkyerParking
//
//  Created by admin on 2018/7/12.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    
    _btnEnableSignal=[RACSignal combineLatest:@[RACObserve(self, phone),RACObserve(self, code),RACObserve(self, pwd),RACObserve(self, pwdAgain),] reduce:^id _Nonnull(NSString * phone,NSString * code,NSString * pwd,NSString * pwdAgain){
        
        return @(phone.length && code.length && pwd.length && pwdAgain.length);
        
    }];
}
@end
