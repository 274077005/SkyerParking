//
//  skGetNetConfig.m
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skGetNetConfig.h"
#import "skApplyToken.h"
#import "skApplyClientMethods.h"

@implementation skGetNetConfig

+(void)skAppStartApply:(void (^)(skResponeModel *model))success
               failure:(Failure)failure{
    
    [skApplyClientMethods skApplyClient:^(skResponeModel *model) {
        //MJ设置模型的时候需要点时间,所以给.3秒缓冲数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [skApplyToken applyToken:^(skResponeModel *model) {
                success(model);
            } failure:^(NSError * _Nullable error) {
                failure(error);
            }];
        });
    } failure:^(NSError * _Nullable error) {
        
        failure(error);
        
    }];
    
}
+(void)skAPPLoginUpdateToken{
    [skApplyToken reApplyToken:^(skResponeModel *model) {
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
//获取URL的方法
+(NSString *)skGetURL{
    //"http://test.tingchedao.cn/basic";
    //http(s)://HOST:PORT/ndpweb/app/parking/BizLicPlate/create
    
    NSString *URL=skMoModel.entranceUrl;
    NSArray *arrUrl=[URL componentsSeparatedByString:@"/"];
    
    NSMutableString *resultURL=[[NSMutableString alloc] init];
    
    for (int i =0; i<arrUrl.count-1; ++i) {
        [resultURL appendString:[NSString stringWithFormat:@"%@/",arrUrl[i]]];
    }
    [resultURL appendString:@"ndpweb"];
    return resultURL;
    
}
@end
