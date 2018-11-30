//
//  skNearAnnotionView.m
//  TingCheDao
//
//  Created by admin on 2018/6/2.
//  Copyright © 2018年 DLC. All rights reserved.
//

#import "skNearAnnotionView.h"

@implementation skNearAnnotionView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, 20, 20);
        
    }
    
    return self;
}@end
