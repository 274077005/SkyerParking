//
//  monthCartMangerModel.h
//  SkyerParking
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface monthCartMangerModel : NSObject
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , assign) NSInteger              memberId;
@property (nonatomic , copy) NSString              * parkingId;
@property (nonatomic , copy) NSString              * parkingName;
@property (nonatomic , copy) NSString              * cardNum;
@property (nonatomic , copy) NSString              * plateNo;
@property (nonatomic , assign) NSInteger              carsType;
@property (nonatomic , assign) NSInteger              cardType;
@property (nonatomic , assign) NSInteger              validStartTime;
@property (nonatomic , assign) NSInteger              validEndTime;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * validStartDate;
@property (nonatomic , copy) NSString              * validEndDate;
@end

NS_ASSUME_NONNULL_END
