//
//  cardLiseModel.h
//  SkyerParking
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface cardLiseModel : NSObject
@property (nonatomic , assign) NSInteger              price;
@property (nonatomic , assign) NSInteger              cardType;
@property (nonatomic , copy) NSString              * parkingId;
@property (nonatomic , assign) NSInteger              numDays;
@property (nonatomic , copy) NSString              * ids;
@end

NS_ASSUME_NONNULL_END
