//
//  skNearViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skNearViewController.h"
#import "DetailsView.h"
#import "UIView+Shadow.h"
#import "searchMapView.h"
#import "skNearBaiDuPointAnnotion.h"
#import "ParkDesViewController.h"
#import "ParkingSearchViewController.h"
#import "skBMKMapNav.h"
#import <CoreLocation/CoreLocation.h>
#import "skNearGaoDePointAnnotion.h"
#import "nearParkModel.h"
#import "skNearAnnotionView.h"
#import "actionView.h"
#import "UIView+Shadow.h"
#import "getNearParkData.h"

@interface skNearViewController ()
@property (nonatomic,strong) DetailsView *viewDetails;
@property (nonatomic,strong) searchMapView *viewSearch;
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) NSMutableArray *arrAnnotions;
@property (nonatomic,strong) actionView *viewAction;
@property (nonatomic,assign) NSInteger indexSelect;
@end

@implementation skNearViewController

- (MAMapView *)mapView{
    if (nil==_mapView) {
        _mapView=[[MAMapView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_mapView];
        _mapView.delegate=self;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.rotateEnabled=NO;
        _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
        _mapView.rotateCameraEnabled=NO;
        _mapView.logoCenter = CGPointMake(50, skScreenHeight-100);
        
        MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
        r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
        r.image = [UIImage imageNamed:@"dangqianweizhi"]; ///定位图标, 与蓝色原点互斥
        [_mapView updateUserLocationRepresentation:r];
    }
    return _mapView;
}

-(DetailsView *)viewDetails{
    if (nil==_viewDetails) {
        _viewDetails=skXibView(@"DetailsView");
        _viewDetails.alpha=0;
        _viewDetails.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5];
        [self.mapView addSubview:_viewDetails];
        
        [_viewDetails.viewContance skSetShadowWithColor:skBaseColor andSizeMake:CGSizeMake(0, 0) Radius:5];
        
        [_viewDetails.btnGoto skSetBoardRadius:4 Width:0 andBorderColor:[UIColor clearColor]];
        
        _viewDetails.backgroundColor=[[UIColor clearColor] colorWithAlphaComponent:0];
        [_viewDetails mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.top.left.right.mas_equalTo(0);
        }];
        @weakify(self)
        [[_viewDetails.btnGoto rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//立即前往
            
            nearParkModel *model=[self.arrList objectAtIndex:self.indexSelect];
            [[skBMKMapNav sharedskBMKMapNav]skGoNavView:model.latitude longitude:model.longitude andPlace:model.parking_name];
        }];
        
        [[_viewDetails.btnMiss rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self updateDetailView];
        }];
        
        [[_viewDetails.btnDes rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//详情
            nearParkModel *model=[self.arrList objectAtIndex:self.indexSelect];
            ParkDesViewController *viwe=[[ParkDesViewController alloc] init];
            viwe.model=model;
            [self.navigationController pushViewController:viwe animated:YES];
        }];
    }
    return _viewDetails;
}

-(searchMapView *)viewSearch{
    if (nil==_viewSearch) {
        _viewSearch=skXibView(@"searchMapView");
        [self.view addSubview:_viewSearch];
        [_viewSearch.viewSearch skSetShadowWithColor:skColorAppMain andSizeMake:CGSizeMake(0, 0) Radius:5];
        [_viewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
        
        @weakify(self)
        [[_viewSearch.btnBack rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//返回
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [[_viewSearch.btnSearch rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//搜索
            ParkingSearchViewController *view=[[ParkingSearchViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }];
        [[_viewSearch.btnVoice rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//返回
            ParkingSearchViewController *view=[[ParkingSearchViewController alloc] init];
            view.parkingVoice=ParkingVoiceShow;
            [self.navigationController pushViewController:view animated:YES];
        }];
    }
    return _viewSearch;
}

-(actionView *)viewAction{
    if (nil==_viewAction) {
        _viewAction=skXibView(@"actionView");
        [_viewAction.btnCenter skSetShadowWithColor:skColorAppMain andSizeMake:CGSizeMake(0, 0) Radius:5];
        [_viewAction.btnRountState skSetShadowWithColor:skColorAppMain andSizeMake:CGSizeMake(0, 0) Radius:5];
        [self.view addSubview:_viewAction];
        [_viewAction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 100));
            make.top.mas_equalTo(self.viewSearch.mas_bottom).offset(20);
            make.right.mas_equalTo(self.viewSearch.mas_right).offset(-15);
        }];
        
        @weakify(self)
        [[_viewAction.btnCenter rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        }];
        
        [[_viewAction.btnRountState rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.mapView.showTraffic = !self.mapView.showTraffic;
            UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"lukuang%d",self.mapView.showTraffic]];
            [self.viewAction.btnRountState setImage:image forState:(UIControlStateNormal)];
        }];
    }
    return _viewAction;
}

