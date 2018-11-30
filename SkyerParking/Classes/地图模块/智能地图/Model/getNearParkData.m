//
//  getNearParkData.m
//  SkyerParking
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "getNearParkData.h"

@implementation getNearParkData
+(void)parksNearByLatitude:(double)latitude longitude:(double)longitude keyword:(NSString *)keyword page:(int)page rows:(int)rows arrList:(getNearList)list {
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/jfParkingManage/findParksNearBy"];
    
    NSDictionary *pageModel=@{@"page":[NSNumber numberWithInt:page],
                              @"rows":[NSNumber numberWithInt:rows]
                              };
    
    NSDictionary *parame=@{
                           @"distance":@1,
                           @"pageModel":pageModel,
                           @"latitude":[NSNumber numberWithDouble:latitude],
                           @"longitude":[NSNumber numberWithDouble:longitude],
                           @"keyword":keyword
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        skListModel *model=[skListModel mj_objectWithKeyValues:responseObject.data];
        NSArray *arrList=[nearParkModel mj_objectArrayWithKeyValuesArray:model.list];
        list(arrList);
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}
@end
