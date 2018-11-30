//
//  skZFUResult.m
//  SkyerParking
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skZFUResult.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation skZFUResult
SkyerSingletonM(skZFUResult)
-(void)skResult:(NSURL *)url{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"支付宝支付结果= %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] integerValue]==9000) {
                [self paySuccess];
            }else{
                [self payFaile];
            }
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
}

-(void)paySuccess{
    
}
-(void)payFaile{
    
}
@end