#pragma mark 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"附近";
    self.mapView.showsUserLocation=YES;
    [self viewSearch];
    [self viewAction];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CLLocationCoordinate2D coord=self.mapView.userLocation.location.coordinate;
        [getNearParkData parksNearByLatitude:coord.latitude longitude:coord.longitude keyword:@"" page:0 rows:30  arrList:^(NSArray *arrList) {
            self.arrList=arrList;
            [self skAddAnnotions];
        }];
    });
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

/**
 显示或隐藏详情页面
 */
-(void)updateDetailView{
    [UIView animateWithDuration:0.5 animations:^{
        self.viewDetails.alpha=self.viewDetails.alpha?0:1;
    }];
}

#pragma mark - 添加annotion到地图上
-(void)skAddAnnotions{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    self.arrAnnotions=[[NSMutableArray alloc] init];
    for (int i =0; i<self.arrList.count; ++i) {
        skNearGaoDePointAnnotion *annotion=[[skNearGaoDePointAnnotion alloc] init];
        nearParkModel *model=[nearParkModel mj_objectWithKeyValues:[_arrList objectAtIndex:i]];
        annotion.indexAnnotion=i;
        annotion.title=model.parking_name;
        /**
        isOpen
        是否开放
        1
        Boolean
        F1
        true/false
        isJoin
        是否已加盟
        1
        Short
        F1
        1=已加盟,0=未加盟
         **/
//        if (model.isJoin==1) {
//            if (model.isOpen) {
//                annotion.state=model.fullLvl;
//            }else{
//                annotion.state=4;
//            }
//        }else{
//            annotion.state=4;
//        }
        annotion.state=4;
        
        annotion.coordinate=CLLocationCoordinate2DMake(model.latitude, model.longitude);
        
        [self.arrAnnotions addObject:annotion];
    }
    
    [self.mapView addAnnotations:self.arrAnnotions];
    
    if (self.mapView.zoomLevel<=10) {
        [self.mapView showAnnotations:self.mapView.annotations animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:NO];
            [self.mapView setZoomLevel:19 animated:YES];
            
        });
    }
    
}

#pragma mark - 地图的代理方法

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"dangqianweizhi"];
        return annotationView;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        skNearAnnotionView *annotationView = (skNearAnnotionView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[skNearAnnotionView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        skNearGaoDePointAnnotion *ska=(skNearGaoDePointAnnotion *)annotation;
        
        NSInteger parkingState=ska.state;
        
        annotationView.image =[UIImage imageNamed:[NSString stringWithFormat:@"zuobiao%ld",parkingState]];
        
        annotationView.canShowCallout               = NO;
        annotationView.animatesDrop                 = NO;
        annotationView.draggable                    = NO;
        
        return annotationView;
    }
    
    return nil;
}
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    skNearGaoDePointAnnotion *annotion=(skNearGaoDePointAnnotion *)view.annotation;
    
    NSInteger index=annotion.indexAnnotion;
    self.indexSelect=index;
    nearParkModel *model=[_arrList objectAtIndex:index];
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(model.latitude, model.longitude) animated:YES];
    
    [self.viewDetails updateData:model];
    [self updateDetailView];
    
}
@end
