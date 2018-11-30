//
//  skNearPointAnnotion.h
//  SkyerParking
//
//  Created by admin on 2018/7/19.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface skNearBaiDuPointAnnotion : BMKPointAnnotation

@property (nonatomic,assign) NSInteger indexAnnotion;
@property (nonatomic,assign) NSInteger state;

@end
