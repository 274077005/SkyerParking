//
//  changePWDView.h
//  SkyerParking
//
//  Created by admin on 2018/7/17.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changePWDView : UIView
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPWD;

@property (weak, nonatomic) IBOutlet UILabel *labCode;

@property (weak, nonatomic) IBOutlet UIButton *btnChange;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;

@end
