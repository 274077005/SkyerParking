//
//  BMKMapNav.h
//  SkyerParking
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface skBMKMapNav : NSObject <AMapNaviCompositeManagerDelegate>
SkyerSingletonH(skBMKMapNav)
@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;
-(void)skGoNavView:(double)latitude longitude:(double)longitude andPlace:(NSString *)palce;
@end
