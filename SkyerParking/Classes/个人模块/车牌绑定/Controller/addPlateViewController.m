//
//  addPlateViewController.m
//  SkyerParking
//
//  Created by admin on 2018/8/31.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "addPlateViewController.h"
#import "VehicleKeyboard_swift-Swift.h"
#import "userPayView.h"
@interface addPlateViewController ()<PWHandlerDelegate>
@property (weak, nonatomic) UIView *plateInputView;
@property (strong,nonatomic) PWHandler *handler;
@property (nonatomic,strong) userPayView *viewPay;
@property (nonatomic,strong) NSString *plate;
@end

@implementation addPlateViewController
- (userPayView *)viewPay{
    if (nil==_viewPay) {
        _viewPay=skXibView(@"userPayView");
        [self.view addSubview:_viewPay];
        [_viewPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(280);
        }];
        [_viewPay.btnBanding setEnabled:NO];
        [_viewPay.btnBanding setTitle:@"绑定" forState:(UIControlStateNormal)];
        @weakify(self)
        [[_viewPay.btnChange rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            
            static BOOL btnSelect=NO;
            //格子输入框改变新能源
            [self.handler changeInputTypeWithIsNewEnergy:!btnSelect];
            btnSelect=!btnSelect;
            if (!btnSelect) {
                [self.viewPay.btnChange setTitle:@"切换为新能源汽车" forState:(UIControlStateNormal)];
            }else{
                [self.viewPay.btnChange setTitle:@"切换为普通蓝牌车" forState:(UIControlStateNormal)];
            }
            
        }];
        [[_viewPay.btnBanding rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            
            [self BizLicPlate:self.plate];
            
        }];
        
    }
    return _viewPay;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"绑定车牌";
    //UICollectionView绑定车牌键盘(格子形式)
    self.handler = [PWHandler new];
    [self.handler setKeyBoardViewWithView:self.viewPay.viewPlate];
    
    self.handler.delegate = self;
    //改变主题色
    self.handler.mainColor = skColorAppMain;
    //改变文字大小
    self.handler.textFontSize = 18;
    //改变文字颜色
    self.handler.textColor = [UIColor blackColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.handler changeInputTypeWithIsNewEnergy:NO];
    });
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
#pragma mark - PWHandlerDelegate

//车牌输入发生变化时的回调
- (void)palteDidChnageWithPlate:(NSString *)plate complete:(BOOL)complete{
    NSLog(@"输入车牌号为:%@ \n 是否完整：%@",plate,complete ? @"完整" : @"不完整");
    [self.viewPay.btnBanding setEnabled:complete];
    
    if(complete){
        [self.viewPay.btnBanding setBackgroundColor:skBaseColor];
    }else{
        [self.viewPay.btnBanding setBackgroundColor:skBaseColorWeak];
    }
    
    self.plate=plate;
}

//输入完成点击确定后的回调
- (void)plateInputCompleteWithPlate:(NSString *)plate{
    NSLog(@"输入完成。车牌号为:%@",plate);
    self.plate=plate;
}

//车牌键盘出现的回调
- (void)plateKeyBoardShow{
    NSLog(@"键盘显示了");
}

//车牌键盘消失的回调
- (void) plateKeyBoardHidden{
    NSLog(@"键盘隐藏了");
}



-(void)BizLicPlate:(NSString *)plate{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizLicPlate/create"];
    
    UIImage *imageidcardFront=[UIImage imageNamed:@"AppIcon"];
    
    NSData *data = UIImageJPEGRepresentation(imageidcardFront, 0.5f);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    
    NSData *encodeData = [encodedImageStr dataUsingEncoding:NSUTF8StringEncoding];

    NSString *base64String = [encodeData base64EncodedStringWithOptions:0];
    
    
    NSDictionary *parame=@{@"plateId":@"",
                           @"plateCardNo":plate,
                           @"owner":skUser.memberId,
                           @"driveLicNo":@"201000902074",
                           @"idcardFrontBase64":base64String,
                           @"idcardBackBase64":base64String,
                           };
    
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        if (responseObject.returnCode==0) {
            skToast(@"绑定成功!");
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
