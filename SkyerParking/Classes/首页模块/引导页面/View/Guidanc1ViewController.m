//
//  Guidanc1ViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "Guidanc1ViewController.h"

@interface Guidanc1ViewController ()

@end

@implementation Guidanc1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView=[[UIImageView alloc] init];
    [imageView setContentMode:(UIViewContentModeCenter)];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
    UIImage *image=[UIImage imageNamed:@"yindaoye2"];
    imageView.image=image;
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
