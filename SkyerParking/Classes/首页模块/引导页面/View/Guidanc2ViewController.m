//
//  Guidanc2ViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "Guidanc2ViewController.h"
#import "skRootController.h"

@interface Guidanc2ViewController ()

@end

@implementation Guidanc2ViewController

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
    UIImage *image=[UIImage imageNamed:@"yindaoye3"];
    imageView.image=image;
    
    
    UIButton *btn=[[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(skScreenWidth, skScreenHeight/2.0));
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        
    }];
    [[btn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {

        [[NSUserDefaults standardUserDefaults] setObject:skAppVersion forKey:skAPPVersionSave];
        
        [skRootController skTabbarViewController];
        
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
