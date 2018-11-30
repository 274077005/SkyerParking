//
//  userDetailsViews.h
//  SkyerParking
//
//  Created by admin on 2018/8/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userDetailsViews : UIView <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *conllectionView;

@end
