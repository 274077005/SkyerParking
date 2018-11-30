//
//  AgreementViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "AgreementViewController.h"
#import "AgreementViews.h"

@interface AgreementViewController ()
@property (nonatomic,strong) AgreementViews *viewAgree;
@end

@implementation AgreementViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _viewAgree=skXibView(@"AgreementViews");
    [self.view addSubview:_viewAgree];
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
