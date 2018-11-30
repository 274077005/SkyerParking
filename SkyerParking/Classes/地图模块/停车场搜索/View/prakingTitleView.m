//
//  prakingTitleView.m
//  SkyerParking
//
//  Created by admin on 2018/8/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "prakingTitleView.h"

@implementation prakingTitleView
//设置导航栏
- (void)setBarButtonItem:(UINavigationItem*)navigationItem
{
    
    //用来放searchBar的View
    skBaseView *titleView=[[skBaseView alloc] init];
    navigationItem.titleView = titleView;
    [titleView skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(skScreenWidth-70, 30));
    }];
    
    UIImageView *image=[[UIImageView alloc] init];
    [titleView addSubview:image];
    image.image=[UIImage imageNamed:@"soushuo"];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(titleView);
        make.left.mas_equalTo(titleView).offset(10);
    }];
    
    //文本输入框
    self.text=[[UITextField alloc] init];
    self.text.placeholder=@"搜索你想要的...";
    self.text.tintColor=[UIColor blueColor];
    self.text.font=[UIFont systemFontOfSize:14];
    [titleView addSubview:self.text];
    [self.text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(titleView);
        make.right.mas_equalTo(titleView).offset(-60);
        make.left.mas_equalTo(image.mas_right).offset(10);
    }];
    //语音按钮
    self.btnVoide=[[UIButton alloc] init];
    [self.btnVoide setBackgroundImage:[UIImage imageNamed:@"yuyin"] forState:(UIControlStateNormal)];
    [titleView addSubview:self.btnVoide];
    [self.btnVoide mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.centerY.mas_equalTo(titleView);
        make.right.mas_equalTo(titleView).offset(-10);
    }];
}
@end
