//
//  userPayView.m
//  SkyerParking
//
//  Created by admin on 2018/8/2.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "userPayView.h"
#import <SkyerTools/UIView+skBoard.h>

@implementation userPayView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.btnBanding.backgroundColor=skBaseColorWeak;
    [self.btnBanding skSetBoardRadius:5 Width:0 andBorderColor:nil];
}


@end
