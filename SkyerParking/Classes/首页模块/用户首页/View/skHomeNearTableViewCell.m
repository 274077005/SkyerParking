//
//  skHomeNearTableViewCell.m
//  SkyerParking
//
//  Created by admin on 2018/8/15.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skHomeNearTableViewCell.h"

@implementation skHomeNearTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.btnGoNav skSetBoardRadius:5 Width:0 andBorderColor:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateData:(nearParkModel*)model{
    
    self.labParkName.text=model.parking_name;
    self.labAddress.text=[NSString stringWithFormat:@"%@ 距离: %@ KM",model.address,model.distance];
    self.labCharge.text=@"后台没有返回收费规则字段";
    self.labCount.text=model.stall_count>0?[NSString stringWithFormat:@"%ld",model.stall_count]:@"0";
    
}
@end
