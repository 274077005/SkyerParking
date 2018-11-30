//
//  skMSGCenterViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/14.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skMSGCenterViewController.h"
#import "skMSGTableViewCell.h"
#import "OrdinaryMsgViewController.h"
#import "SystemMsgViewController.h"

@interface skMSGCenterViewController ()

@end

@implementation skMSGCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"消息中心";
    [self addTableView];
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
        make.left.right.bottom.mas_equalTo(0);
    }];;
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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skMSGTableViewCell";
    skMSGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skMSGTableViewCell");
    }
    switch (indexPath.row) {
        case 1:
        {
            cell.imageShow.image=[UIImage imageNamed:@"zijingbiandong"];
            cell.labTitle.text=@"资金变动";
            cell.labSubTitle.text=@"余额,停车币充值消费";
            
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            SystemMsgViewController *view=[[SystemMsgViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            OrdinaryMsgViewController *view=[[OrdinaryMsgViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
            
        default:
            break;
    }
}
@end
