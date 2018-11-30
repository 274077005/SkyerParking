//
//  MonthCardPayViews.h
//  SkyerParking
//
//  Created by skyer on 2018/11/16.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthCardPayHearderViews.h"
NS_ASSUME_NONNULL_BEGIN

@interface MonthCardPayViews : UIView <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) MonthCardPayHearderViews *viewHeader;
@property (weak, nonatomic) IBOutlet UIView *viewCollectionViewContain;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (nonatomic,strong) NSArray *arrPlate;
@property (nonatomic,strong) NSArray *arrSelect;


@end

NS_ASSUME_NONNULL_END
