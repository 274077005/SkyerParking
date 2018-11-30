//
//  skConfig.h
//  SkyerParking
//
//  Created by admin on 2018/7/5.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>


//#define applyClientURL @"http://192.168.1.228/basic/intf/access/applyClient"

//腾讯云
//#define applyClientURL @"http://test.tingchedao.cn/basic/intf/access/applyClient"

//老廖
//#define applyClientURL @"http://192.168.1.188:8080/ndparking-midware/intf/access/applyClient"

//阿里云
#define applyClientURL @"http://www.tingchedao.cn/basic/intf/access/applyClient"

//#define applyClientURL @"http://www.tingchedao.cn:7002/intf/access/applyClient"

//高德地图的Key
#define kMapAPIKey @"052d93b81bfea4fa5821b8131d472264"
//百度地图的Key
#define kBMKMapAPIKey @"gkfZWDyhhA6sAdYHB16pu6yC5WMXvbrV"
//极光推送
#define kjpushKey @"20507154b1b76ac35dcffa1d"
//讯飞语音
#define APPID_VALUE @"5b077599"
//微信appid
#define WXRegisterID @"wxc0e1c2f16036a97b"
//客户端类型
#define skClientType  [NSNumber numberWithUnsignedInteger:1]
//配置参数模型
#define skMoModel [skModulesModel sharedskModulesModel]
//网络请求
#define skAFNet   [SKNetworking sharedSKNetworking]
//用户登录成返回的用户信息
#define skUser [UserLoginModel sharedUserLoginModel]
//请求的url
#define skUrl [NSString stringWithFormat:@"%@%@",skMoModel.entranceUrl,skMoModel.intfName]
//文件上传的url
#define skUplondUrl [skGetNetConfig skGetURL]

#define skParam(param) [skParameDealMethod skRequestParameterseFormatting:param]
//获取的token
#define skAccessToken [[NSUserDefaults standardUserDefaults] objectForKey:@"applyToken"]
//xib获取
#define skXibView(xibName) [[[NSBundle mainBundle]loadNibNamed:xibName owner:nil options:nil] firstObject];

#define skToast(message)  [SkToast SkToastShow:message withHight:300];

#define skBundleID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
//#define skLineColor skUIColorFromRGB(0xF0F1F1)

#define skLoginUserName @"LoginUserName"
#define skLoginUserPWD @"LoginUserPWD"
#define skAPPVersionSave @"skAPPVersionSave"
#define skAutoLogin @"skAutoLogin"
/**
 
 * 通知名称
 */
//未知网络状态通知
#define DLCNetworkReachabilityStatusUnknown      @"DLCNetworkReachabilityStatusUnknown"
//网络不可用通知
#define DLCNetworkReachabilityStatusNotReachable @"DLCNetworkReachabilityStatusNotReachable"
//网络可用通知
#define DLCNetworkReachabilityStatusReachable    @"DLCNetworkReachabilityStatusReachable"


@interface skConfig : NSObject

@end
