//
//  skMunesTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/11/26.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "skMenusModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface skMunesTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) skMenusModel *model;
@end

NS_ASSUME_NONNULL_END
