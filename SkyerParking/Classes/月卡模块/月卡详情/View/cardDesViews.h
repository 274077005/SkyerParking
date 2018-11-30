//
//  cardDesViews.h
//  SkyerParking
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface cardDesViews : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *labParkingName;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labPayCount;
@property (weak, nonatomic) IBOutlet UIButton *btnPayforMonthCard;
@property (weak, nonatomic) IBOutlet UIView *viewContain;
@property (nonatomic,strong) NSArray *arrCardList;
@property (nonatomic,strong) NSArray *arrPlateList;
@property (nonatomic,assign) NSInteger indexTaocan;
@property (nonatomic,strong) NSMutableArray *arrSelect;
-(void)skUserClick:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
