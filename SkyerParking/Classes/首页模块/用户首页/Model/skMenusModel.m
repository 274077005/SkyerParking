//
//  skMenusModel.m
//  SkyerParking
//
//  Created by admin on 2018/11/26.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skMenusModel.h"


@implementation skMenusModel

- (NSMutableArray *)arrList{
    if (nil==_arrList) {
        _arrList=[[NSMutableArray alloc] init];
    }
    return _arrList;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        skMenuData *data0 =[[skMenuData alloc] init];
        data0.imageName=@"icon-60临停缴费.png";
        data0.title=@"临停缴费";
        data0.titleNext=@"临停缴费";
        data0.viewNext=@"UserPaymentViewController";
        [self.arrList addObject:data0];
        
        skMenuData *data1 =[[skMenuData alloc] init];
        data1.imageName=@"icon-60车位月卡.png";
        data1.title=@"车位月卡";
        data1.titleNext=@"icon-60车位月卡.png";
        data1.viewNext=@"MonthCardViewController";
        [self.arrList addObject:data1];
        
        skMenuData *data2 =[[skMenuData alloc] init];
        data2.imageName=@"icon-60停车币.png";
        data2.title=@"停车币";
        data2.titleNext=@"停车币";
        data2.viewNext=@"TCBIRechargeViewController";
        [self.arrList addObject:data2];
        
        skMenuData *data3 =[[skMenuData alloc] init];
        data3.imageName=@"icon-60车位共享.png";
        data3.title=@"车位共享";
        data3.titleNext=@"车位共享";
        data3.viewNext=@"CarPrakingSharedViewController";
        [self.arrList addObject:data3];
        
        skMenuData *data4 =[[skMenuData alloc] init];
        data4.imageName=@"icon-60车位租赁.png";
        data4.title=@"车位租赁";
        data4.titleNext=@"车位租赁";
        data4.viewNext=@"CarPrakingSharedViewController";
        [self.arrList addObject:data4];
        
        skMenuData *data5 =[[skMenuData alloc] init];
        data5.imageName=@"icon-60极致商城.png";
        data5.title=@"极致商城";
        data5.titleNext=@"极致商城";
        data5.viewNext=@"CarPrakingSharedViewController";
        [self.arrList addObject:data5];
        
        skMenuData *data6 =[[skMenuData alloc] init];
        data6.imageName=@"icon-60创业合伙.png";
        data6.title=@"创业投资";
        data6.titleNext=@"创业投资";
        data6.viewNext=@"CarPrakingSharedViewController";
        [self.arrList addObject:data6];
        
        skMenuData *data7 =[[skMenuData alloc] init];
        data7.imageName=@"icon-60加盟分公司.png";
        data7.title=@"分公司加盟";
        data7.titleNext=@"分公司加盟";
        data7.viewNext=@"CarPrakingSharedViewController";
        [self.arrList addObject:data7];
        
        
    }
    return self;
}
@end
