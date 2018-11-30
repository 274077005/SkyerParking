//
//  ChargeTypeViewController.h
//  SkyerParking
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"

@interface ChargeTypeViewController : skBaseViewController
@property (nonatomic,strong) void(^chargeType)(NSInteger index);
@end
