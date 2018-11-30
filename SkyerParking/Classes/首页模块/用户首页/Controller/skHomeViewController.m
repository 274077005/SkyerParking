//
//  skHomeViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skHomeViewController.h"
#import "skUserLoginViewController.h"
#import "skMapCheck.h"
#import "skParameDealMethod.h"
#import "skApplyToken.h"
#import "skMSGCenterViewController.h"
#import "skHomeNearTableViewCell.h"
#import "ParkDesViewController.h"
#import "skBMKMapNav.h"
#import "getNearParkData.h"
#import "AdvertisingModel.h"
#import "skRootController.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"
#import "skImageCycleTableViewCell.h"
#import "skMunesTableViewCell.h"
#import "skViewHomeSearch.h"
#import "ParkingSearchViewController.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

//轮播图的高度
#define KImageRowHight 150
//菜单的高度
#define KMenuRowHigth 170
//附近停车场的高度
#define KNearRowHight 107


@interface skHomeViewController ()<JFLocationDelegate, JFCityViewControllerDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,strong) NSString *place;
@property (nonatomic,assign) int rows;
@property (nonatomic,strong) NSArray *arrAidList;
@property (nonatomic,strong) NSMutableArray *arrImageAid;
@property (nonatomic,strong) SDCycleScrollView *viewCycle;
@property (nonatomic,strong) skViewHomeSearch *viewSearch;
/** 选择的结果*/
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;
@property (nonatomic,strong) skImageCycleTableViewCell *cellImageCycle;//轮播图
@property (nonatomic,strong) skMunesTableViewCell *cellMunes;//菜单
@end

@implementation skHomeViewController


- (skViewHomeSearch *)viewSearch{
    if (nil==_viewSearch) {
        _viewSearch=skXibView(@"skViewHomeSearch");
        [_viewSearch.viewSearch skSetBoardRadius:5 Width:0 andBorderColor:nil];
        @weakify(self)
        [[_viewSearch.btnRight rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            
            if (skUser.phone.length<11) {
                [skRootController skLoginViewController];
                return;
            }
            skMSGCenterViewController *view=[[skMSGCenterViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
            
        }];
        [[_viewSearch.btnCity rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            
        if (skUser.phone.length<11) {
            [skRootController skLoginViewController];
            return;
        }
        JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
        cityViewController.delegate = self;
        cityViewController.title = @"城市";
        skBaseNavViewController *navigationController = [[skBaseNavViewController alloc] initWithRootViewController:cityViewController];
        [self presentViewController:navigationController animated:YES completion:nil];
            
        }];
        [[_viewSearch.btnSearch rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (skUser.phone.length<11) {
                [skRootController skLoginViewController];
                return;
            }
            ParkingSearchViewController *skNear = [[ParkingSearchViewController alloc] init];
            [self.navigationController pushViewController:skNear animated:YES];
            
        }];
        [_viewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 40));
        }];
    }
    return _viewSearch;
}
- (void)cityName:(NSString *)name{
    NSString *nameShow=[name substringToIndex:2];
    [self.viewSearch.btnCity setTitle:nameShow forState:(UIControlStateNormal)];
}
#pragma mark - 轮播图

- (skImageCycleTableViewCell *)cellImageCycle{
    if (nil==_cellImageCycle) {
        _cellImageCycle=skXibView(@"skImageCycleTableViewCell");
    }
    return _cellImageCycle;
}
- (skMunesTableViewCell *)cellMunes{
    if (nil==_cellMunes) {
        _cellMunes=skXibView(@"skMunesTableViewCell");
    }
    return _cellMunes;
}

- (SDCycleScrollView *)viewCycle{
    if (nil==_viewCycle) {
        _viewCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, skScreenWidth, 150) delegate:self placeholderImage:[UIImage imageNamed:@"imageShow-0"]];
    }
    return _viewCycle;
}

-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
    skWeakSelf(self)
    [self createRefreshHeaderViewWithBlock:^{
        NSLog(@"开始下拉");
        weakself.rows=10;
        [weakself startGetData];
        [self Advertisinglist];
    }];
    
    [self createRefreshFooterViewWithBlock:^{
        if (weakself.rows<60) {
            weakself.rows+=10;
        }
        [weakself startGetData];
    }];
}
-(void)startGetData{
    [SkLocation sharedSkLocation].skInitMannager().skStarUpdateLocation().locations = ^(NSArray *locations) {
        
        [SkLocation sharedSkLocation].skStopUpdateLocation();
        NSLog(@"%@",locations.firstObject);
        CLLocation *location=locations.firstObject;
        
        [[SkLocation sharedSkLocation] getPlaceWithLocation:location finshBlock:^(CLPlacemark *placemark) {
            NSLog(@"位置信息=%@",placemark);
            
            self.place=placemark.addressDictionary[@"Name"];
            
            [getNearParkData parksNearByLatitude:location.coordinate.latitude longitude:location.coordinate.longitude keyword:@"" page:0 rows:self.rows  arrList:^(NSArray *arrList) {
                
                [self headerEndRefreshing];
                [self footerEndRefreshing];
                self.arrList=arrList;
                [self.tableView reloadData];
            }];
        }];
        
    };
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title=@"首页";
    NSLog(@"程序出现");
    
    [self addTableView];
    self.navigationItem.titleView=self.viewSearch;
    [self startGetData];
    [self Advertisinglist];
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
}
- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareInstance];
        [_manager areaSqliteDBData];
    }
