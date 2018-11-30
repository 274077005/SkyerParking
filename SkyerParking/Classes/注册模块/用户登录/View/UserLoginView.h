//
//  UserLoginView.h
//  SkyerParking
//
//  Created by admin on 2018/7/12.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLoginView : UIView
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnForgetPwd;

@property (weak, nonatomic) IBOutlet UIButton *btnShareWechatlogin;
@property (weak, nonatomic) IBOutlet UIButton *btnShareQQlogin;

@end
