//
//  skMonthCardPayViewController.m
//  SkyerParking
//
//  Created by skyer on 2018/11/16.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skMonthCardPayViewController.h"
#import "MonthCardPayViews.h"
#import "skTCDPayViewController.h"
@interface skMonthCardPayViewController ()
@property (nonatomic ,strong) MonthCardPayViews *viewMonthCardPay;
@end

@implementation skMonthCardPayViewController


- (MonthCardPayViews *)viewMonthCardPay{
    if (nil==_viewMonthCardPay) {
        _viewMonthCardPay=skXibView(@"MonthCardPayViews");
        [self.view addSubview:_viewMonthCardPay];
        [_viewMonthCardPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
            make.left.right.mas_equalTo(0);
        }];
        [_viewMonthCardPay.btnPay skSetBoardRadius:5 Width:0 andBorderColor:nil];
        @weakify(self)
        [[_viewMonthCardPay.btnPay rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            skTCDPayViewController *viewCharge=[[skTCDPayViewController alloc] init];
            viewCharge.payMoney=self.payMoney;
            viewCharge.arrSelect=self.arrSelect;
            viewCharge.arrCardList=self.arrCardList;
            viewCharge.arrPateList=self.arrPateList;
            viewCharge.indexCardType=self.indexCardType;
            //关键语句，必须有
            viewCharge.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
            viewCharge.modalPresentationStyle = UIModalPresentationOverFullScreen;
//            [viewCharge setChargeType:^(NSInteger index) {
//                NSLog(@"%ld",index);
//            }];
            
            [self presentViewController:viewCharge animated:YES completion:nil];
        }];
        _viewMonthCardPay.viewHeader.labMoney.text=[NSString stringWithFormat:@"%ld",self.payMoney];
        _viewMonthCardPay.arrPlate=self.arrPateList;
        _viewMonthCardPay.arrSelect=self.arrSelect;
        switch (self.indexCardType) {
            case 0:
            {
                _viewMonthCardPay.viewHeader.labTime.text=@"月卡";
            }
                break;
            case 1:
            {
                _viewMonthCardPay.viewHeader.labTime.text=@"季卡";
            }
                break;
            case 2:
            {
                _viewMonthCardPay.viewHeader.labTime.text=@"年卡";
            }
                break;
                
            default:
                break;
        }
        
        _viewMonthCardPay.viewHeader.labPlateName.text=self.modelOther.parkingName;
        [_viewMonthCardPay.collectionView reloadData];
    }
    return _viewMonthCardPay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewMonthCardPay];
    self.title=@"资费详情";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
