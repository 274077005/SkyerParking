//
//  skGetPyaDesMethod.m
//  SkyerParking
//
//  Created by admin on 2018/8/29.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skGetPyaDesMethod.h"
#import "payDesModel.h"
#import "respDataModel.h"

@implementation skGetPyaDesMethod
+(void)skBizMemberConsumerDetails:(skGetPyaDes)type rows:(NSInteger)rows arrList:(getList)getList respData:(getRespData)resData{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMemberConsumerDetails/list"];
    NSDictionary *dicandConds=@{
                                @"value":skUser.memberId,
                                @"operator":@"=",
                                @"columnName":@"member_id",
                                };
    NSDictionary *dicandConds1=@{
                                @"value":[NSNumber numberWithInt:type],
                                @"operator":@"=",
                                @"columnName":@"consumer_type",
                                };
    NSArray *andConds=@[dicandConds,dicandConds1];
    
    NSDictionary *pageModel=@{@"page":@0,
                              @"rows":@10
                              };
    
    NSDictionary *dicOrderBys=@{@"orderType":@"desc",
                                @"columnName":@"bmcd_id"
                                };
    NSArray *orderBys=@[dicOrderBys];
    
    NSDictionary *parame=@{
                           @"andConds":andConds,
                           @"pageModel":pageModel,
                           @"orderBys":orderBys
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        skListModel *model=[skListModel mj_objectWithKeyValues:responseObject.data];
        
        NSArray *arrModel=[payDesModel mj_objectArrayWithKeyValuesArray:model.list];
        
        
        getList(arrModel);
        
        resData(responseObject.respData);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
