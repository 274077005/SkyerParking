//
//  UserInfoTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/7/14.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnHeader;

@property (weak, nonatomic) IBOutlet UILabel *labName;//用户名

@property (weak, nonatomic) IBOutlet UIImageView *imageVip;
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnEdior;


@property (weak, nonatomic) IBOutlet UILabel *labTCBI;//停车币数
@property (weak, nonatomic) IBOutlet UILabel *labBalance;//余额数
@property (weak, nonatomic) IBOutlet UILabel *labScore;//积分数

@property (weak, nonatomic) IBOutlet UIButton *btnHeaderDec;//头像描述

@property (weak, nonatomic) IBOutlet UIButton *btnGoTCBI;//停车币
@property (weak, nonatomic) IBOutlet UIButton *btnGoBalance;//余额
@property (weak, nonatomic) IBOutlet UIButton *btnGoScore;//积分


@end
