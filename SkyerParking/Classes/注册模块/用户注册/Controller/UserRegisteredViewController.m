//
//  UserRegisteredViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "UserRegisteredViewController.h"
#import "RegisteredView.h"
#import "RegisterModel.h"
#import "skValiMobile.h"
#import "SFHFKeychainUtils.h"
#import "skRootController.h"
#import "skJPUSHSet.h"

@interface UserRegisteredViewController ()
@property (nonatomic,strong) RegisteredView *regView;
@property (nonatomic,strong) RegisterModel *model;
@end

@implementation UserRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"注册";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor blackColor],
    NSFontAttributeName:[UIFont systemFontOfSize:17]};
    [self addRegistView];
    @weakify(self)
    [[[self skCreatBtn:@"back" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateLeft)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

- (RegisterModel *)model{
    if (nil==_model) {
        _model=[[RegisterModel alloc] init];
    }
    return _model;
}
-(RegisteredView *)regView{
    if (nil==_regView) {
        _regView=skXibView(@"RegisteredView");
        [self.view addSubview:_regView];
        [_regView.labCode skSetBoardRadius:3 Width:0 andBorderColor:[UIColor clearColor]];
        [_regView.btnRegist skSetBoardRadius:5 Width:0 andBorderColor:[UIColor clearColor]];
        [_regView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.right.left.mas_equalTo(0);
            make.height.mas_equalTo(400);
        }];
    }
    return _regView;
}
-(void)addRegistView{
    
    RAC(self.model,phone) = self.regView.txtPhone.rac_textSignal;
    RAC(self.model,code) = self.regView.txtCode.rac_textSignal;
    RAC(self.model,pwd) = self.regView.txtPwd.rac_textSignal;
    RAC(self.model,pwdAgain) = self.regView.txtPwdAgain.rac_textSignal;
    @weakify(self)
    [self.model.btnEnableSignal subscribeNext:^(NSString*  _Nullable x) {
        @strongify(self)//验证点击按钮有效
        UIButton *btn=self.regView.btnRegist;
        btn.enabled=[x boolValue];
        if ([x boolValue]) {
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:skBaseColor];
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:skBaseColorWeak];
        }
        
    }];
    
    
    [self.regView.txtPhone.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)//验证手机号码有效才能点击获取验证码
        self.regView.btnGetCode.enabled=[skValiMobile valiMobile:x];
        if ([skValiMobile valiMobile:x]) {
            [self.regView.labCode setTextColor:[UIColor whiteColor]];
            [self.regView.labCode setBackgroundColor:skBaseColor];
        }else{
            [self.regView.labCode setTextColor:[UIColor lightGrayColor]];
            [self.regView.labCode setBackgroundColor:skBaseColorWeak];
        }
    }];
    
    
    [[self.regView.btnRegist rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//注册
        [self userRegister];
        
    }];
    
    [[self.regView.btnLogin rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//登录
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [[self.regView.btnGetCode rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//获取验证码
        [self sendmsg];
    }];
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

/**
 用户注册
 */
-(void)userRegister{
    if (![skValiMobile valiMobile:self.model.phone]) {
        skToast(@"手机号码不正确");
        return;
    }
    if (![self.model.pwd isEqualToString:self.model.pwdAgain]) {
        skToast(@"两次输入密码不相同");
        return;
    }
    
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/register"];
    
    NSDictionary *parame=@{
                           @"phone":self.model.phone,
                           @"passwd":[self.model.pwd skMD5:self.model.pwd],
                           @"clientType":skClientType,
                           @"version":skAppVersion,
                           @"IMEI":[skUUID skGetDeviceIMEI],
                           @"vcode":self.model.code,
                           @"pushRegistrerId":[skJPUSHSet sharedskJPUSHSet].skRegistrationID?[skJPUSHSet sharedskJPUSHSet].skRegistrationID:@"12345"
                           };

    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        //注册成功了.保持用户信息
        [SFHFKeychainUtils storeUsername:skLoginUserName andPassword:self.model.phone forServiceName:skLoginUserName updateExisting:YES error:nil];
        
        [SFHFKeychainUtils storeUsername:skLoginUserPWD andPassword:self.model.pwd forServiceName:skLoginUserPWD updateExisting:YES error:nil];
        
        [UserLoginModel mj_objectWithKeyValues:responseObject.data];
        
        [skRootController skTabbarViewController];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 发送验证码
 */
-(void)sendmsg{
    if ([self.model.isGetCode integerValue]==0) {
        [skParameDealMethod skInitMudlesWithInterface:@"/intf/msgSmsCode/sendsms"];
        NSDictionary *parame=@{
                               @"phone":self.model.phone,
                               @"smsType":@"0",//0是注册
                               @"clientType":skClientType,
                               };
        
        [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
            self.model.isGetCode=@"1";
            [self sendSuccess];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}

-(void)sendSuccess{
    __block int index=60;
    @weakify(self)
    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] take:index] subscribeNext:^(id x) {
        @strongify(self)
        index --;
        if (index>0) {
            [self.regView.labCode setText:[NSString stringWithFormat:@"%d秒后尝试",index]];
        }else{
            [self.regView.labCode setText:@"获取验证码"];
            self.model.isGetCode=@"0";
        }
    }];
}
@end
