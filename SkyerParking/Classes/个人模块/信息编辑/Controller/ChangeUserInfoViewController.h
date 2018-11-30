//
//  ChangeUserInfoViewController.h
//  SkyerParking
//
//  Created by admin on 2018/9/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"
#import "userCenterInfoModel.h"

typedef NS_ENUM(NSInteger, userInfoChange)
{
    userInfoChangeNiname = 0,//停车币
    userInfoChangeUsername,//余额
};

@interface ChangeUserInfoViewController : skBaseViewController
@property (nonatomic,assign) userInfoChange typeChange;
@property (nonatomic,strong) userCenterInfoModel *model;
@end
