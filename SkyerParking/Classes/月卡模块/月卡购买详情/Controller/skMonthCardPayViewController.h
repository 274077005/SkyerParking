//
//  skMonthCardPayViewController.h
//  SkyerParking
//
//  Created by skyer on 2018/11/16.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skBaseViewController.h"
#import "monthCardModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface skMonthCardPayViewController : skBaseViewController
@property (nonatomic,strong) monthCardModel *modelOther;
@property (nonatomic,strong) NSArray *arrCardList;
@property (nonatomic,strong) NSArray *arrPateList;
@property (nonatomic,strong) NSArray *arrSelect;
@property (nonatomic,assign) NSInteger payMoney;
@property (nonatomic,assign) NSInteger indexCardType;//卡的类型选择
@end

NS_ASSUME_NONNULL_END
