//
//  SKNetworking.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKPicModle.h"
#import "SkyerTools.h"
#import "AFNetworking.h"
#import "skResponeModel.h"


NS_ASSUME_NONNULL_BEGIN

@class SKPicModle;

typedef void (^ _Nullable Success)(skResponeModel *responseObject);     // 成功Block
typedef void (^ _Nullable Failure)(NSError * _Nullable error);        // 失败Blcok
typedef void (^ _Nullable Progress)(NSProgress * _Nullable progress); // 上传或者下载进度Block
typedef NSURL * _Nullable (^ _Nullable Destination)(NSURL * _Nullable targetPath, NSURLResponse * _Nullable response); //返回URL的Block
typedef void (^ _Nullable DownLoadSuccess)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath); // 下载成功的Blcok

typedef void (^ _Nullable Unknown)(void);          // 未知网络状态的Block
typedef void (^ _Nullable Reachable)(void);        // 无网络的Blcok
typedef void (^ _Nullable ReachableViaWWAN)(void); // 蜂窝数据网的Block
typedef void (^ _Nullable ReachableViaWiFi)(void); // WiFi网络的Block
typedef void (^ _Nullable getList)(NSArray *arrList);//获取列表list
typedef void (^ _Nullable getRespData)(id RespData);

@interface SKNetworking : NSObject

SkyerSingletonH(SKNetworking)

/**
 *  上传图片大小(kb)
 */
@property (nonatomic, assign) NSUInteger picSize;

/**
 *  超时时间(默认20秒)
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  可接受的响应内容类型
 */
@property (nonatomic, copy) NSSet <NSString *> * _Nonnull acceptableContentTypes;


/**
 *  网络监测(在什么网络状态)
 *
 *  @param unknown          未知网络
 *  @param reachable        无网络
 *  @param reachableViaWWAN 蜂窝数据网
 *  @param reachableViaWiFi WiFi网络
 */
- (void)SKNetworkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi;
/**
 *  封装的POST请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
//- (void)SKPOST:(NSString *_Nullable)URLString parameters:(NSDictionary *_Nullable)parameters success:(Success)success failure:(Failure)failure;(这个是原始的方式,没有其他操作,下面的是带了错误码提示和菊花提提示的)
/**
 *  封装的POST请求.返回无异常信息的
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param isShow     是否有等待提示菊花
 *  @param showErr    是否显示错误信息
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)SKPOST:(NSString *_Nullable)URLString parameters:(id)parameters showHUD:(Boolean)isShow showErrMsg:(BOOL) showErr success:(Success)success failure:(Failure)failure;

///**
// *  封装的POST请求.返回全部信息的
// *
// *  @param URLString  请求的链接
// *  @param parameters 请求的参数
// *  @param isShow     是否有等待提示菊花
// *  @param showErr    是否显示错误信息
// *  @param success    请求成功回调
// *  @param failure    请求失败回调
// */
//- (void)SKPOSTReturnError:(NSString *_Nullable)URLString parameters:(id)parameters showHUD:(Boolean)isShow showErrMsg:(BOOL) showErr success:(Success)success failure:(Failure)failure;
/**
 *  封装的get请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)SKGET:(NSString *_Nullable)URLString parameters:(id)parameters success:(Success)success failure:(Failure)failure;
/**
 *  封装POST图片上传(单张图片) // 可扩展成单个别的数据上传如:mp3等
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param picModle   上传的图片模型
 *  @param progress   进度的回调
 *  @param success    发送成功的回调
 *  @param failure    发送失败的回调
 */
- (void)SKPOST:(NSString *_Nonnull)URLString parameters:(id)parameters andPic:(SKPicModle *_Nonnull)picModle progress:(Progress)progress success:(Success)success failure:(Failure)failure;
/**
 *  封装POST图片上传(多张图片) // 可扩展成多个别的数据上传如:mp3等
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param picArray   存放图片模型(SKPicModle)的数组
 *  @param progress   进度的回调
 *  @param success    发送成功的回调
 *  @param failure    发送失败的回调
 */
- (void)POST:(NSString *_Nonnull)URLString parameters:(id)parameters andPicArray:(NSArray *_Nonnull)picArray progress:(Progress)progress success:(Success)success failure:(Failure)failure;
/**
 *  下载
 *
 *  @param URLString       请求的链接
 *  @param progress        进度的回调
 *  @param destination     返回URL的回调
 *  @param downLoadSuccess 发送成功的回调
 *  @param failure         发送失败的回调
 */
- (NSURLSessionDownloadTask *_Nonnull)downLoadWithURL:(NSString *)URLString progress:(Progress)progress destination:(Destination)destination downLoadSuccess:(DownLoadSuccess)downLoadSuccess failure:(Failure)failure;
/**
 *  封装POST上传url资源
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param picModle   上传的图片模型(资源的url地址)
 *  @param progress   进度的回调
 *  @param success    发送成功的回调
 *  @param failure    发送失败的回调
 */
- (void)POST:(NSString *_Nonnull)URLString parameters:(NSString *)parameters andPicUrl:(SKPicModle *_Nonnull)picModle progress:(Progress)progress success:(Success)success failure:(Failure)failure;
@end
NS_ASSUME_NONNULL_END

