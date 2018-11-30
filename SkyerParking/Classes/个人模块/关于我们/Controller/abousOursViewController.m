//
//  abousOursViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "abousOursViewController.h"
#import "skAbousOursHeaderView.h"
#import "skAbousTableViewCell.h"
#import "AgreementViewController.h"

@interface abousOursViewController ()

@end

@implementation abousOursViewController
-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=skLineColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
    self.title=@"关于我们";
    // Do any additional setup after loading the view.
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 240;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    skAbousOursHeaderView *view=skXibView(@"skAbousOursHeaderView");
    view.labVistion.text=[NSString stringWithFormat:@"停车道 %@",skAppVersion];
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skAbousTableViewCell";
    skAbousTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skAbousTableViewCell");
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.labPhone.text=@"";
            cell.labTitle.text=@"服务条款";
        }
            break;
        case 1:
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
            cell.labPhone.text=@"0771-10086";
            cell.labTitle.text=@"客服电话";
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
            AgreementViewController *view=[[AgreementViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
            
        }
            break;
            
        case 1:
        {
            NSString *allString = [NSString stringWithFormat:@"tel:10086"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
        }
            break;
        default:
            break;
    }
}
@end
