//
//  skTCDPayViewController.m
//  SkyerParking
//
//  Created by skyer on 2018/11/16.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skTCDPayViewController.h"
#import "TCBPayViews.h"
#import "TCBPayTableViewCell.h"
#import "TCBIRechargeViewController.h"
#import "cardLiseModel.h"
#import "plateListModel.h"
#import "PaySuccessViewController.h"
#import "skMonthCardSuccessViewController.h"
#import "WXApiRequestHandler.h"
#import <AlipaySDK/AlipaySDK.h>
#import "skZFBPayModel.h"
#import "skWXPayModel.h"
#import "WXApi.h"
#import "APOrderInfo.h"
#import "skZFUResult.h"
#import "WXApiManager.h"

@interface skTCDPayViewController ()<WXApiManagerDelegate>
@property (nonatomic ,strong) TCBPayViews *viewTCBPay;
@property (nonatomic ,assign) NSInteger indexSelect;
@property (nonatomic,strong) skZFBPayModel *modelZFB;
@property (nonatomic,strong) skWXPayModel *modelWX;
@end

@implementation skTCDPayViewController
- (TCBPayViews *)viewTCBPay{
    if (nil==_viewTCBPay) {
        _viewTCBPay=skXibView(@"TCBPayViews");
        [self.view addSubview:_viewTCBPay];
        [_viewTCBPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(skScreenWidth, 350));
            make.left.right.bottom.mas_equalTo(0);
        }];
        [_viewTCBPay.btnPay skSetBoardRadius:5 Width:0 andBorderColor:nil];
        _viewTCBPay.labPayMoney.text=[NSString stringWithFormat:@"%ld",self.payMoney];
        @weakify(self)
        [[_viewTCBPay.btnBack rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [[_viewTCBPay.btnPay rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self payParkCard];
        }];
        
    }
    return _viewTCBPay;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewTCBPay];
    [self addTableView];
    [self initWX];
    [self initZFU];;
}
-(void)addTableView{
    [self.viewTCBPay.viewTableview addSubview:self.tableView];
    self.tableView.frame=self.viewTCBPay.viewTableview.bounds;
    [self.tableView reloadData];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"TCBPayTableViewCell";
    TCBPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"TCBPayTableViewCell");
        @weakify(self)
        [[cell.btnCharge rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES completion:^{
                TCBIRechargeViewController *view=[[TCBIRechargeViewController alloc] init];
                [self.navigationController pushViewController:view animated:YES];
            }];
        }];
    }
    if (indexPath.row==self.indexSelect) {
        cell.imageSelect.image=[UIImage imageNamed:@"gou"];
    }else{
        cell.imageSelect.image=[UIImage imageNamed:@"yuanquan"];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.imageHeader.image=[UIImage imageNamed:@"tingchebichongzhi"];
            cell.btnCharge.hidden=NO;
            cell.labTitle.text=@"停车币支付";
        }
            break;
        case 1:
        {
            cell.imageHeader.image=[UIImage imageNamed:@"zhifubaochongzhi"];
//            cell.btnCharge.hidden=NO;
            cell.labTitle.text=@"支付宝支付";
        }
            break;
        case 2:
        {
            cell.imageHeader.image=[UIImage imageNamed:@"weixinchongzhi"];
            //            cell.btnCharge.hidden=NO;
            cell.labTitle.text=@"微信支付";
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


-(void)payParkCard{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/pay/payParkCard"];
    NSString *payType;
    switch (self.indexSelect) {
        case 0:
        {
            payType=@"3";
        }
            break;
        case 1:
        {
            payType=@"1";
        }
            break;
        case 2:
        {
            payType=@"2";
        }
            break;
            
        default:
            break;
    }
    
    cardLiseModel *model=[self.arrCardList objectAtIndex:self.indexCardType];
    
    NSMutableArray *arrPlate=[[NSMutableArray alloc] init];
    
    for (int i = 0;  i <self.arrSelect.count; ++i) {
        NSString *select=[self.arrSelect objectAtIndex:i];
        plateListModel *modelPate=[self.arrPateList objectAtIndex:[select intValue]];
        [arrPlate addObject:modelPate.plateCardNo];
    }
    
    NSDictionary *parame=@{@"memberId":skUser.memberId,
                           @"payType":payType,
                           @"cardId":model.ids,
                           @"money":[NSNumber numberWithInteger:1],
                           @"transactionType":@"APP",
                           @"plateList":arrPlate
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        if (responseObject.returnCode==0) {
            switch (self.indexSelect) {
                case 0:
                {
                    skMonthCardSuccessViewController *view=[[skMonthCardSuccessViewController alloc] init];
                    [self.navigationController pushViewController:view animated:YES];
                }
                    break;
                case 2://微信
                {
                    self.modelWX=[skWXPayModel mj_objectWithKeyValues:responseObject.data];
                    [self openWXAPP];
                }
                    break;
                case 1://支付宝
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
@end
