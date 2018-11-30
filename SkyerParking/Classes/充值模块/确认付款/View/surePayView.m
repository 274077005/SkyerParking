//
//  surePayView.m
//  SkyerParking
//
//  Created by admin on 2018/7/24.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "surePayView.h"
#import "UIView+Shadow.h"


@implementation surePayView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [_btnSure setBackgroundColor:skColorAppMain];
    [_btnSure skSetShadowWithColor:skColorAppMain andSizeMake:CGSizeMake(0, 0) Radius:5];
}

-(void)skSetData:(surePayModel*)data{
    [self.btnCount setText:[NSString stringWithFormat:@"%@元",data.number]];
}
@end
