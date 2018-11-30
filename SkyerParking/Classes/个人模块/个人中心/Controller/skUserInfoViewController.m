//
//  skUserInfoViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skUserInfoViewController.h"
#import "userTableViewCell.h"
#import "UserInfoTableViewCell.h"
#import "skUserLoginViewController.h"
#import "AppDelegate.h"
#import "skWalletViewController.h"
#import "skTCBIViewController.h"
#import "skUserDetailsViewController.h"
#import "skRootController.h"
#import "userCenterInfoModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "UIImageView+WebCache.h"
#import "UIView+Shadow.h"


@interface skUserInfoViewController ()
@property (nonatomic,strong) UserInfoTableViewCell *cellUserInfo;
@property (nonatomic,strong) userCenterInfoModel *modelUser;
@end

@implementation skUserInfoViewController
- (UserInfoTableViewCell *)cellUserInfo{
    if (nil==_cellUserInfo) {
        _cellUserInfo=skXibView(@"UserInfoTableViewCell");
        
        @weakify(self)
        [[self.cellUserInfo.btnGoBalance rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (skUser.phone.length<11) {
                [skRootController skLoginViewController];
                return;
            }
            @strongify(self)//余额
            skWalletViewController *view=[[skWalletViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }];
        [[self.cellUserInfo.btnGoTCBI rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (skUser.phone.length<11) {
                [skRootController skLoginViewController];
                return;
            }
            @strongify(self)//停车币
            skTCBIViewController *view=[[skTCBIViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }];
        [[self.cellUserInfo.btnGoScore rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (skUser.phone.length<11) {
                [skRootController skLoginViewController];
                return;
            }
            @strongify(self)//积分
            NSLog(@"积分");
        }];
        [[self.cellUserInfo.btnHeaderDec rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (skUser.phone.length<11) {
                [skRootController skLoginViewController];
                return;
            }
            @strongify(self)//头像
            NSLog(@"修改头像");
            skUserDetailsViewController *viewUser=[[skUserDetailsViewController alloc] init];
            [self.navigationController pushViewController:viewUser animated:YES];
            
        }];
        [[self.cellUserInfo.btnEdior rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (skUser.phone.length<11) {
                [skRootController skLoginViewController];
                return;
            }
            @strongify(self)//头像
            NSLog(@"修改头像");
            skUserDetailsViewController *viewUser=[[skUserDetailsViewController alloc] init];
            [self.navigationController pushViewController:viewUser animated:YES];
            
        }];
        [[self.cellUserInfo.btnHeader rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            if (skUser.phone.length<11) {
                [skRootController skLoginViewController];
                return;
            }
            @strongify(self)//头像
            NSLog(@"修改头像");
            skUserDetailsViewController *viewUser=[[skUserDetailsViewController alloc] init];
            [self.navigationController pushViewController:viewUser animated:YES];
            
        }];
        
    }
    return _cellUserInfo;
}

-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.bounds=self.view.bounds;
    self.tableView.backgroundColor=skLineColor;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, -500, skScreenWidth, 500)];
    [view setBackgroundColor:skColorAppMain];
    [self.tableView addSubview:view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableView];
     
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self getUserInfosById];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UserCenter *)model{
    if (nil==_model) {
        _model=[[UserCenter alloc] init];
    }
    return _model;
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
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return self.model.arrSection1.count;
        }
            break;
        case 2:
        {
            return self.model.arrSection2.count;
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
            return 200;
        }
            break;
            
        default:
            break;
    }
    return 50;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 15;
//}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 15)];
    view.backgroundColor=skLineColor;
    return view;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            
            self.cellUserInfo.labName.text=skUser.phone.length<11?@"立即登录":self.modelUser.nickName;
            
            self.cellUserInfo.labBalance.text=[NSString stringWithFormat:@"%.02f",self.modelUser.balance];
            self.cellUserInfo.labTCBI.text=[NSString stringWithFormat:@"%.02f",self.modelUser.tingchebis];
            self.cellUserInfo.labScore.text=[NSString stringWithFormat:@"%.02f",self.modelUser.coins];
            
            UIImage *image=[UIImage imageNamed:@"touxiang"];
            
            [self.cellUserInfo.imageHeader sd_setImageWithURL:[NSURL URLWithString:self.modelUser.headPic] placeholderImage:image];
            [self.cellUserInfo.imageHeader skSetBoardRadius:30 Width:0 andBorderColor:[UIColor clearColor]];
            [self.cellUserInfo.btnHeader setBackgroundImage:[UIImage imageNamed:@"touxiangkuang"] forState:(UIControlStateNormal)];
            
//            [self.cellUserInfo.btnHeader sd_setImageWithURL:[NSURL URLWithString:self.modelUser.headPic] forState:(UIControlStateNormal) placeholderImage:image];
//            [self.cellUserInfo.btnHeader skSetShadowWithColor:skColorAppMain andSizeMake:CGSizeMake(0, 0) Radius:40];
            return self.cellUserInfo;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"userTableViewCell";
            userTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"userTableViewCell");
            }
            cellData *data=[_model.arrSection1 objectAtIndex:indexPath.row];
            
            cell.labTitle.text=data.title;
    
            if ([data.title isEqualToString:@"停车币"]) {
                [cell.labSubTitle setHidden:NO];
            }
            cell.labSubTitle.text=[NSString stringWithFormat:@"%.02f",self.modelUser.tingchebis];
            UIImage *image=[UIImage imageNamed:data.image];
            cell.image.image=image;
            
            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellIdentifier = @"userTableViewCell";
            userTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = skXibView(@"userTableViewCell");
            }
            cellData *data=[_model.arrSection2 objectAtIndex:indexPath.row];
            cell.labTitle.text=data.title;
            UIImage *image=[UIImage imageNamed:data.image];
            cell.image.image=image;
            
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
    
    if (skUser.phone.length<11) {
        [skRootController skLoginViewController];
        return;
    }
    
    UIViewController *view;
    switch (indexPath.section) {
        case 1:
        {
            cellData *data=[_model.arrSection1 objectAtIndex:indexPath.row];
            NSString *viewString=data.views;
            view=[[NSClassFromString(viewString) alloc] init];;
        }
            break;
        case 2:
        {
            cellData *data=[_model.arrSection2 objectAtIndex:indexPath.row];
            NSString *viewString=data.views;
            view=[[NSClassFromString(viewString) alloc] init];
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:view animated:YES];
}


-(void)getUserInfosById{
    if (skUser.phone.length==11) {
        [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/getUserInfosById"];
        
        NSDictionary *parame=@{@"memberId":skUser.memberId};
        
        [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
            
            self.modelUser=[userCenterInfoModel mj_objectWithKeyValues:responseObject.data];
            [self.tableView reloadData];
            
        } failure:^(NSError * _Nullable error) {
            
        }];
    }else{
        self.modelUser=nil;
        [self.tableView reloadData];
    }
    
}


@end
