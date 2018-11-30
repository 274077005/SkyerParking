//
//  skInitBasicModel.m
//  SkyerParking
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skApplyClientMethods.h"
#import "skUUID.h"
#import "skParameDealMethod.h"
#import "skApplyToken.h"


@implementation skApplyClientMethods

/**
 获取配置文件

 @param success 返回成功
 */
+(void)skApplyClient:(void (^)(skResponeModel *model))success
             failure:(Failure)failure{
    NSString *uuid=[NSString stringWithFormat:@"%@",[skUUID skGetDeviceUUID]];
    
    NSString *MD5uuid=[skParameDealMethod MD5:[NSString stringWithFormat:@"9932838239030943%@^S-(3+2,kd/sOp!.<337++.><.2*GX@#!MAKDL]$WwXJ]~",uuid]];
    
    NSString*parame=[NSString stringWithFormat:@"equipUUID=%@&signature=%@",uuid,MD5uuid];
    
    NSLog(@"申请配置文件参数=%@",parame);
    
    [[SKNetworking sharedSKNetworking] SKPOST:applyClientURL parameters:parame showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        success(responseObject);
        NSDictionary *dic=responseObject.data;
        //        NSLog(@"服务器的配置文件=%@",dic);
        skApplyClientModel *ApplyClientModel=[skApplyClientModel mj_objectWithKeyValues:dic];
        NSLog(@"获取服务器配置参数成功=%@",ApplyClientModel);
        //配置参数获取完成就开始请求token
        [skParameDealMethod skInitMudlesWithInterface:@"/intf/access/applyToken"];
        
    } failure:^(NSError * _Nullable error) {
        NSLog(@"配置文件error==%@",error);
        if (error.code!=404) {
            failure(error);
        }
    }];
}

@end
