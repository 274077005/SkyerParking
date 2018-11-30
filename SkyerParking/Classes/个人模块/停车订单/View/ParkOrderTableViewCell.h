//
//  ParkOrderTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/7/23.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkOrderTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *labPateNo;
@property (weak, nonatomic) IBOutlet UILabel *labState;
@property (weak, nonatomic) IBOutlet UILabel *labPateAddress;

@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labCharge;
@property (weak, nonatomic) IBOutlet UILabel *labPayNumber;

@end
