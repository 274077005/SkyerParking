//
//  TCBIListModel.h
//  SkyerParking
//
//  Created by admin on 2018/7/21.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCBIListModel : NSObject

@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, strong) NSString * editTime;
@property (nonatomic, assign) BOOL isDel;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSString * rechargeOptionId;
@property (nonatomic, assign) NSInteger roId;
@property (nonatomic, strong) NSString * roptionName;
@property (nonatomic, assign) NSInteger sendNumber;
@property (nonatomic, assign) NSInteger type;

@end

