//
//  ChargeTypeViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ChargeTypeViewController.h"
#import "ChargeTypeSelectView.h"
#import "BalanceRechargeViewController.h"
#import "TCBIRechargeViewController.h"


@interface ChargeTypeViewController ()
@property (nonatomic,strong) ChargeTypeSelectView *viewCharge;
@end

@implementation ChargeTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewCharge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(ChargeTypeSelectView *)viewCharge{
    if (nil==_viewCharge) {
        _viewCharge=skXibView(@"ChargeTypeSelectView");
        [self.view addSubview:_viewCharge];
        [_viewCharge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_offset(0);
        }];
        [_viewCharge.viewCharge skSetBoardRadius:5 Width:0 andBorderColor:[UIColor whiteColor]];
        @weakify(self)
        [[_viewCharge.btnBalance rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            self.chargeType(0);//余额是0
            [self dismissViewControllerAnimated:NO completion:^{
                BalanceRechargeViewController *balanceView=[[BalanceRechargeViewController alloc] init];
                [skVSView.navigationController pushViewController:balanceView animated:YES];
            }];
        }];
        [[_viewCharge.btnTCBI rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            self.chargeType(1);//停车币是1
            [self dismissViewControllerAnimated:NO completion:^{
                TCBIRechargeViewController *TCBIView=[[TCBIRechargeViewController alloc] init];
                [skVSView.navigationController pushViewController:TCBIView animated:YES];
            }];
        }];
    }
    return _viewCharge;
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
