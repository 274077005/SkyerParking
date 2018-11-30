//
//  ParkingSearchViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/8.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ParkingSearchViewController.h"
#import "prakingSearchTableViewCell.h"
#import "prakingTitleView.h"
#import "getNearParkData.h"
#import "ParkDesViewController.h"
#import "skBMKMapNav.h"
#import "iflUse.h"


@interface ParkingSearchViewController ()
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,assign) int rows;
@property (nonatomic,strong) CLLocation *location;
@property (nonatomic,strong) prakingTitleView *TitleVie;
@end

@implementation ParkingSearchViewController
-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    self.TitleVie=[[prakingTitleView alloc] init];
    [self.TitleVie setBarButtonItem:self.navigationItem];
    
    if (self.parkingVoice!=0) {
        [self ifShow];
    }
    
    
    @weakify(self)
    [[self.TitleVie.btnVoide rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        [self ifShow];
        
    }];
    
    
    [SkLocation sharedSkLocation].skInitMannager().skStarUpdateLocation().locations = ^(NSArray *locations) {
        
        [SkLocation sharedSkLocation].skStopUpdateLocation();
        self.location=locations.firstObject;
        
        [[self.TitleVie.text rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            [self getParkData:x];
        }];
    };
}

//获取飞讯语音
-(void)ifShow{
    if (![self.TitleVie.text isExclusiveTouch]) {
        [self.TitleVie.text resignFirstResponder];
    }
    @weakify(self)
    iflUse *ifUser=[iflUse sharediflUse];
    [ifUser initIfly:self];
    [ifUser skyerStartIfly];
    [[ifUser rac_signalForSelector:@selector(skyerResultString:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        self.TitleVie.text.text=x[0];
        [self getParkData:x[0]];
    }];
}
//获取停车场信息
-(void)getParkData:(NSString *)x{
    [getNearParkData parksNearByLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude keyword:x page:0 rows:30  arrList:^(NSArray *arrList) {
        
        self.arrList=arrList;
        [self.tableView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 代理方法

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"parkingSearchTableViewCell";
    prakingSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"prakingSearchTableViewCell");
        @weakify(self)
        [[cell.btnAction rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            
            nearParkModel *model=[self.arrList objectAtIndex:indexPath.row];
            
            [[skBMKMapNav sharedskBMKMapNav]skGoNavView:model.latitude longitude:model.longitude andPlace:model.parking_name];
        }];
    }
    
    [cell updateData:_arrList[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ParkDesViewController *view=[[ParkDesViewController alloc] init];
    nearParkModel *model=_arrList[indexPath.row];
    view.model=model;
    [self.navigationController pushViewController:view animated:YES];
}
@end
