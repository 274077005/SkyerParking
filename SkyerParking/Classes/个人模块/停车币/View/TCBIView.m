//
//  TCBIView.m
//  SkyerParking
//
//  Created by admin on 2018/7/19.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "TCBIView.h"
#import "UIView+Shadow.h"
@implementation TCBIView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.viewContance skSetShadowWithColor:skColorAppMain andSizeMake:CGSizeMake(0, 0) Radius:5];
    [self.viewColor setBackgroundColor:skColorAppMain];
}


@end
