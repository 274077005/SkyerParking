//
//  Request.m
//  JozneNews
//
//  Created by Jozne'Mac on 16/6/28.
//  Copyright © 2016年 CJX. All rights reserved.
//

#import "HttpRequest.h"

@implementation UploadParam

@end

@implementation HttpRequest

static id _instance = nil;

+ (instancetype)sharedInstance
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown: ; break;
                case AFNetworkReachabilityStatusNotReachable: ; break;
                case AFNetworkReachabilityStatusReachableViaWiFi: ; break;
                case AFNetworkReachabilityStatusReachableViaWWAN: ; break;
            }
        }];
    });
    return _instance;
}

+ (void)postWithUrl:(NSString *)url Parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    NSLog(@"%@\n%@", url, parameters);
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //此处做一个识别，区别在于apply跟reapply token直接传dic类型，其他接口传str类型
    
    NSMutableURLRequest *request;
    
    if ([parameters isKindOfClass:[NSMutableDictionary class]])
    {
        request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parameters error:nil];
    }
    else if ([parameters isKindOfClass:[NSMutableString class]])
    {
        request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
        
        [request setHTTPBody:[parameters dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    }
    
    request.timeoutInterval = 30;
    
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    [request setValue:@"gzip, deflate, br" forHTTPHeaderField:@"Accept-Encoding"];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    
    manager.operationQueue.maxConcurrentOperationCount = 1;

    manager.responseSerializer = responseSerializer;
    
    [manager setSecurityPolicy:[self customSecurityPolicy]];
    
//    [HttpRequest getP12Secret:manager];
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (success)
        {

            id object  = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            success(object);
        }
        else
        {
            failure(error);
        }
    }] resume];
}

+ (AFSecurityPolicy *)customSecurityPolicy
{
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"nntyjSports" ofType:@"cer"];

    NSData *certData = [NSData dataWithContentsOfFile:cerPath];

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

    securityPolicy.allowInvalidCertificates = YES;

    securityPolicy.validatesDomainName = NO;

    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];

    securityPolicy.pinnedCertificates = set;

    return securityPolicy;
}

+ (void)getP12Secret:(AFURLSessionManager *)manager
{
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) { }];
    
    __weak typeof(manager)weakManager = manager;
    
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential)
     {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        
         __autoreleasing NSURLCredential *credential = nil;
        
         if(![challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
         {
            if([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host])
            {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];

                if(credential)
                {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }
                else
                {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            }
            else
            {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
         }
         else
         {
             SecIdentityRef identity = NULL;
 
             SecTrustRef trust = NULL;
             
             NSString *p12 = [[NSBundle mainBundle] pathForResource:@"nntyjSports"ofType:@"pfx"];
             
             NSFileManager *fileManager =[NSFileManager defaultManager];
            
             if(![fileManager fileExistsAtPath:p12])
             {
                 NSLog(@"client.p12:not exist");
             }
             else
             {
                 NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                 
                 if ([HttpRequest extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                 {
                     SecCertificateRef certificate = NULL;
                     
                     SecIdentityCopyCertificate(identity, &certificate);
                    
                     const void*certs[] = {certificate};
                    
                     CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    
                     credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    
                     disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
       
         return disposition;
    }];
}

+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data
{
    OSStatus securityError = errSecSuccess;
    
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"nntyj*2017" forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0)
    {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        
        const void*tempIdentity =NULL;
        
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        
        *outIdentity = (SecIdentityRef)tempIdentity;
        
        const void*tempTrust =NULL;
        
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        
        *outTrust = (SecTrustRef)tempTrust;
    }
    else
    {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}

@end
