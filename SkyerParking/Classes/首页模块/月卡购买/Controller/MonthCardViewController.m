//
//  MonthCardViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "MonthCardViewController.h"
#import "mothCardTableViewCell.h"
#import "monthCareSearchView.h"
#import "monthCardModel.h"
#import "skCardDesViewController.h"

@interface MonthCardViewController ()
@property (nonatomic, strong) monthCareSearchView *viewSearch;
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,assign) NSInteger rowsIndex;
@property (nonatomic,strong) CLLocation *location;
@end

@implementation MonthCardViewController
-(monthCareSearchView *)viewSearch{
    if (nil==_viewSearch) {
        _viewSearch=skXibView(@"monthCareSearchView");
        @weakify(self)
        [[_viewSearch.txtSearch rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            if (x.length>0) {
                [self findParksHasCard:x];
            }
        }];
    }
    return _viewSearch;
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"月卡充值";
    [self addTableView];
    self.rowsIndex=10;
    [self createRefreshHeaderViewWithBlock:^{
        self.rowsIndex=10;
        [self startGetData];
    }];
    [self createRefreshFooterViewWithBlock:^{
        self.rowsIndex+=10;
        [self startGetData];
    }];
    [self startGetData];
}
-(void)startGetData{
    [SkLocation sharedSkLocation].skInitMannager().skStarUpdateLocation().locations = ^(NSArray *locations) {
        
        [SkLocation sharedSkLocation].skStopUpdateLocation();
        NSLog(@"%@",locations.firstObject);
        self.location=locations.firstObject;
        
        [self findParksHasCard:@""];
        
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)findParksHasCard:(NSString *)keyword{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/jfParkingManage/findParksHasCard"];
    
    
    NSDictionary *pageModel=@{@"page":@0,
                              @"rows":[NSNumber numberWithInteger:self.rowsIndex]
                              };
    
    
    NSDictionary *parame=@{
                           @"pageModel":pageModel,
                           @"longitude":[NSNumber numberWithDouble:self.location.coordinate.longitude],
                           @"latitude":[NSNumber numberWithDouble:self.location.coordinate.latitude],
                           @"keyword":keyword
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        [self headerEndRefreshing];
        [self footerEndRefreshing];
        
        skListModel *modelList=[skListModel mj_objectWithKeyValues:responseObject.data];
        self.arrList=[monthCardModel mj_objectArrayWithKeyValuesArray:modelList.list];
        
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.viewSearch;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"mothCardTableViewCell";
    mothCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"mothCardTableViewCell");
        NSLog(@"没复用");
    }
    
    monthCardModel *model=[self.arrList objectAtIndex:indexPath.row];
    cell.labParkingName.text=model.parkingName;
    cell.labDistance.text=[NSString stringWithFormat:@"%@km",model.distance];
    cell.labPlaceName.text=model.address;
    NSArray *arrCardType=[model.cardTag componentsSeparatedByString:@";"];
    
    for (int i=0; i<arrCardType.count; ++i) {
        if ([arrCardType containsObject:@"月卡"]) {
            cell.labMonthCard.text=@" 月卡 ";
        }
        if ([arrCardType containsObject:@"季卡"]) {
            cell.labQuarterCard.text=@" 季卡 ";
        }
        if ([arrCardType containsObject:@"年卡"]) {
            cell.labYearCard.text=@" 年卡 ";
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    monthCardModel *model=[self.arrList objectAtIndex:indexPath.row];
    skCardDesViewController *view=[[skCardDesViewController alloc] init];
    view.modelOther=model;
    [self.navigationController pushViewController:view animated:YES];
}
@end
