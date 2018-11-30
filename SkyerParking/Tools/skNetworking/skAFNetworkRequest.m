//
//  AFNetworkRequest.m
//  SkyerParking
//
//  Created by admin on 2018/7/7.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//
#import "AFNetworking.h"
#import "skAFNetworkRequest.h"

@interface skAFNetworkRequest ()

//错误状态码 iOS-sdk里面的 NSURLError.h 文件
typedef NS_ENUM (NSInteger, AFNetworkErrorType) {
    
    AFNetworkErrorType_TimedOut   = NSURLErrorTimedOut,//-1001 请求超时
    AFNetworkErrorType_UnURL      = NSURLErrorUnsupportedURL,//-1002 不支持的url
    AFNetworkErrorType_NoNetwork  = NSURLErrorNotConnectedToInternet,//-1009 断网
    AFNetworkErrorType_404Failed  = NSURLErrorBadServerResponse,//-1011 404错误
    AFNetworkErrorType_3840Failed = 3840,//请求或返回不是纯Json格式
    
};

@end

@implementation skAFNetworkRequest

/**
 *  请求失败回调方法
 *
 *  @param error 错误对象
 */
+ (void)requestFailed:(NSError *)error{
    
    //    //停止动画效果
    //    [[LoadingView shareInstance]stopAnimating];
    
    NSLog(@"--------------\n%zd %@",error.code, error.debugDescription);
    switch (error.code) {
        case AFNetworkErrorType_NoNetwork :
            NSLog(@"网络链接失败，请检查网络。");
            break;
        case AFNetworkErrorType_TimedOut :
            NSLog(@"访问服务器超时，请检查网络。");
            break;
        case AFNetworkErrorType_3840Failed :
            NSLog(@"服务器报错了，请稍后再访问。");
            break;
        default:
            NSLog(@"网络链接失败");
            break;
    }
    
}



/**
 *  AFNetworking请求方法
 *
 *  @param method     请求方式 Request_POST / Request_GET / Request_PUT / Request_PATCH / Request_DELETE
 *  @param parameters 请求参数
 *  @param url        请求url字符串
 *  @param success    请求成功回调block
 */
+ (void)skAFNetworkRequestWithRequestMethod:(RequestMethod)method
                                 parameters:(id)parameters
                                        url:(NSString *)url
                                  isShowHUD:(BOOL)showHUD
                                  isShowErr:(BOOL)showErr
                                    success:(void (^)(skResponeModel *model))success
                                    failure:(void (^)(NSError *error))failure{
    
    NSLog(@"接口==>%@\n 参数==>%@",url,parameters);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.0f;//超时时间
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if (showHUD) {
        [SkHUD skyerShowProgOnWindow:@"请求中"];
    }
    
    switch (method) {
            //POST 方法
        case RequestMethod_POST:{
            
            [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                NSLog(@"uploadProgress __ %@ __ ",uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //请求成功的操作
                [self responseSuccess:responseObject showHUD:showHUD success:success];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //失败的处理
                [self responseError:error failure:failure];
                
            }];
        }   break;
            //GET 方法
        case RequestMethod_GET:{
            [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [self responseSuccess:responseObject showHUD:showHUD success:success];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //失败的处理
                [self responseError:error failure:failure];
                
            }];
        }   break;
            //PUT 方法
        case RequestMethod_PUT:{
            [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //请求成功的操作
                [self responseSuccess:responseObject showHUD:showHUD success:success];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //失败的处理
                [self responseError:error failure:failure];
                
            }];
        }   break;
            //PATCH 方法
        case RequestMethod_PATCH:{
            [manager PATCH:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //请求成功的操作
                [self responseSuccess:responseObject showHUD:showHUD success:success];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //失败的处理
                [self responseError:error failure:failure];
                
            }];
        }   break;
            //DELETE 方法
        case RequestMethod_DELETE:{
            [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //请求成功的操作
                [self responseSuccess:responseObject showHUD:showHUD success:success];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //失败的处理
                [self responseError:error failure:failure];
                
            }];
        }   break;
            
        default:
            break;
    }
}

/**
 请求成功后的数据处理

 @param responseObject 返回的数据
 @param showHUD 是否显示hud
 @param success 成功的回调
 */
+ (void)responseSuccess:(id _Nullable)responseObject showHUD:(BOOL)showHUD success:(void (^)(skResponeModel *))success {
    
    if (success) {
        if (showHUD) {
            [SkHUD skyerRemoveProgress];
        }
        NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:NULL];
        skResponeModel *model=[skResponeModel mj_objectWithKeyValues:dict];
        if (model.returnCode==0) {
            success(model);
        }else{
            [SkToast SkToastShow:model.message];
        }
    }
}

/**
 失败的数据处理

 @param error 错误信息
 @param failure 失败的回调
 */
+ (void)responseError:(NSError * _Nonnull)error failure:(void (^)(NSError *))failure {
    [skAFNetworkRequest requestFailed:error];
    if(failure){
        failure(error);
    }
}
@end
