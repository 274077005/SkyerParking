//
//  parkOrderModel.h
//  SkyerParking
//
//  Created by admin on 2018/9/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface parkOrderModel : NSObject
//@property (nonatomic, strong) NSString * createTime;
//@property (nonatomic, strong) NSString * enterTime;
//@property (nonatomic, strong) NSString * exitTime;
//@property (nonatomic, assign) CGFloat gainCoins;
//@property (nonatomic, assign) NSInteger isDel;
//@property (nonatomic, strong) NSString * licPlateNo;
//@property (nonatomic, assign) NSInteger mchId;
//@property (nonatomic, assign) NSInteger memberId;
//@property (nonatomic, assign) CGFloat money;
//@property (nonatomic, assign) NSInteger orderId;
//@property (nonatomic, strong) NSString * orderNo;
//@property (nonatomic, assign) NSInteger orderStatus;
//@property (nonatomic, assign) NSInteger orderType;
//@property (nonatomic, assign) NSInteger payChannel;
//@property (nonatomic, assign) BOOL payStatus;
//@property (nonatomic, assign) NSInteger plId;
//@property (nonatomic, assign) NSInteger psId;
//@property (nonatomic, assign) NSInteger recId;
//@property (nonatomic, strong) NSString * plName;
//@property (nonatomic, strong) NSString * duration;

//@property (nonatomic , assign) NSInteger              pay_stat;
//@property (nonatomic , assign) NSInteger              out_time;
//@property (nonatomic , assign) NSInteger              member_id;
//@property (nonatomic , copy) NSString              * cardType;
//@property (nonatomic , copy) NSString              * parkingId;
//@property (nonatomic , copy) NSString              * plate;
//@property (nonatomic , assign) NSInteger              order_time;
//@property (nonatomic , assign) NSInteger              pay_money;
//@property (nonatomic , copy) NSString              * parkingName;
//@property (nonatomic , copy) NSString              * pay_order_id;
//@property (nonatomic , assign) NSInteger              pay_time;
//@property (nonatomic , copy) NSString              * carType;
//@property (nonatomic , assign) NSInteger              in_time;


//@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * uId;
@property (nonatomic , assign) NSInteger              payStat;
@property (nonatomic , assign) NSInteger              outTime;
@property (nonatomic , copy) NSString              * cpuid;
@property (nonatomic , copy) NSString              * cardtype;
@property (nonatomic , copy) NSString              * controlhostip;
@property (nonatomic , copy) NSString              * parkingid;
@property (nonatomic , copy) NSString              * plate;
@property (nonatomic , assign) NSInteger              orderTime;
@property (nonatomic , copy) NSString              * preOrderId;
@property (nonatomic , assign) NSInteger              payMoney;
@property (nonatomic , assign) NSInteger              hasPaid;
@property (nonatomic , copy) NSString              * parkingName;
@property (nonatomic , copy) NSString              * payOrderId;
@property (nonatomic , assign) NSInteger              payTime;
@property (nonatomic , copy) NSString              * cartype;
@property (nonatomic , assign) NSInteger              inTime;
@property (nonatomic , assign) NSInteger              time;
//@property (nonatomic , strong) NSArray <FeeRuleItem *>              * feeRule;
@property (nonatomic , copy) NSString              * feeRuleDesc;

@end
