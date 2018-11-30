//
//  skTCBIViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/19.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skTCBIViewController.h"
#import "TCBIView.h"
#import "WalletTableViewCell.h"
#import "TCBIRechargeViewController.h"
#import "skGetPyaDesMethod.h"
#import "payDesModel.h"
#import "respDataModel.h"

@interface skTCBIViewController ()
@property (nonatomic,strong) TCBIView *viewTCBI;
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,assign) NSInteger rows;
@end

@implementation skTCBIViewController

- (TCBIView *)viewTCBI{
    if (nil==_viewTCBI) {
        _viewTCBI=skXibView(@"TCBIView");
        [self.view addSubview:_viewTCBI];
        [_viewTCBI mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(180);
        }];
        
        @weakify(self)
        [[_viewTCBI.btnPutint rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//充值
            TCBIRechargeViewController *view=[[TCBIRechargeViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }];
    }
    return _viewTCBI;
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewTCBI.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"停车币";
    [self viewTCBI];
    [self addTableView];
    self.rows=10;
    
    skWeakSelf(self)
    [self createRefreshFooterViewWithBlock:^{
        weakself.rows+=10;
        [weakself getData];
    }];
    [self createRefreshHeaderViewWithBlock:^{
        weakself.rows=10;
        [weakself getData];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

-(void)getData{
    [skGetPyaDesMethod skBizMemberConsumerDetails:skGetPyaDesTCBI rows:self.rows arrList:^(NSArray * _Nonnull arrList) {
        self.arrList=arrList;
        [self footerEndRefreshing];
        [self headerEndRefreshing];
        [self.tableView reloadData];
    } respData:^(id  _Nonnull RespData) {
        respDataModel *model=[respDataModel mj_objectWithKeyValues:RespData];
        self.viewTCBI.labMoney.text=[NSString stringWithFormat:@"%.02f",model.tingchebis];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 40)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel *labTitle=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, skScreenWidth-20, 40)];
    labTitle.text=@"停车币明细";
    labTitle.font=[UIFont systemFontOfSize:14];
    [view addSubview:labTitle];
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"WalletTableViewCell";
    WalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"WalletTableViewCell");
    }
    
    payDesModel *model=self.arrList[indexPath.row];
    
    NSInteger number=model.number;//数量
    NSInteger datasrc=model.datasrc;//来源
    NSString *dataremarks=model.dataremarks;//描述
    NSInteger scoretype=model.scoretype;//收入或支出
    NSString *createtime=model.createtime;
    
    
    cell.imageDes.image=[UIImage imageNamed:[NSString stringWithFormat:@"pay%ld",scoretype]];
    
    cell.labDes.text=dataremarks;
    if (scoretype==2) {
        cell.labCount.textColor=skUIColorFromRGB(0xF6BD52);
        cell.labCount.text=[NSString stringWithFormat:@"-%ld",number];
    }else{
        cell.labCount.textColor=skUIColorFromRGB(0x508DFF);
        cell.labCount.text=[NSString stringWithFormat:@"+%ld",number];
    }
    
    cell.labTime.text=createtime;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
