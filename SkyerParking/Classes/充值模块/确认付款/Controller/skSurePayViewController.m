//
//  skSurePayViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/24.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skSurePayViewController.h"
#import "surePayView.h"
#import "surePayModel.h"
#import "skZFBPayModel.h"
#import "skWXPayModel.h"
#import "WXApiManager.h"
#import "WXApiRequestHandler.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "skZFUResult.h"

@interface skSurePayViewController ()<WXApiManagerDelegate>
@property (nonatomic,strong) surePayView *viewSure;
@property (nonatomic,assign) PayFor payForSelect;
@property (nonatomic,strong) surePayModel *model;
@property (nonatomic,strong) skZFBPayModel *modelZFB;
@property (nonatomic,strong) skWXPayModel *modelWX;
@end

@implementation skSurePayViewController

-(surePayView *)viewSure{
    if (nil==_viewSure) {
        _viewSure=skXibView(@"surePayView");
        [self.view addSubview:_viewSure];
        [_viewSure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(290);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideBottom);
        }];
        @weakify(self)
        [[_viewSure.btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//快速充值
            [self getOrderInfo];
        }];
        [[_viewSure.btnCancel rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//取消充值
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [[_viewSure.btnWXSelect rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//微信充值
            self.payForSelect=PayForWX;
            [self btnSelectImage];
        }];
        [[_viewSure.btnZFBSelect rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//支付宝充值
            self.payForSelect=PayForZFB;
            [self btnSelectImage];
        }];
        
        [_viewSure skSetData:self.model];
    }
    return _viewSure;
}

-(void)btnSelectImage{
    if (self.payForSelect==PayForWX) {
        [_viewSure.btnWXSelect setBackgroundImage:[UIImage imageNamed:@"gou"] forState:(UIControlStateNormal)];
        [_viewSure.btnZFBSelect setBackgroundImage:[UIImage imageNamed:@"yuanquan"] forState:(UIControlStateNormal)];
    }else{
        [_viewSure.btnWXSelect setBackgroundImage:[UIImage imageNamed:@"yuanquan"] forState:(UIControlStateNormal)];
        [_viewSure.btnZFBSelect setBackgroundImage:[UIImage imageNamed:@"gou"] forState:(UIControlStateNormal)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model=[surePayModel mj_objectWithKeyValues:self.dicPay];
    NSLog(@"带过来的数据%@",_dicPay);
    [self viewSure];
    [self initWX];
    [self initZFU];
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
        
        [self dismissViewControllerAnimated:YES completion:^{
            skToast(@"充值成功");
        }];
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
        [self dismissViewControllerAnimated:YES completion:^{
            skToast(@"充值成功");
        }];
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
-(void)getOrderInfo{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/pay/getOrderInfo"];
    NSString *bizType =self.typePayFor==rechargeTypeTCBI?@"T":@"R";
    NSString *roId =self.model.roId;
    NSString *payType =self.payForSelect==0?@"wxPay":@"aliPay";
    
    NSDictionary *parame=@{@"bizType":bizType,
                           @"roId":roId,
                           @"transactionType":@"APP",
                           @"payType":payType,
                           @"userId":[NSNumber numberWithInt:[skUser.memberId intValue]]
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        
        NSDictionary *dic=responseObject.data;
        
        if (self.payForSelect==PayForWX) {
            self.modelWX=[skWXPayModel mj_objectWithKeyValues:dic];
            [self openWXAPP];
        }else{
            self.modelZFB=[skZFBPayModel mj_objectWithKeyValues:dic];
            [self openZFBApp];
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
