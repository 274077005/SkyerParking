//
//  skBaseUIButton.m
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skBaseUIButton.h"

@implementation skBaseUIButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.exclusiveTouch = YES;
    }
    return self;
}

@end
