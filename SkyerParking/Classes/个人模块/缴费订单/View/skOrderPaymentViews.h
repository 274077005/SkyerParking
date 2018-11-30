//
//  skOrderPaymentView.h
//  SkyerParking
//
//  Created by admin on 2018/7/23.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface skOrderPaymentViews : UIView
@property (weak, nonatomic) IBOutlet UIView *labCount;
@property (weak, nonatomic) IBOutlet UIView *imageOK;
@property (weak, nonatomic) IBOutlet UIView *labPraking;
@property (weak, nonatomic) IBOutlet UILabel *labNumber;
@property (weak, nonatomic) IBOutlet UILabel *labInter;
@property (weak, nonatomic) IBOutlet UILabel *labChargeRule;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UIButton *btnOut;
@property (weak, nonatomic) IBOutlet UIImageView *imageIsPay;
@property (weak, nonatomic) IBOutlet UILabel *labTimefree;
@property (weak, nonatomic) IBOutlet UILabel *labPlName;

@end
