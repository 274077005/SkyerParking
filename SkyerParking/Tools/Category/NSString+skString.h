//
//  NSString+skString.h
//  SkyerParking
//
//  Created by admin on 2018/9/6.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (skString)
-(NSString *) skMD5:(NSString *) input ;

-(NSString *)cStringFromTimestamp:(NSString *)timestamp;
@end
