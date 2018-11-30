//
//  changeModel.m
//  SkyerParking
//
//  Created by admin on 2018/7/18.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "changeModel.h"
#import "skValiMobile.h"

@implementation changeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    
    _btnEnableSignal=[RACSignal combineLatest:@[RACObserve(self, phone),RACObserve(self, code),RACObserve(self, pwdnew),] reduce:^id _Nonnull(NSString * phone,NSString * code,NSString * pwd){
        if (![skValiMobile valiMobile:phone]) {
            return 0;
        }
        if (pwd.length<6) {
            return 0;
        }
        if (pwd.length>20) {
            return 0;
        }
        return @(phone.length && code.length && pwd.length);
    }];
}
@end
