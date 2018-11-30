//
//  skOrderPaymentViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/23.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skOrderPaymentViewController.h"
#import "skOrderPaymentViews.h"
#import "skPayParkOutViewController.h"
#import "skOrderParkModel.h"
#import "NSString+skString.h"

@interface skOrderPaymentViewController ()
@property (nonatomic,strong) skOrderPaymentViews *viewOrder;
//@property (nonatomic,strong) skOrderParkModel *modelData;

@end

@implementation skOrderPaymentViewController

- (skOrderPaymentViews *)viewOrder{
    if (nil==_viewOrder) {
        _viewOrder=skXibView(@"skOrderPaymentViews");
        [self.view addSubview:_viewOrder];
        [_viewOrder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_offset(0);
        }];
        @weakify(self)
        [[_viewOrder.btnOut rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.modelOther.payMoney>0) {
                skPayParkOutViewController *view=[[skPayParkOutViewController alloc] init];
                view.model=self.modelOther;
                [self.navigationController pushViewController:view animated:YES];
            }
            
        }];
    }
    return _viewOrder;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"计费中";
    
    [self setViewData:self.modelOther];
}
-(void)viewWillAppear:(BOOL)animated{
//    [self bizParkingOrder];
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

/**
 获取订单详情
 */
//-(void)bizParkingOrder{
//    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizParkingOrder/orderDetail"];
//    NSDictionary *parame=@{@"gid":self.model.payOrderId};
//
//    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
//        if (responseObject.returnCode==0) {
//
//            self.modelData=[skOrderParkModel mj_objectWithKeyValues:responseObject.data];
//            [self setViewData:self.modelData];
//
//        }
//    } failure:^(NSError * _Nullable error) {
//
//    }];
//}

-(void)setViewData:(parkOrderModel *)model{
    
    self.viewOrder.imageIsPay.hidden=!model.payStat;
    
    self.viewOrder.labTimefree.text=[NSString stringWithFormat:@"%ld",model.payMoney/100];
    
    self.viewOrder.labPlName.text=model.parkingName;
    
    NSString *intTime=[NSString stringWithFormat:@"%ld",model.inTime];
    
    self.viewOrder.labInter.text=[intTime cStringFromTimestamp:intTime];
    
    self.viewOrder.labNumber.text=[NSString stringWithFormat:@"车牌号:%@",model.plate];
    
    self.viewOrder.labChargeRule.text=model.feeRuleDesc;
    
    NSInteger timeLong=model.outTime-model.inTime;
    
    self.viewOrder.labTime.text=[self updateTimeForRow:timeLong];
    
    if (model.payMoney==0) {
        self.viewOrder.btnOut.hidden=YES;
    }else{
        self.viewOrder.btnOut.hidden=model.payStat;
    }
    
}

- (NSString *)updateTimeForRow:(NSInteger)timeInt {
    
    NSInteger miao=timeInt%60;//显示的秒
    
    NSInteger fen=timeInt/60;//分钟数
    
    NSInteger fenShow=fen%60;//显示的分钟数
    
    NSInteger shi=fen/60;
    NSInteger shiShow=shi%60;
    
    NSInteger tian=shi/60;
    NSInteger tianShow=tian%24;
    
    NSString *time=[NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒",tianShow,shiShow,fenShow,miao];
    
    return time;
}
@end
