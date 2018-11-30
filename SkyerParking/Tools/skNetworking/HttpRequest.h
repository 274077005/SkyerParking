//
//  Request.h
//  JozneNews
//
//  Created by Jozne'Mac on 16/6/28.
//  Copyright © 2016年 CJX. All rights reserved.
//

#import "AFNetworking.h"

@interface UploadParam : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *mimeType;

@end

@class UploadParam;

@interface HttpRequest : NSObject

+ (void)postWithUrl:(NSString *)url Parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
