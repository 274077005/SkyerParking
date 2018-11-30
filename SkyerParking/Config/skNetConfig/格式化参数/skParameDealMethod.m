//
//  skParameDealMethod.m
//  SkyerParking
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skParameDealMethod.h"
#import "applyTokenModel.h"
#import "skApplyToken.h"
#import "SkDataOperation.h"
#import "skUUID.h"


@implementation skParameDealMethod



+(void) skInitMudlesWithInterface:(NSString *)intfName{
    [self skInitMudlesWithInterfaceForskApplyToken:intfName];
}


+(void) skInitMudlesWithInterfaceForskApplyToken:(NSString *)intfName{
    //通过接口获取子系统
    NSArray *arrModules=[intfName componentsSeparatedByString:@"/"];
    if (arrModules.count>=2) {
        //第二个就是子系统
        NSString *module=[arrModules objectAtIndex:2];
        module=[NSString stringWithFormat:@"/%@/",module];
        //获取服务器配置
        NSDictionary *dicModules=[skApplyClientModel sharedskApplyClientModel].modules;
        //通过服务器的数据匹配
        NSString *subSystems=[dicModules objectForKey:module];
        if (subSystems==nil) {
            subSystems=@"basic";
        }
        //获取服务的子系统数据
        NSDictionary *dicSubSystems=[skApplyClientModel sharedskApplyClientModel].subSystems;
        
        //获取子系统词典
        NSDictionary *dicSubSystem=[dicSubSystems objectForKey:subSystems];
        NSLog(@"子模块命==%@",dicSubSystem);
        
        //请求成功就保存配置文件
        if (dicSubSystem) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [SkDataOperation SkSaveData:dicSubSystem withSaveFileName:@"ApplyClient" succeedBlock:^{
                    NSLog(@"保存数据成功");
                }];
            });
        }else{
            dicSubSystem=[SkDataOperation SkReadDictionaryWithFileName:@"ApplyClient"];
        }
        skModulesModel *model=[skModulesModel mj_objectWithKeyValues:dicSubSystem];
        model.intfName=intfName;
    }
}

+(NSString *)skRequestParameterseFormatting:(NSDictionary *)parame{
    
    //防止服务器无返回闪退
    if (skMoModel.clientId==nil) {
        return @"";
    }
    //公共参数
    NSDictionary*publicParams;
    if (skUser.phone.length>0) {//已经等了的公共参数
        publicParams=@{@"clientId":skMoModel.clientId,
                       @"systemId":skMoModel.systemId,
                       @"intfName":skMoModel.intfName,
                       @"userId":skUser.memberId,
                       @"userName":skUser.memberName,
                       @"userToken":skUser.token,
                       @"userType":@"5",//5是app
                       @"equipUUID":[skUUID skGetDeviceUUID],
                       @"version":skAppVersion,
                       @"IMEI":[skUUID skGetDeviceIMEI],
                       @"clientType":@1
                       };
        NSLog(@"公共参数=%@",publicParams);
    }else{
        publicParams=@{@"clientId":skMoModel.clientId,
                       @"systemId":skMoModel.systemId,
                       @"intfName":skMoModel.intfName
                       };
    }
    
    
    //业务参数
    NSDictionary *busiPrams=parame;
    
    NSString *sss = [NSString stringWithFormat:@"publicParams=%@&busiParams=%@&signature=%@", publicParams, busiPrams, @"没转码的参数"];
    
    NSLog(@"公共参数==%@",sss);
    
    NSMutableString *publicParamsJsonString = [skParameDealMethod paramsToJsonString:publicParams];
    
    NSMutableString *busiParamsJsonString = [skParameDealMethod paramsToJsonString:busiPrams];
    
    //拼接publicParamsJsonString+busiParamsJsonString+securityKey+accessToken并MD5
    NSString *signature = [skParameDealMethod makeSignature:publicParamsJsonString andbusiParamsJsonString:busiParamsJsonString];
    
    //json string转码
    NSString *publicParamsString = [publicParamsJsonString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *busiParamsString = [busiParamsJsonString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //拼接最终字符串
    NSString *postString = [NSString stringWithFormat:@"publicParams=%@&busiParams=%@&signature=%@", publicParamsString, busiParamsString, signature];
    
    return postString;
}

/**
 词典转字符串
 
 @param dic 转换的词典
 @return 返回的字符串
 */
+ (NSMutableString *)paramsToJsonString:(NSDictionary *)dic
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableString *responseString = [NSMutableString stringWithString:jsonString];

    NSString *character = nil;
    
    for (int i = 0; i < responseString.length; i ++)
    {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        
        if ([character isEqualToString:@"\\"])
        {
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
    }
    
    return responseString;
}


/**
 创建签名
 */
+(NSString *)makeSignature:(NSString *)publicParamsJsonString andbusiParamsJsonString:(NSString *)busiParamsJsonString{
    
    NSString*signature=[NSString stringWithFormat:@"%@%@%@%@",publicParamsJsonString,busiParamsJsonString,skMoModel.securityKey,skAccessToken];
    
    signature=[skParameDealMethod MD5:signature];
    
    return signature;
}

/**
 md5加密
 
 @param input 加密的字符串
 @return 返回的加密字符串
 */
+ (NSString *) MD5:(NSString *) input {
    
    const char *original_str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
}


@end
