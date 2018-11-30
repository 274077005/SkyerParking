//
//  UserPaymentViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "UserPaymentViewController.h"
#import "VehicleKeyboard_swift-Swift.h"
#import "plateModel.h"
#import "userPayView.h"
#import "UserPaymentHistoryView.h"
#import "parkOrderModel.h"
#import "skOrderPaymentViewController.h"
#import "userPaymentModel.h"


@interface UserPaymentViewController ()<PWHandlerDelegate>
@property (strong,nonatomic) PWHandler *handler;
@property (nonatomic,strong) userPayView *viewPay;
@property (nonatomic,strong) NSString *plate;
@property (nonatomic,strong) UserPaymentHistoryView *viewUserHistory;
@property (nonatomic,strong) NSArray *arrList;
@end

@implementation UserPaymentViewController




-(UserPaymentHistoryView *)viewUserHistory{
    if (nil==_viewUserHistory) {
        _viewUserHistory=skXibView(@"UserPaymentHistoryView");
        [self.view addSubview:_viewUserHistory];
        [_viewUserHistory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.viewPay.mas_bottom);
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(80);
        }];
        
        @weakify(self)
        [[_viewUserHistory rac_signalForSelector:@selector(userDidSelect:)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            NSLog(@"点击了=%@",x.first);
            NSString *index=x.first;
            
            plateModel *modelPlate=[self.arrList objectAtIndex:[index intValue]];
            self.plate=modelPlate.plateCardNo;
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [self.handler setPlateWithPlate:self.plate type:PWKeyboardNumTypeAuto];
            [self.viewPay.btnBanding setEnabled:YES];
            
            [self.viewPay.btnBanding setBackgroundColor:skBaseColor];
            
        }];
    }
    return _viewUserHistory;
}


- (userPayView *)viewPay{
    if (nil==_viewPay) {
        _viewPay=skXibView(@"userPayView");
        [self.view addSubview:_viewPay];
        [_viewPay.btnBanding setEnabled:NO];
        [_viewPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(280);
        }];
        [_viewPay.btnBanding setTitle:@"查询" forState:(UIControlStateNormal)];
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
            
            [self bizParkingOrder];
            
        }];
    }
    return _viewPay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"临停缴费";
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
    [self viewUserHistory];
    [self bizLicPlate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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


/**
 临停缴费5
 */
-(void)bizParkingOrder{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/jfParkingOrder/queryOrderByPlateNo"];
    
    NSDictionary *parame=@{@"plate":self.plate};
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        
        if (responseObject.returnCode==0) {
            
            parkOrderModel *model=[parkOrderModel mj_objectWithKeyValues:responseObject.data];
            skOrderPaymentViewController *view=[[skOrderPaymentViewController alloc] init];
            view.modelOther=model;
            [self.navigationController pushViewController:view animated:YES];
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取车牌列表
 */
-(void)bizLicPlate{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizLicPlate/list"];
    
    
    NSDictionary *dicandConds=@{
                                @"value":skUser.memberId,
                                @"operator":@"=",
                                @"columnName":@"owner",
                                };
    NSArray *andConds=@[dicandConds];
    
    NSDictionary *pageModel=@{@"page":@0,
                              @"rows":@6
                              };
    
    
    NSDictionary *parame=@{
                           @"andConds":andConds,
                           @"pageModel":pageModel,
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        
        skListModel *model=[skListModel mj_objectWithKeyValues:responseObject.data];
        self.arrList = [plateModel mj_objectArrayWithKeyValuesArray:model.list];
        self.viewUserHistory.arrList=self.arrList;
        [self.viewUserHistory.collectionView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
///**
// 历史记录
// */
//
//-(void)findHistory{
//    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizParkingOrder/findHistory"];
//
//    NSDictionary *parame=@{
//                           @"memberId":skUser.memberId,
//                           @"count":@3,
//                           };
//
//    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
//
//        skListModel *model=[skListModel mj_objectWithKeyValues:responseObject.data];
//        self.arrList=model.list;
//        self.viewUserHistory.arrList=self.arrList;
//        [self.viewUserHistory.collectionView reloadData];
//
//    } failure:^(NSError * _Nullable error) {
//
//    }];
//}
@end
