//
//  PrakOrderViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "PrakOrderViewController.h"
#import "ParkOrderTableViewCell.h"
#import "skOrderPaymentViewController.h"
#import "parkOrderModel.h"
#import "NSString+skString.h"

@interface PrakOrderViewController ()
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,assign) int rows;
@end

@implementation PrakOrderViewController

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
    self.title=@"停车订单";
    [self addTableView];
    
    self.rows=10;
    
    skWeakSelf(self)
    [self createRefreshHeaderViewWithBlock:^{
        self.rows=10;
        [weakself bizParkingOrder];
    }];
    [self createRefreshFooterViewWithBlock:^{
        self.rows+=10;
        [weakself bizParkingOrder];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self bizParkingOrder];
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
    return _arrList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"ParkOrderTableViewCell";
    ParkOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"ParkOrderTableViewCell");
        NSLog(@"没复用");
    }else{
        NSLog(@"复用了");
    }
    parkOrderModel *model=[_arrList objectAtIndex:indexPath.row];
    cell.labPateNo.text=model.plate;
    cell.labPateAddress.text=model.parkingName;
    cell.labCharge.text=@"555555";
    NSString *inTime=[NSString stringWithFormat:@"%ld",model.inTime];
    cell.labTime.text=[inTime cStringFromTimestamp:inTime];
    cell.labPayNumber.text=[NSString stringWithFormat:@"费用:%ld元",model.payMoney];
    
    if (!model.payStat) {
        cell.labState.text=@"进行中";
        [cell.labState setTextColor:skColorAppMain];
    }else{
        cell.labState.text=@"已完成";
        [cell.labState setTextColor:[UIColor lightGrayColor]];
    }
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    skOrderPaymentViewController *view=[[skOrderPaymentViewController alloc] init];
    view.modelOther=self.arrList[indexPath.row];
    [self.navigationController pushViewController:view animated:YES];
}

/**
 获取订单列表
 */
-(void)bizParkingOrder{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/jfParkingOrder/queryParkingOrderList"];
    
    
    
    NSDictionary *parame=@{
                           @"memberId":skUser.memberId,
                           @"page":@"1",
                           @"pageSize" :[NSString stringWithFormat:@"%d",self.rows]
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        [self headerEndRefreshing];
        [self footerEndRefreshing];
        skListModel *model=[skListModel mj_objectWithKeyValues:responseObject.data];
        self.arrList = [parkOrderModel mj_objectArrayWithKeyValuesArray:model.list];
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
