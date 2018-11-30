//
//  skApplyClientModel.h
//  SkyerParking
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skApplyClientModel : NSObject

SkyerSingletonH(skApplyClientModel)

@property (nonatomic,strong) NSDictionary *subSystems;//系统配置
@property (nonatomic,strong) NSDictionary *modules;//子模块

@end
