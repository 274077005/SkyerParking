//
//  skSurePayViewController.h
//  SkyerParking
//
//  Created by admin on 2018/7/24.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"
typedef NS_ENUM(NSInteger, rechargeType)
{
    rechargeTypeTCBI = 0,//充值停车币
    rechargeTypeBalance,//充值余额
};
typedef NS_ENUM(NSInteger, PayFor)
{
    PayForWX = 0,//微信支
    PayForZFB,//支付宝支付
};
@interface skSurePayViewController : skBaseViewController
@property (nonatomic,assign) rechargeType typePayFor;//是停车币还是余额
@property (nonatomic,strong) NSDictionary *dicPay;
@end
