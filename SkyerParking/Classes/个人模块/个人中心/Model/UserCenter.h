//
//  UserCenter.h
//  SkyerParking
//
//  Created by admin on 2018/7/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cellData.h"


@interface UserCenter : NSObject

@property (nonatomic,strong) NSMutableArray<cellData *> *arrSection1;
@property (nonatomic,strong) NSMutableArray<cellData *> *arrSection2;
@end
