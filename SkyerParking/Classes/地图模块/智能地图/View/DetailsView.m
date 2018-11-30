//
//  DetailsView.m
//  SkyerParking
//
//  Created by admin on 2018/7/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "DetailsView.h"

@implementation DetailsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)updateData:(nearParkModel*)model{
    self.labParkName.text=model.parking_name;
    self.labDistance.text=[NSString stringWithFormat:@"距离: %@ KM",model.distance];
    self.labAddress.text=model.address;
    self.labCharge.text=@"后台无此字段";
    self.labNumber.text=@"0";
}

@end
