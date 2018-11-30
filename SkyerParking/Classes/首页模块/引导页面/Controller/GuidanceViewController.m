//
//  GuidanceViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "GuidanceViewController.h"
#import "Guidanc0ViewController.h"
#import "Guidanc1ViewController.h"
#import "Guidanc2ViewController.h"


@interface GuidanceViewController ()

@end

@implementation GuidanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addViews];
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
-(void)addViews{
    
    Guidanc0ViewController *view0=[[Guidanc0ViewController alloc] init];
    Guidanc1ViewController *view1=[[Guidanc1ViewController alloc] init];
    Guidanc2ViewController *view2=[[Guidanc2ViewController alloc] init];
    NSArray *arrViews=@[view0,view1,view2];
    
    SkPageViews *views=[[SkPageViews alloc] initWithFrame:self.view.bounds andArrViews:arrViews andSelecetIndex:0];
    
    [self.view addSubview:views];
}
@end
