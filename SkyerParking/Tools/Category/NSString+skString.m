//
//  NSString+skString.m
//  SkyerParking
//
//  Created by admin on 2018/9/6.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "NSString+skString.h"

@implementation NSString (skString)
-(NSString *) skMD5:(NSString *) input {
    
    const char *original_str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
    
}

// 时间戳—>字符串时间
-(NSString *)cStringFromTimestamp:(NSString *)timestamp {
    //时间戳转时间的方法
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strTime=[dateFormatter stringFromDate:timeData];
    return strTime;
}


@end
