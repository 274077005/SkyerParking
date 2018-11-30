//
//  BalanceListModel.h
//  SkyerParking
//
//  Created by admin on 2018/7/24.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceListModel : NSObject
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) BOOL isDel;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSString * rechargeOptionId;
@property (nonatomic, assign) NSInteger roId;
@property (nonatomic, strong) NSString * roptionName;
@property (nonatomic, assign) NSInteger sendNumber;
@property (nonatomic, assign) NSInteger type;


@end
