//
//  skNearViewController.h
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <MAMapKit/MAMapView.h>

@interface skNearViewController : skBaseViewController  <MAMapViewDelegate>
@property (nonatomic ,strong) MAMapView *mapView;
@end
