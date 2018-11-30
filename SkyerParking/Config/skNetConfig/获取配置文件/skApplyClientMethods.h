//
//  skInitBasicModel.h
//  SkyerParking
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "skApplyClientModel.h"

@interface skApplyClientMethods : NSObject


/**
 服务器申请配置文件
 */
+(void)skApplyClient:(void (^)(skResponeModel *model))success
             failure:(Failure)failure;



@end
