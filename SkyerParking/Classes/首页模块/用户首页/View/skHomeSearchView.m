//
//  skHomeSearchView.m
//  SkyerParking
//
//  Created by admin on 2018/7/6.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skHomeSearchView.h"
#import "ParkingSearchViewController.h"

@implementation skHomeSearchView
//设置导航栏
+ (void)setBarButtonItem:(UINavigationItem*)navigationItem
{
    
    //用来放searchBar的View
    skBaseView *titleView=[[skBaseView alloc] init];
    
    [titleView skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(skScreenWidth-140/2, 30));
    }];
    
    //    //文字描述
    UILabel *labSearch=[[UILabel alloc] init];
    labSearch.text=@"搜索停车场、路线";
    labSearch.textColor=[UIColor lightGrayColor];
    labSearch.font=[UIFont systemFontOfSize:14];
    [titleView addSubview:labSearch];
    labSearch.textAlignment=1;
    [labSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView.mas_top);
        make.left.mas_equalTo(titleView.mas_left);
        make.right.mas_equalTo(titleView.mas_right);
        make.bottom.mas_equalTo(titleView.mas_bottom);
    }];
    
    //覆盖在上面的按钮
    UIButton *btnGo=[[UIButton alloc] initWithFrame:titleView.bounds];
    [titleView addSubview:btnGo];
    
    [btnGo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(titleView);
        make.left.right.mas_equalTo(titleView);
    }];
    navigationItem.titleView = titleView;
    @weakify(self)
    [[btnGo rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        ParkingSearchViewController *skNear = [[ParkingSearchViewController alloc] init];
        [skVSView.navigationController pushViewController:skNear animated:YES];
    }];
    
}
@end
