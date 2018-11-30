//
//  nearParkModel.h
//  SkyerParking
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface nearParkModel : NSObject
//@property (nonatomic, strong) NSString * address;
//@property (nonatomic, strong) NSString * contactPhone;
//@property (nonatomic, strong) NSString * countyCode;
//@property (nonatomic, strong) NSString * distance;
//@property (nonatomic, assign) NSInteger fixCarsNum;
//@property (nonatomic, strong) NSString * freeTmpCarsNum;
//@property (nonatomic, assign) NSInteger fullLvl;
//@property (nonatomic, assign) NSInteger isJoin;
//@property (nonatomic, assign) BOOL isOpen;
//@property (nonatomic, assign) CGFloat latitude;
//@property (nonatomic, assign) CGFloat longitude;
//@property (nonatomic, strong) NSString * picUrl;
//@property (nonatomic, assign) NSInteger plId;
//@property (nonatomic, strong) NSString * plName;
//@property (nonatomic, strong) NSString * plNo;
//@property (nonatomic, strong) NSString * provCode;
//@property (nonatomic, strong) NSString * regionCode;
//@property (nonatomic, assign) NSInteger rentCarsNum;
//@property (nonatomic, assign) NSInteger tmpCarsNum;
//@property (nonatomic, assign) NSInteger totalCarsNum;

@property (nonatomic , assign) NSInteger              fees;
@property (nonatomic , copy) NSString              * address;
@property (nonatomic , copy) NSString              * distance;
@property (nonatomic , assign) NSInteger              stall_count;
@property (nonatomic , assign) CGFloat              latitude;
@property (nonatomic , copy) NSString              * property_owned;
@property (nonatomic , assign) CGFloat              end_time;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * mch_id;
@property (nonatomic , copy) NSString              * receipt_account;
@property (nonatomic , assign) NSInteger              fixed_parking_number;
@property (nonatomic , copy) NSString              * mch_key;
@property (nonatomic , assign) NSInteger              start_time;
@property (nonatomic , assign) NSInteger              public_parking_number;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * parking_name;
@property (nonatomic , copy) NSString              * merchants;
@property (nonatomic , assign) NSInteger              delete_flag;
@property (nonatomic , assign) NSInteger              xgsj;
@property (nonatomic , assign) CGFloat              longitude;
@end
