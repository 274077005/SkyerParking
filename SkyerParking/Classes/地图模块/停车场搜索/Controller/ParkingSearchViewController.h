//
//  ParkingSearchViewController.h
//  SkyerParking
//
//  Created by admin on 2018/8/8.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"
typedef NS_ENUM(NSInteger, ParkingVoice)
{
    ParkingVoiceUnShow=0,//不显示
    ParkingVoiceShow,//显示
    
};
@interface ParkingSearchViewController : skBaseViewController
@property (nonatomic,assign) ParkingVoice parkingVoice;
@end
