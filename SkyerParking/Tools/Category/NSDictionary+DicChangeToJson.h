//
//  NSDictionary+DicChangeToJson.h
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DicChangeToJson)

/**
 词典转json

 @param dict 词典
 @return json
 */
-(NSString *)skDicToJsonData:(NSDictionary *)dict;
/**
 *  JSON字符串转NSDictionary
 *
 *  @param jsonString JSON字符串
 *
 *  @return NSDictionary
 */
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
