//
//  skApplyToken.m
//  SkyerParking
//
//  Created by admin on 2018/7/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skApplyToken.h"
#import "applyTokenModel.h"

@implementation skApplyToken
//获取令牌
+(void)applyToken:(void (^)(skResponeModel *model))success
          failure:(Failure)failure{
    
    if (!skAccessToken) {
        [skParameDealMethod skInitMudlesWithInterfaceForskApplyToken:@"/intf/access/applyToken"];
        
        NSString *urlstr=[NSString stringWithFormat:@"%@%@",skMoModel.entranceUrl,skMoModel.intfName];
        
        NSString *clientId=skMoModel.clientId;
        NSString *systemId=skMoModel.systemId;
        NSString *accessKey=skMoModel.accessKey;
        
        //MD5(clientId+systemId+accessKey)，其中accessKey从配置信息中获取
        NSString *signature=[NSString stringWithFormat:@"%@%@%@",clientId,systemId,accessKey];
        //clientId=398123&systemId=459873&signature=xseklsdioewoilksdlfsjoio
        
        signature=[skParameDealMethod MD5:signature];
        
        NSString *paramstr=[NSString stringWithFormat:@"clientId=%@&systemId=%@&signature=%@&",clientId,systemId,signature];
        
        [skAFNet SKPOST:urlstr parameters:paramstr showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
            
            applyTokenModel *model=[applyTokenModel mj_objectWithKeyValues:responseObject.data];
            [[NSUserDefaults standardUserDefaults] setObject:model.token forKey:@"applyToken"];
            NSLog(@"获取applyToken申请=%@",model.token);
            model.tokenTime=[self getCurrentTimestamp];
            success(responseObject);
        } failure:^(NSError * _Nullable error) {
            failure(error);
        }];
    }else{
        [self reApplyToken:^(skResponeModel *model) {
            success(model);
        } failure:^(NSError * _Nullable error) {
            failure(error);
        }];
    }
    
    
    
}
//更新令牌
+(void)reApplyToken:(void (^)(skResponeModel *model))success
            failure:(Failure)failure{
    [skParameDealMethod skInitMudlesWithInterfaceForskApplyToken:@"/intf/access/reApplyToken"];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",skMoModel.entranceUrl,skMoModel.intfName];
    
    NSString *clientId=skMoModel.clientId;
    NSString *systemId=skMoModel.systemId;
    NSString *accessKey=skMoModel.accessKey;
    NSString *accessToken=skAccessToken;
    
    //MD5(clientId+systemId+accessKey)，其中accessKey从配置信息中获取
    NSString *signature=[NSString stringWithFormat:@"%@%@%@%@",clientId,systemId,accessToken,accessKey];
    //clientId=398123&systemId=459873&signature=xseklsdioewoilksdlfsjoio
    
    signature=[skParameDealMethod MD5:signature];
    
    NSString *paramstr=[NSString stringWithFormat:@"clientId=%@&systemId=%@&accessToken=%@&signature=%@&",clientId,systemId,accessToken,signature];
//    NSLog(@"更新token的参数%@",paramstr);
    
    [skAFNet SKPOST:urlstr parameters:paramstr showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        applyTokenModel *model=[applyTokenModel mj_objectWithKeyValues:responseObject.data];
        NSLog(@"获取applyToken更新=%@",model.token);
        [[NSUserDefaults standardUserDefaults] setObject:model.token forKey:@"applyToken"];
        model.tokenTime=[self getCurrentTimestamp];
        success(responseObject);
    } failure:^(NSError * _Nullable error) {
        failure(error);
    }];
}
/**
 获取本地时间戳

 @return 时间戳字符串
 */
+(NSTimeInterval)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    return a;
}

@end
