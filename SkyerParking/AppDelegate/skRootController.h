//
//  skRootController.h
//  SkyerParking
//
//  Created by admin on 2018/8/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface skRootController : NSObject
/**
 启动APP出现的界面
 */
+(void)skFirstViewController;

/**
 用户登录界面
 */
+(void)skLoginViewController;

/**
 引导页
 */
+(void)skGuidanceViewController;

/**
 首页
 */
+(void)skTabbarViewController;

/**
 启动APP根据情况选择页面
 */
+(void)skStarAppViewController;

/**
 用户退出登录
 */
+(void)skUserLoginOutViewController;
@end
