//
//  ShareLoginViewController.m
//  SkyerParking
//
//  Created by admin on 2018/9/6.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ShareLoginViewController.h"
#import "ShareLoginViews.h"
#import "ShareLoginModel.h"
#import "skValiMobile.h"
#import "skJPUSHSet.h"
#import "skRootController.h"
@interface ShareLoginViewController ()

@property (nonatomic,strong) ShareLoginViews *viewLogin;
@property (nonatomic,strong) ShareLoginModel *model;

@end

@implementation ShareLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"绑定账户";
    
    @weakify(self)
    [[[self skCreatBtn:@"back" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateLeft)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self setData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor blackColor],
      NSFontAttributeName:[UIFont systemFontOfSize:17]};
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = skColorAppMain;
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:17]};
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(ShareLoginViews *)viewLogin{
    if (nil==_viewLogin) {
        _viewLogin=skXibView(@"ShareLoginViews");
        [self.view addSubview:_viewLogin];
        [_viewLogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.height.mas_equalTo(200);
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.right.left.mas_equalTo(0);
        }];
        
    }
    return _viewLogin;
}

- (ShareLoginModel *)model{
    if (nil==_model) {
        _model=[[ShareLoginModel alloc] init];
    }
    return _model;
}

-(void)setData{
    RAC(self.model,phone)=self.viewLogin.txtPhone.rac_textSignal;
    RAC(self.model,code)=self.viewLogin.txtCode.rac_textSignal;
    
    @weakify(self)
    [self.model.btnEnableSignal subscribeNext:^(NSString*  _Nullable x) {
        @strongify(self)//验证点击按钮有效
        NSLog(@"验证点击按钮%@",x);
        UIButton *btn=self.viewLogin.btnChange;
        btn.enabled=[x boolValue];
        if ([x boolValue]) {
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:skBaseColor];
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:skBaseColorWeak];
        }
    }];
    
    [[self.viewLogin.btnCode rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//获取验证码
        [self sendmsg];
    }];
    
    
    [[self.viewLogin.btnChange rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//修改密码
        [self validateBindingPhone];
    }];
    [self.viewLogin.txtPhone.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)//验证手机号码有效才能点击获取验证码
        
        self.viewLogin.btnCode.enabled=[skValiMobile valiMobile:x];
        
        if ([skValiMobile valiMobile:x]) {
            [self.viewLogin.labCode setTextColor:[UIColor whiteColor]];
            [self.viewLogin.labCode setBackgroundColor:skBaseColor];
        }else{
            [self.viewLogin.labCode setTextColor:[UIColor lightGrayColor]];
            [self.viewLogin.labCode setBackgroundColor:skBaseColorWeak];
        }
        
    }];
}


/**
 发送验证码
 */
-(void)sendmsg{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/msgSmsCode/sendsms"];
    NSDictionary *parame=@{
                           @"phone":self.model.phone,
                           @"smsType":@"4",//1重置密码
                           @"clientType":skClientType,
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        if (responseObject.returnCode==0) {
            [self sendSuccess];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
-(void)sendSuccess{
    __block int index=60;
    if (!self.model.isGetCode) {
        self.model.isGetCode=YES;
        @weakify(self)
        [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] take:index] subscribeNext:^(id x) {
            @strongify(self)
            index --;
            if (index>0) {
                [self.viewLogin.labCode setText:[NSString stringWithFormat:@"%d秒后尝试",index]];
            }else{
                [self.viewLogin.labCode setText:@"获取验证码"];
                self.model.isGetCode=NO;
            }
        }];
    }
    
}


/**
 绑定直接登录到首页
 */
-(void)validateBindingPhone{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMemberThirdLogin/validateBindingPhone"];
    NSDictionary *parame=@{@"unionid":self.modelUser.unionid,
                           @"clientType":skClientType,
                           @"version":skAppVersion,
                           @"IMEI":[skUUID skGetDeviceIMEI],
                           @"loginType":self.modelUser.loginType,
                           @"openid":self.modelUser.openid,
                           @"headimgurl":self.modelUser.headimgurl,
                           @"nickname":self.modelUser.nickname,
                           @"pushRegistrerId":[skJPUSHSet sharedskJPUSHSet].skRegistrationID?[skJPUSHSet sharedskJPUSHSet].skRegistrationID:@"12345",
                           @"phone":self.model.phone,
                           @"code":self.model.code
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        if (responseObject.returnCode==0) {
            UserLoginModel *model=[UserLoginModel mj_objectWithKeyValues:responseObject.data];
            [skRootController skTabbarViewController];
        }else{
            skToast(@"绑定失败");
        }
        
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
