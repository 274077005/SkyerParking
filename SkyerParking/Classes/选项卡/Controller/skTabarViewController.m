//
//  skTabarViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skTabarViewController.h"
#import "skHomeViewController.h"//用户首页
#import "skNearViewController.h"//智能地图
#import "skUserInfoViewController.h"//用户信息

@interface skTabarViewController ()

@end

@implementation skTabarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTabarView{
    //首页
    skHomeViewController *skHome=[[skHomeViewController alloc] init];
    skBaseNavViewController *skHomeNav = [[skBaseNavViewController alloc] initWithRootViewController:skHome];
    //附近
    skNearViewController *skNear = [[skNearViewController alloc] init];
    skBaseNavViewController *skNearNav = [[skBaseNavViewController alloc] initWithRootViewController:skNear];
    //个人中心
    skUserInfoViewController *skUserInfo = [[skUserInfoViewController alloc] init];
    skBaseNavViewController *skUserInfoNav = [[skBaseNavViewController alloc] initWithRootViewController:skUserInfo];
    //设置底部tabbar
    self.viewControllers = @[skHomeNav,skNearNav,skUserInfoNav];
    
    UITabBar *tabBar = self.tabBar;
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    //    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    tabBarItem1.title=@"首页";
    tabBarItem1.image=[UIImage imageNamed:@"shouye2"];
    tabBarItem1.selectedImage=[UIImage imageNamed:@"shouye"];
    
    tabBarItem2.title=@"附近";
    tabBarItem2.image=[UIImage imageNamed:@"fujin2"];
    tabBarItem2.selectedImage=[UIImage imageNamed:@"fujin"];
    
    tabBarItem3.title=@"我的";
    tabBarItem3.image=[UIImage imageNamed:@"wode2"];
    tabBarItem3.selectedImage=[UIImage imageNamed:@"wode"];
    
    
    //    tabBarItem4.title=@"测试";
    //    tabBarItem4.image=[UIImage imageNamed:@"my"];
    //    tabBarItem4.selectedImage=[UIImage imageNamed:@"myhui"];
}

@end
