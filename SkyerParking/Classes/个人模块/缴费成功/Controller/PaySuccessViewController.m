//
//  PaySuccessViewController.m
//  SkyerParking
//
//  Created by admin on 2018/9/10.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "PaySuccessViews.h"

@interface PaySuccessViewController ()
@property (nonatomic,strong) PaySuccessViews *viewPay;
@end

@implementation PaySuccessViewController

-(PaySuccessViews *)viewPay{
    if (nil==_viewPay) {
        _viewPay=skXibView(@"PaySuccessViews");
        [_viewPay.btnBackHome skSetBoardRadius:5 Width:2 andBorderColor:skColorAppMain];
        [self.view addSubview:_viewPay];
        @weakify(self)
        [[_viewPay.btnBackHome rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
    return _viewPay;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewPay];
    self.title=@"缴费成功";
    [[[self skCreatBtn:@"backbai66" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateLeft)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
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

@end
