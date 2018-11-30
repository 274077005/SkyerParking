//
//  prakingSearchTableViewCell.m
//  SkyerParking
//
//  Created by admin on 2018/8/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "prakingSearchTableViewCell.h"

@implementation prakingSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateData:(nearParkModel*)model{
    
    self.labParkName.text=model.parking_name;
}
@end
