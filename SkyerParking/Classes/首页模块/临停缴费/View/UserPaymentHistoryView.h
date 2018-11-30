//
//  UserPaymentHistoryView.h
//  SkyerParking
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPaymentHistoryView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSArray *arrList;
@property (strong, nonatomic) UICollectionView *collectionView;
-(void)userDidSelect:(NSInteger)index;
@end
