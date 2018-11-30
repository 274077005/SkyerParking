//
//  TCBIChargeView.m
//  SkyerParking
//
//  Created by admin on 2018/7/23.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "TCBIChargeView.h"
#import "UIView+Shadow.h"

@implementation TCBIChargeView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.btnSure setBackgroundColor:skColorAppMain];
    [self.btnSure skSetShadowWithColor:skColorAppMain andSizeMake:CGSizeMake(0, 0) Radius:5];
}


@end
