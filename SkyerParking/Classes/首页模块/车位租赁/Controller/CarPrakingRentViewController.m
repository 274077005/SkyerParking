//
//  RentViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/27.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "CarPrakingRentViewController.h"

@interface CarPrakingRentViewController ()

@end

@implementation CarPrakingRentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"扫码支付";
    UIImageView *view=[[UIImageView alloc] init];
    view.image=[UIImage imageNamed:@"shengji"];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.size.mas_equalTo(CGSizeMake(300, 175));

        make.centerX.mas_equalTo(self.view.mas_centerX);
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
