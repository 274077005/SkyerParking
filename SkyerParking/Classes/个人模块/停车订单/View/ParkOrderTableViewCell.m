//
//  ParkOrderTableViewCell.m
//  SkyerParking
//
//  Created by admin on 2018/7/23.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ParkOrderTableViewCell.h"

@implementation ParkOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor=skLineColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
