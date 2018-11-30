//
//  PlateManageTableViewCell.m
//  SkyerParking
//
//  Created by admin on 2018/7/21.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "PlateManageTableViewCell.h"

@implementation PlateManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor=skLineColor;
    [self.viewContain skSetBoardRadius:5 Width:0 andBorderColor:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
