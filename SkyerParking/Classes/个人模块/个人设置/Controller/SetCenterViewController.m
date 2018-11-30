//
//  SetCenterViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "SetCenterViewController.h"
#import "setCenterTableViewCell.h"
#import "skUserLoginViewController.h"
#import "skChangePWDViewController.h"
#import "abousOursViewController.h"
#import "skRootController.h"
#import "UIImageView+WebCache.h"

@interface SetCenterViewController ()

@end

@implementation SetCenterViewController



-(void)addTableView
{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=skLineColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"设置";
    [self addTableView];
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
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 60)];
    view.backgroundColor=skLineColor;
    
    UIButton *btnLoginOut=[[UIButton alloc] initWithFrame:CGRectMake(0, 15, skScreenWidth, 50)];
    [btnLoginOut setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [view addSubview:btnLoginOut];
    [btnLoginOut setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btnLoginOut setBackgroundColor:[UIColor whiteColor]];
    [btnLoginOut skSetBoardRadius:5 Width:1 andBorderColor:[UIColor whiteColor]];
    @weakify(self)
    [[btnLoginOut rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"是否退出" message:@"退出部分功能不可使用" preferredStyle:(UIAlertControllerStyleAlert)];;
        UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2=[UIAlertAction actionWithTitle:@"退出" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self logout];
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }];
    return view;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"setCenterTableViewCell";
    setCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"setCenterTableViewCell");
    }
    
    switch (indexPath.row) {
        case 0:
        {
            [cell setAboutUs];
        }
            break;
        case 1:
        {
            [cell clearCache];
        }
            break;
        case 2:
        {
            [cell changePwd];
        }
            break;
        case 3:
        {
            [cell version];
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
            abousOursViewController *view=[[abousOursViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            UIAlertController *view=[UIAlertController alertControllerWithTitle:@"是否删除缓存?" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
            skWeakSelf(self)
            UIAlertAction *action1=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    [weakself.tableView reloadData];
                }];
                
                [[SDImageCache sharedImageCache] clearMemory];//可不写
                
            }];
            
            [view addAction:action];
            [view addAction:action1];
            
            [self presentViewController:view animated:YES completion:nil];
        }
            break;
        case 2:
        {
            skChangePWDViewController *pwdView=[[skChangePWDViewController alloc] init];
            [self.navigationController pushViewController:pwdView animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}


-(void)logout{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/logout"];
    NSDictionary *parame=@{@"memberId":skUser.memberId};
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        if (responseObject.returnCode==0) {
            [skRootController skUserLoginOutViewController];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}









@end
