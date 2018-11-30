//
//  skIflyMSC.m
//  SkyerParking
//
//  Created by admin on 2018/7/6.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skIflyMSC.h"

@implementation skIflyMSC
/**
 讯飞语音集成
 */
-(void)ifUserXunFei{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //Set APPID
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
    [IFlySpeechUtility createUtility:initString];
}
@end
