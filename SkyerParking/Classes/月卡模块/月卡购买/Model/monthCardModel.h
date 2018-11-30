//
//  monthCardModel.h
//  SkyerParking
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface monthCardModel : NSObject
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * distance;
@property (nonatomic , copy) NSString              * ids;
@property (nonatomic , copy) NSString              * parkingName;
@property (nonatomic , copy) NSString              * cardTag;
@end

NS_ASSUME_NONNULL_END
