//
//  AFNetworkRequest.h
//  SkyerParking
//
//  Created by admin on 2018/7/7.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "skResponeModel.h"

//请求方式：post、get、put、patch、delete
typedef NS_ENUM(NSUInteger, RequestMethod) {
    RequestMethod_POST = 0,
    RequestMethod_GET,
    RequestMethod_PUT,
    RequestMethod_PATCH,
    RequestMethod_DELETE
};

@interface skAFNetworkRequest : NSObject

/**
 *  AFNetworking请求方法
 *
 *  @param method     请求方式 Request_POST / Request_GET / Request_PUT / Request_PATCH / Request_DELETE
 *  @param parameters 请求参数 --支持NSArray, NSDictionary, NSSet这三种数据结构
 *  @param url        请求url字符串
 *  @param success    请求成功回调block
 */
+ (void)skAFNetworkRequestWithRequestMethod:(RequestMethod)method
                               parameters:(id)parameters
                                      url:(NSString *)url
                                  isShowHUD:(BOOL)showHUD
                                  isShowErr:(BOOL)showErr
                                  success:(void (^)(skResponeModel *model))success
                                  failure:(void (^)(NSError *error))failure;
@end
