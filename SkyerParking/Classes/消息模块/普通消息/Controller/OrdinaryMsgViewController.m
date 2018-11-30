//
//  OrdinaryMsgViewController.m
//  SkyerParking
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "OrdinaryMsgViewController.h"
#import "OrdinaryMsgTableViewCell.h"
#import "OrdinaryMsgModel.h"

@interface OrdinaryMsgViewController ()
@property (nonatomic,strong) NSArray *arrList;
@property (nonatomic,assign) int index;
@end

@implementation OrdinaryMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    [self msgPushHistory];
    self.title=@"资金变动";
    [self createRefreshHeaderViewWithBlock:^{
        self.index=10;
        [self msgPushHistory];
    }];
    [self createRefreshFooterViewWithBlock:^{
        self.index+=10;
        [self msgPushHistory];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=skLineColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}


-(void)msgPushHistory{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/msgPushHistory/list"];
    
    
    NSDictionary *dicandConds=@{
                                @"value":skUser.memberId,
                                @"operator":@"=",
                                @"columnName":@"member_id",
                                };
    
    NSArray *andConds=@[dicandConds];
    
    NSDictionary *pageModel=@{@"page":@0,
                              @"rows":[NSNumber numberWithInt:self.index]
                              };
    
    NSDictionary *orderBys=@{@"orderType":@"desc",
                             @"columnName":@"push_time"};
    
    NSDictionary *parame=@{
                           @"andConds":andConds,
                           @"pageModel":pageModel,
                           @"orderBys":@[orderBys]
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        [self headerEndRefreshing];
        [self footerEndRefreshing];
        
        skListModel *modelList=[skListModel mj_objectWithKeyValues:responseObject.data];
        
        self.arrList=[OrdinaryMsgModel mj_objectArrayWithKeyValuesArray:modelList.list];
        
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrList.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 10)];
    view.backgroundColor=skLineColor;
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"OrdinaryMsgTableViewCell";
    OrdinaryMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"OrdinaryMsgTableViewCell");
    }
    cell.backgroundColor=skLineColor;
    
    OrdinaryMsgModel *model=[_arrList objectAtIndex:indexPath.section];
    
    cell.labTitle.text=model.pushAccountName;
    cell.labTime.text=model.pushTime;
    cell.labContain.text=model.pushContent;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
