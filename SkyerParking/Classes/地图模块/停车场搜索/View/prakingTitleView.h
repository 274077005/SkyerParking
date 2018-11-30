//
//  prakingTitleView.h
//  SkyerParking
//
//  Created by admin on 2018/8/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface prakingTitleView : NSObject
@property (nonatomic,strong) UITextField *text;
@property (nonatomic,strong) UIButton *btnVoide;
- (void)setBarButtonItem:(UINavigationItem*)navigationItem;
@end
