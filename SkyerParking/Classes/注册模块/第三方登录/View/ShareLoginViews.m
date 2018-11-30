//
//  ShareLoginViews.m
//  SkyerParking
//
//  Created by admin on 2018/9/6.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ShareLoginViews.h"

@implementation ShareLoginViews

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.labCode skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
    [self.btnChange skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
}

@end
