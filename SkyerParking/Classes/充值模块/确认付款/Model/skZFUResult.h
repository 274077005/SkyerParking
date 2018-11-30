//
//  skZFUResult.h
//  SkyerParking
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skZFUResult : NSObject
SkyerSingletonH(skZFUResult)
-(void)skResult:(NSURL *)url;
-(void)paySuccess;
-(void)payFaile;
@end
