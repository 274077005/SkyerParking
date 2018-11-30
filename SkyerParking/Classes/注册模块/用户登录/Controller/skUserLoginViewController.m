//
//  skUserLoginViewController.m
//  SkyerParking
//
//  Created by admin on 2018/6/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skUserLoginViewController.h"
#import "UIView+Shadow.h"
#import "UserLoginView.h"
#import "UserLoginModel.h"
#import "UserRegisteredViewController.h"
#import "skValiMobile.h"
#import "skTabarViewController.h"
#import "AppDelegate.h"
#import "SFHFKeychainUtils.h"
#import "skChangePWDViewController.h"
#import "skGetNetConfig.h"
#import "skRootController.h"
#import "skModShareConfig.h"
#import "skJPUSHSet.h"
#import "userLoginDispose.h"
#import "ShareLoginViewController.h"
#import "ShareUserModel.h"


@interface skUserLoginViewController ()
@property (nonatomic,strong) UserLoginView *loginView;
@property (nonatomic,strong) userLoginDispose *loginDispose;
@end

@implementation skUserLoginViewController

-(userLoginDispose *)loginDispose{
    if (nil==_loginDispose) {
        _loginDispose=[[userLoginDispose alloc] init];
        [_loginDispose setUp];
    }
    return _loginDispose;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    [[[self skCreatBtn:@"backbai66" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateLeft)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self addLoginView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self rememberUser];
//    //如果有配置文件就直接更新token
//    if (skMoModel.systemId.length>0) {
//        [skGetNetConfig skAPPLoginUpdateToken];
//    }else{//没有配置文件就获取
//        [skGetNetConfig skAppStartApply:nil failure:nil];
//    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can b recreated.
}
-(UserLoginView *)loginView{
    if (nil==_loginView) {
        _loginView=skXibView(@"UserLoginView");
        
        @weakify(self)
        [self.view addSubview:_loginView];
        [_loginView.btnLogin skSetBoardRadius:5 Width:1 andBorderColor:[UIColor clearColor]];
        [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuide);
            make.right.left.bottom.mas_equalTo(0);
        }];
        
        
        [[_loginView.btnShareQQlogin  rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)//SSDKPlatformTypeWechat
            [skModShareConfig skGetShare:SSDKPlatformTypeQQ userInfo:^(SSDKUser * _Nullable ShareUser) {
                
                [self bizMemberThirdLogin:ShareUser loginType:@"qq"];
                
            }];
        }];
        [[_loginView.btnShareWechatlogin  rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            @strongify(self)//SSDKPlatformTypeWechat
            [skModShareConfig skGetShare:SSDKPlatformTypeWechat userInfo:^(SSDKUser * _Nullable ShareUser) {
                
                [self bizMemberThirdLogin:ShareUser loginType:@"wx"];
                
            }];
        }];
    }
    return _loginView;
}
-(void)bizMemberThirdLogin:(SSDKUser *)ShareUser loginType:(NSString *)type{
    
    
    
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMemberThirdLogin/validateThirdlogin"];
    NSDictionary *parame=@{@"unionid":ShareUser.uid,
                           @"clientType":skClientType,
                           @"version":skAppVersion,
                           @"IMEI":[skUUID skGetDeviceIMEI],
                           @"loginType":type,
                           @"openid":ShareUser.uid,
                           @"headimgurl":ShareUser.icon?ShareUser.icon:@"",
                           @"nickname":ShareUser.nickname?ShareUser.nickname:@"",
                           @"pushRegistrerId":[skJPUSHSet sharedskJPUSHSet].skRegistrationID?[skJPUSHSet sharedskJPUSHSet].skRegistrationID:@"12345"
                           };
    
    
    
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        
        if (responseObject.returnCode==0) {//已经绑定直接登录
            UserLoginModel *model=[UserLoginModel mj_objectWithKeyValues:responseObject.data];
            [skRootController skTabbarViewController];
        }else if (responseObject.returnCode==1001){//没有绑定,跳转验证码
            ShareLoginViewController *view=[[ShareLoginViewController alloc] init];
            ShareUserModel *modelShare=[ShareUserModel mj_objectWithKeyValues:responseObject.data];
            
            view.modelUser=modelShare;
            [self.navigationController pushViewController:view animated:YES];
        }else{

        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark - 获取原始密码
-(void)rememberUser{
    NSString *userName=[SFHFKeychainUtils getPasswordForUsername:skLoginUserName andServiceName:skLoginUserName error:nil];
    NSString *userPWD=[SFHFKeychainUtils getPasswordForUsername:skLoginUserPWD andServiceName:skLoginUserPWD error:nil];
    self.loginView.txtPhone.text=userName;
    self.loginView.txtPwd.text=userPWD;
    self.loginDispose.loginPhone=userName;
    self.loginDispose.loginPwd=userPWD;
}
#pragma mark - 界面处理
-(void)addLoginView{
    
    RAC(self.loginDispose,loginPhone)=self.loginView.txtPhone.rac_textSignal;
    RAC(self.loginDispose,loginPwd)=self.loginView.txtPwd.rac_textSignal;
    
    @weakify(self )
    
    [self.loginDispose.btnEnableSignal subscribeNext:^(NSString*  _Nullable x) {
        @strongify(self)//验证点击按钮有效
        UIButton *btn=self.loginView.btnLogin;
        btn.enabled=[x boolValue];
        if ([x boolValue]) {
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:skBaseColor];
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:skBaseColorWeak];
        }
    }];
    
    [[self.loginView.btnLogin rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self )//登录按钮
        [self login];
    }];
    [[self.loginView.btnRegister rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self )//注册
        UserRegisteredViewController *regist=[[UserRegisteredViewController alloc] init];
        skBaseNavViewController *registNav=[[skBaseNavViewController alloc] initWithRootViewController:regist];
        [self presentViewController:registNav animated:YES completion:nil];
    }];
    [[self.loginView.btnForgetPwd rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self )//忘记密码
        skChangePWDViewController *view=[[skChangePWDViewController alloc] init];
        skBaseNavViewController *viewNav=[[skBaseNavViewController alloc] initWithRootViewController:view];
        [self presentViewController:viewNav animated:YES completion:nil];
    }];
    
    
}
#pragma mark - 获取登录
-(void)login{
    if (![skValiMobile valiMobile:self.loginDispose.loginPhone]) {
        skToast(@"手机号码错误");
        return;
    }
    if (self.loginDispose.loginPwd.length==0) {
        skToast(@"密码不能为空");
        return;
    }
    
    
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/login"];
    
    NSDictionary *parame=@{@"phone":self.loginDispose.loginPhone,
                           @"passwd":[self.loginDispose.loginPwd skMD5:self.loginDispose.loginPwd],
                           @"clientType":skClientType,
                           @"version":skAppVersion,
                           @"IMEI":[skUUID skGetDeviceIMEI],
                           @"pushRegistrerId":[skJPUSHSet sharedskJPUSHSet].skRegistrationID?[skJPUSHSet sharedskJPUSHSet].skRegistrationID:@"12345"
                           };
    
    
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        
        if (responseObject.returnCode==0) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:skAutoLogin];
            
            UserLoginModel *model=[UserLoginModel mj_objectWithKeyValues:responseObject.data];
            
            [SFHFKeychainUtils storeUsername:skLoginUserName andPassword:self.loginDispose.loginPhone forServiceName:skLoginUserName updateExisting:YES error:nil];
            
            [SFHFKeychainUtils storeUsername:skLoginUserPWD andPassword:self.loginDispose.loginPwd forServiceName:skLoginUserPWD updateExisting:YES error:nil];
            
            [skRootController skTabbarViewController];
        
        }
        
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
