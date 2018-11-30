//
//  skOrderPaymentView.m
//  SkyerParking
//
//  Created by admin on 2018/7/23.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skOrderPaymentViews.h"
#import "UIView+Shadow.h"

@implementation skOrderPaymentViews


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.btnOut skSetBoardRadius:5 Width:0 andBorderColor:nil];
    [self.btnOut setBackgroundColor:skColorAppMain];
}


@end
