//
//  payDesModel.h
//  SkyerParking
//
//  Created by admin on 2018/8/31.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface payDesModel : NSObject
@property (nonatomic, assign) NSInteger bmcdId;
@property (nonatomic, assign) BOOL consumerType;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, assign) NSInteger dataid;
@property (nonatomic, strong) NSString * dataremarks;
@property (nonatomic, assign) NSInteger datasrc;
@property (nonatomic, assign) NSInteger memberId;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) NSInteger scoretype;
@end
