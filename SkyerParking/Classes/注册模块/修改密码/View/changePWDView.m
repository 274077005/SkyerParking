//
//  changePWDView.m
//  SkyerParking
//
//  Created by admin on 2018/7/17.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "changePWDView.h"

@implementation changePWDView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.labCode skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
    [self.btnChange skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
}


@end
