//
//  userLoginDispose.m
//  SkyerParking
//
//  Created by admin on 2018/8/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "userLoginDispose.h"
#import "skValiMobile.h"

@implementation userLoginDispose
-(void)setUp{
    
    _btnEnableSignal=[RACSignal combineLatest:@[RACObserve(self, loginPhone),RACObserve(self, loginPwd)] reduce:^id _Nonnull(NSString * loginPhone,NSString * loginPwd){
        NSLog(@"loginPhone=%@loginPwd=%@",loginPhone,loginPwd);
        if (![skValiMobile valiMobile:loginPhone]) {
            return 0;
        }
        if (loginPwd.length<6) {
            return 0;
        }
        if (loginPwd.length>20) {
            return 0;
        }
        return @(loginPhone.length && loginPwd.length);
        
    }];
}
@end
