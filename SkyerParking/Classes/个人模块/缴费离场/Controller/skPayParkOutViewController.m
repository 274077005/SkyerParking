//
//  skPayParkOutViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/14.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skPayParkOutViewController.h"
#import "skPayParkOutViewsHeader.h"
#import "skPayParkOutTableViewCell.h"
#import "PaySuccessViewController.h"
#import "skOrderParkModel.h"
#import "TCBIRechargeViewController.h"
#import "WXApiRequestHandler.h"
#import <AlipaySDK/AlipaySDK.h>
#import "skZFBPayModel.h"
#import "skWXPayModel.h"
#import "WXApi.h"
#import "APOrderInfo.h"
#import "skZFUResult.h"
#import "WXApiManager.h"

@interface skPayParkOutViewController ()<WXApiManagerDelegate>
@property (nonatomic,assign) NSInteger indexSelect;
@property (nonatomic,strong) UIButton *btnSure;
@property (nonatomic,strong) skZFBPayModel *modelZFB;
@property (nonatomic,strong) skWXPayModel *modelWX;
@end

@implementation skPayParkOutViewController

-(void)addTableView{
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
    self.title=@"计费中";
    [self addTableView];
    [self initWX];
    [self initZFU];;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 初始化微信支付
 */
-(void)initWX{
    [WXApiManager sharedManager].delegate = self;
    @weakify(self)
    [[[WXApiManager sharedManager] rac_signalForSelector:@selector(paySuccess)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        //成功
        PaySuccessViewController *view=[[PaySuccessViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }];
    [[[WXApiManager sharedManager] rac_signalForSelector:@selector(payFaile)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"支付失败" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}
-(void)initZFU{
    @weakify(self)
    [[[skZFUResult sharedskZFUResult] rac_signalForSelector:@selector(paySuccess)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        //成功
        PaySuccessViewController *view=[[PaySuccessViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }];
    [[[skZFUResult sharedskZFUResult] rac_signalForSelector:@selector(payFaile)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"支付失败" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
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
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    skPayParkOutViewsHeader *viewHeader=skXibView(@"skPayParkOutViewsHeader");
    viewHeader.labCharge.text=[NSString stringWithFormat:@"%ld",self.model.payMoney/100];
    return viewHeader;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 100)];
    self.btnSure=[[UIButton alloc] init];
    [self.btnSure setTitle:@"确认支付" forState:(UIControlStateNormal)];
    if (self.model.payStat) {
        [self.btnSure setTitle:@"已经支付" forState:(UIControlStateNormal)];
    }
    self.btnSure.backgroundColor=skColorAppMain;
    [view addSubview:self.btnSure];
    [self.btnSure skSetBoardRadius:5 Width:0 andBorderColor:nil];
    [self.btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(skScreenWidth-20);
        make.height.mas_equalTo(44);
        make.centerY.mas_equalTo(view);
        make.centerX.mas_equalTo(view);
    }];
    [[self.btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self PayCharge];
    }];
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skPayParkOutTableViewCell";
    skPayParkOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skPayParkOutTableViewCell");
    }
    
    switch (indexPath.row) {
        case 0:
        {
            if (self.indexSelect==0) {
                cell.imageView.image=[UIImage imageNamed:@"gou"];
            }else{
                cell.imageView.image=[UIImage imageNamed:@"yuanquan"];
            }
            cell.labNumber.text=[NSString stringWithFormat:@"停车币"];
            [[cell.btnCharge rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                TCBIRechargeViewController *view=[[TCBIRechargeViewController alloc] init];
                [self.navigationController pushViewController:view animated:YES];
            }];
        }
            break;
        case 1:
        {
            [cell.btnCharge setHidden:YES];
            if (self.indexSelect==1) {
                cell.imageView.image=[UIImage imageNamed:@"gou"];
            }else{
                cell.imageView.image=[UIImage imageNamed:@"yuanquan"];
            }
            cell.labNumber.text=[NSString stringWithFormat:@"微信支付"];
        }
            break;
        case 2:
        {
            [cell.btnCharge setHidden:YES];
            if (self.indexSelect==2) {
                cell.imageView.image=[UIImage imageNamed:@"gou"];
            }else{
                cell.imageView.image=[UIImage imageNamed:@"yuanquan"];
            }
            cell.labNumber.text=[NSString stringWithFormat:@"支付宝"];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.indexSelect=indexPath.row;
    [self.tableView reloadData];
}
#pragma mark - 支付

-(void)PayCharge{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/pay/payTempParkCar"];
    
    NSString *payType;
    NSInteger type=self.indexSelect;
    switch (type) {
        case 0:
        {
            payType=@"3";
        }
            break;
        case 1:
        {
            payType=@"2";
        }
            break;
        case 2:
        {
            payType=@"1";
        }
            break;
            
        default:
            break;
    }
    
    NSDictionary *parame=@{@"orderId":self.model.uId,
                           @"payType":[NSNumber numberWithInt:[payType intValue]],
                           @"memberId":skUser.memberId,
                           @"transactionType":@"APP"
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        
        if (responseObject.returnCode==0) {
            switch (self.indexSelect) {
                case 0:
                {
                    PaySuccessViewController *view=[[PaySuccessViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
                    break;
                case 1://微信
                {
                    self.modelWX=[skWXPayModel mj_objectWithKeyValues:responseObject.data];
                    [self openWXAPP];
                }
                    break;
                case 2://支付宝
                {
                    self.modelZFB=[skZFBPayModel mj_objectWithKeyValues:responseObject.data];
                    [self openZFBApp];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 打开微信支付
 */
-(void)openWXAPP{
    
    if(self.modelWX){
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.partnerId           = self.modelWX.partnerid;
        req.prepayId            = self.modelWX.prepayid;
        req.nonceStr            = self.modelWX.noncestr;
        req.timeStamp           = self.modelWX.timestamp;
        req.package             = self.modelWX.package;
        req.sign                = self.modelWX.sign;
        [WXApi sendReq:req];
    }
}

/**
 支付宝挑起
 */
-(void)openZFBApp{
    if (self.modelZFB) {
        [[AlipaySDK defaultService] payOrder:self.modelZFB.orderstr fromScheme:@"TingCheDao" callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic);
            
        }];
    }
}
@end
