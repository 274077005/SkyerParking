//
//  ShareLoginModel.m
//  SkyerParking
//
//  Created by admin on 2018/9/7.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ShareLoginModel.h"
#import "skValiMobile.h"

@implementation ShareLoginModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setUp{
    
    _btnEnableSignal=[RACSignal combineLatest:@[RACObserve(self, phone),RACObserve(self, code)] reduce:^id _Nonnull(NSString * phone,NSString * code){
        if (![skValiMobile valiMobile:phone]) {
            return 0;
        }
        return @(phone.length && code.length);
    }];
}

@end
