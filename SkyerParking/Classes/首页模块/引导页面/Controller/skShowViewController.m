//
//  skShowViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skShowViewController.h"

@interface skShowViewController ()

@end

@implementation skShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView=[[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView setContentMode:(UIViewContentModeScaleToFill)];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 500));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    UIImage *image=[UIImage imageNamed:@"shanping"];
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
