//
//  skMapCheck.m
//  SkyerParking
//
//  Created by admin on 2018/7/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skMapCheck.h"

@implementation skMapCheck
+(void)doNavigationWithEndLocation:(NSArray *)endLocation
{
    NSMutableArray *maps = [NSMutableArray array];
    //苹果原生地图-苹果原生地图方法和其他不一样
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
//        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=北京&mode=driving&coord_type=gcj02",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
//        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=2",@"导航功能",@"nav123456",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
//        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%@,%@&directionsmode=driving",@"导航测试",@"nav123456",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
//        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=终点&coord_type=1&policy=0",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    //选择
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSInteger index = maps.count;
    for (int i = 0; i < index; i++) {
        NSString * title = maps[i][@"title"];
        //苹果原生地图方法
        if (i == 0) {
            UIAlertAction * action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//                [self navAppleMapnavAppleMapWithArray:endLocation];
            }];
            [alert addAction:action];
            continue;
        }
        UIAlertAction * action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlString = maps[i][@"url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        [alert addAction:action];
    }
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [skVSView presentViewController:alert animated:YES completion:nil];
    // [self presentViewController:alert animated:YES completion:nil];
}

//苹果地图
- (void)navAppleMapnavAppleMapWithArray:(NSArray*) array
{
    float lat = [NSString stringWithFormat:@"%@", array[0]].floatValue;
    float lon = [NSString stringWithFormat:@"%@", array[1]].floatValue;
    //终点坐标
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(lat, lon);
    //用户位置
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    //终点位置
    MKMapItem *toLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:loc addressDictionary:nil] ];
    NSArray *items = @[currentLoc,toLocation];
    //第一个
    NSDictionary *dic = @{       MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,       MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),       MKLaunchOptionsShowsTrafficKey : @(YES)
                                 };
    //第二个，都可以用
    // NSDictionary * dic = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
    //       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]};
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}
@end