//    return _manager;
    return nil;
}

//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    if (![[KCURRENTCITYINFODEFAULTS objectForKey:@"currentCity"] isEqualToString:city]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return self.arrList.count;
        }
            break;
            
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0://轮训图的高度
                {
                    return KImageRowHight;
                }
                    break;
                case 1://菜单的高度
                {
                    return KMenuRowHigth;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            return KNearRowHight;//附近停车场的高度
            
        }
            break;
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==1) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==1) {//附近停车位的
        UIView *view=[[UIView alloc] init];
        view.backgroundColor=[UIColor whiteColor];
        view.frame=CGRectMake(0, 0, skScreenWidth, 40);
        
        UILabel *labNear=[[UILabel alloc] init];
        labNear.text=@"附近车位";
        labNear.frame=CGRectMake(15, 0, 200, 40);
        labNear.font=[UIFont systemFontOfSize:16];
        [view addSubview:labNear];
        //位置信息
        UILabel *labAddress=[[UILabel alloc] initWithFrame:CGRectMake(-15, 0, skScreenWidth, 40)];
        labAddress.text=self.place;
        labAddress.textColor=[UIColor lightGrayColor];
        labAddress.textAlignment=2;
        labAddress.font=[UIFont systemFontOfSize:12];
        [view addSubview:labAddress];
        
        UILabel *labLine=[[UILabel alloc] initWithFrame:CGRectMake(15, 38, skScreenWidth-30, 1)];
        labLine.backgroundColor=skLineColor;
        [view addSubview:labLine];
        
        return view;
    }
    return nil;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [self.cellImageCycle.contentView addSubview:self.viewCycle];
                    self.viewCycle.imageURLStringsGroup = self.arrImageAid;
                    return self.cellImageCycle;
                }
                    break;
                case 1:
                {
                    return self.cellMunes;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            
            static NSString *cellIdentifier = @"skHomeNearTableViewCell";
            skHomeNearTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            nearParkModel *model=[_arrList objectAtIndex:indexPath.row];
            
            if (cell == nil) {
                cell = skXibView(@"skHomeNearTableViewCell");
                [[cell.btnGoNav rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    [[skBMKMapNav sharedskBMKMapNav]skGoNavView:model.latitude longitude:model.longitude andPlace:model.parking_name];
                }];
            }
            [cell updateData:model];
            
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 1:
            {
                nearParkModel *model=[self.arrList objectAtIndex:indexPath.row];
                ParkDesViewController *viwe=[[ParkDesViewController alloc] init];
                viwe.model=model;
                [self.navigationController pushViewController:viwe animated:YES];
            }
            break;
            
            
        default:
            break;
    }
}
#pragma mark - 轮播图
-(void)Advertisinglist{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizAdvertising/list"];
    NSDictionary *dicandConds=@{
                                @"value":@"1",
                                @"operator":@"=",
                                @"columnName":@"is_flag",
                                };
    NSArray *andConds=@[dicandConds];
    
    NSDictionary *pageModel=@{@"page":@0,
                              @"rows":@3
                              };
    
    NSDictionary *dicOrderBys=@{@"orderType":@"ASC",
                                @"columnName":@"create_time"
                                };
    NSArray *orderBys=@[dicOrderBys];
    
    NSDictionary *parame=@{
                           @"andConds":andConds,
                           @"pageModel":pageModel,
                           @"orderBys":orderBys
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        skListModel *modelList=[skListModel mj_objectWithKeyValues:responseObject.data];
        
        self.arrAidList=[AdvertisingModel mj_objectArrayWithKeyValuesArray:modelList.list];
//        advertisingPic
        self.arrImageAid=[[NSMutableArray alloc] init];
        for (int i=0; i<self.arrAidList.count; ++i) {
            AdvertisingModel *model=[self.arrAidList objectAtIndex:i];
            
            NSString *advertisingPic=model.advertisingPic;
            
            [self.arrImageAid addObject:advertisingPic];
            
        }
        
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        
        
    }];
}
@end
