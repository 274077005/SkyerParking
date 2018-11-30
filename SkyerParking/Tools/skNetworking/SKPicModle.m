//
//  SKPicModle.m
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import "SKPicModle.h"


@implementation SKPicModle

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ : %p> \n{picName : %@ \n pic : %@ \n}", [self class], self,self.picName, self.pic];
}

@end
