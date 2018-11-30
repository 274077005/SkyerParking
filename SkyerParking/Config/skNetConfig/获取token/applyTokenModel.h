//
//  applyTokenModel.h
//  SkyerParking
//
//  Created by admin on 2018/7/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface applyTokenModel : NSObject
SkyerSingletonH(applyTokenModel)
@property (nonatomic,strong) NSString *expire_in;
@property (nonatomic,strong) NSString *token;//创建签名的时候使用
@property (nonatomic,assign) NSTimeInterval tokenTime;
@end
