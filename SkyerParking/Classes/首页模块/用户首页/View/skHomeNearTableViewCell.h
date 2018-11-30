//
//  skHomeNearTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/8/15.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "nearParkModel.h"

@interface skHomeNearTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnGoNav;
@property (weak, nonatomic) IBOutlet UILabel *labCount;
@property (weak, nonatomic) IBOutlet UILabel *labParkName;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labCharge;

-(void)updateData:(nearParkModel*)model;

@end
