//
//  TCBPayViews.h
//  SkyerParking
//
//  Created by skyer on 2018/11/16.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCBPayViews : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *labPayMoney;
@property (weak, nonatomic) IBOutlet UIView *viewTableview;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;

@end

NS_ASSUME_NONNULL_END
