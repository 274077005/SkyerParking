//
//  UserCenter.m
//  SkyerParking
//
//  Created by admin on 2018/7/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "UserCenter.h"
@implementation UserCenter
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrSection1=[self addSection1];
        self.arrSection2=[self addSection2];
    }
    return self;
}
-(NSMutableArray *)addSection1{
    NSMutableArray *arr1=[[NSMutableArray alloc] init];
    
    cellData*cell0=[[cellData alloc] init];
    cell0.image=@"qianbao";
    cell0.title=@"停车币";
    cell0.views=@"skTCBIViewController";
    [arr1 addObject:cell0];
    
    cellData*cell4=[[cellData alloc] init];
    cell4.image=@"yueka";
    cell4.title=@"月卡管理";
    cell4.views=@"skMonthCardMangerViewController";
    [arr1 addObject:cell4];
    
    cellData*cell1=[[cellData alloc] init];
    cell1.image=@"dingdan2";
    cell1.title=@"消费订单";
    cell1.views=@"PrakOrderViewController";
    [arr1 addObject:cell1];
    
    cellData*cell3=[[cellData alloc] init];
    cell3.image=@"card2";
    cell3.title=@"车牌管理";
    cell3.views=@"PlateManageViewController";
    [arr1 addObject:cell3];
    return arr1;
}
-(NSMutableArray *)addSection2{
    NSMutableArray *arr1=[[NSMutableArray alloc] init];
    cellData*cell1=[[cellData alloc] init];
    cell1.image=@"erweima2";
    cell1.title=@"推荐分享";
    cell1.views=@"ShareViewController";
    [arr1 addObject:cell1];
    
    cellData*cell2=[[cellData alloc] init];
    cell2.image=@"fankui2";
    cell2.title=@"意见反馈";
    cell2.views=@"ReflectViewController";
    [arr1 addObject:cell2];
    
    cellData*cell3=[[cellData alloc] init];
    cell3.image=@"shezhi";
    cell3.title=@"设置";
    cell3.views=@"SetCenterViewController";
    [arr1 addObject:cell3];
    return arr1;
}
@end
