//
//  skChangePWDViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/17.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skChangePWDViewController.h"
#import "changePWDView.h"
#import "changeModel.h"
#import "skValiMobile.h"
#import "UIView+skBoard.h"
#import "skUserLoginViewController.h"

@interface skChangePWDViewController ()
@property (nonatomic,strong) changePWDView *viewChange;
@property (nonatomic,strong) changeModel *model;
@end

@implementation skChangePWDViewController

-(changePWDView *)viewChange{
    if (nil==_viewChange) {
        _viewChange=skXibView(@"changePWDView");
        [self.view addSubview:_viewChange];
        [_viewChange mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.right.left.mas_equalTo(0);
            make.height.mas_equalTo(300);
        }];
    }
    return _viewChange;
}
-(changeModel *)model
{
    if (nil==_model) {
        _model=[[changeModel alloc] init];
    }
    return _model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"重置密码";
    @weakify(self)
    [[[self skCreatBtn:@"backbai66" btnTitleOrImage:(btntypeImage) btnLeftOrRight:(btnStateLeft)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (skUser.phone.length>0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
    [self setData];
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
-(void)setData{
    RAC(self.model,phone)=self.viewChange.txtPhone.rac_textSignal;
    RAC(self.model,code)=self.viewChange.txtCode.rac_textSignal;
    RAC(self.model,pwdnew)=self.viewChange.txtNewPWD.rac_textSignal;
    self.model.phone=skUser.phone;
    
    @weakify(self)
    [self.model.btnEnableSignal subscribeNext:^(NSString*  _Nullable x) {
        @strongify(self)//验证点击按钮有效
        UIButton *btn=self.viewChange.btnChange;
        btn.enabled=[x boolValue];
        if ([x boolValue]) {
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:skBaseColor];
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            [btn setBackgroundColor:skBaseColorWeak];
        }
    }];
    
    [[self.viewChange.btnCode rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//获取验证码
        [self sendmsg];
    }];
    
    
    [[self.viewChange.btnChange rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)//修改密码
        [self updateLoginPwd];
    }];
    [self.viewChange.txtPhone.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)//验证手机号码有效才能点击获取验证码
        
        self.viewChange.btnCode.enabled=[skValiMobile valiMobile:x];
        if ([skValiMobile valiMobile:x]) {
            [self.viewChange.labCode setTextColor:[UIColor whiteColor]];
            [self.viewChange.labCode setBackgroundColor:skBaseColor];
        }else{
            [self.viewChange.labCode setTextColor:[UIColor lightGrayColor]];
            [self.viewChange.labCode setBackgroundColor:skBaseColorWeak];
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
                           @"smsType":@"1",//1重置密码
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
                [self.viewChange.labCode setText:[NSString stringWithFormat:@"%d秒后尝试",index]];
            }else{
                [self.viewChange.labCode setText:@"获取验证码"];
                self.model.isGetCode=NO;
            }
        }];
    }
    
}

/**
 重置密码
 */
-(void)updateLoginPwd{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/updateLoginPwd"];
    NSDictionary *parame=@{@"phone":self.model.phone,
                           @"passwd":[self.model.pwdnew skMD5:self.model.pwdnew],
                           @"clientType":@"1",
                           @"version":skAppVersion,
                           @"IMEI":[skUUID skGetDeviceIMEI],
                           @"vcode":self.model.code
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        skToast(@"密码修改成功");
        if (skUser.phone.length>0) {
            skUser.phone=@"";
            skUserLoginViewController *login=[[skUserLoginViewController alloc] init];
            skAppDelegate.window.rootViewController=login;
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
