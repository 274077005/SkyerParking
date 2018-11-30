//
//  mothCardTableViewCell.m
//  SkyerParking
//
//  Created by skyer on 2018/11/12.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "mothCardTableViewCell.h"



@implementation mothCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.labMonthCard.textColor=skUIColorFromRGB(0x6FC1F5);
    self.labQuarterCard.textColor=skUIColorFromRGB(0xFF9900);
    self.labYearCard.textColor=skUIColorFromRGB(0xFF7979);
    [self.labMonthCard skSetBoardRadius:3 Width:1 andBorderColor:skUIColorFromRGB(0x6FC1F5)];
    [self.labQuarterCard skSetBoardRadius:3 Width:1 andBorderColor:skUIColorFromRGB(0xFF9900)];
    [self.labYearCard skSetBoardRadius:3 Width:1 andBorderColor:skUIColorFromRGB(0xFF7979)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
