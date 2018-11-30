//
//  skMonthCardSuccessViewController.m
//  SkyerParking
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skMonthCardSuccessViewController.h"
#import "MonthCardSuccessView.h"
#import "skMonthCardMangerViewController.h"

@interface skMonthCardSuccessViewController ()

@end

@implementation skMonthCardSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MonthCardSuccessView *view=[[MonthCardSuccessView alloc] init];
    [self.view addSubview:view];
    [view.btnBackHome skSetBoardRadius:5 Width:3 andBorderColor:skColorAppMain];
    @weakify(self)
    [[view.btnBackHome rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [[view.btnMonthManger rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        skMonthCardMangerViewController *view=[[skMonthCardMangerViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
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

@end
