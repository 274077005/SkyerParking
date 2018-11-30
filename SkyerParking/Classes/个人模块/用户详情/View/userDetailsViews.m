//
//  userDetailsViews.m
//  SkyerParking
//
//  Created by admin on 2018/8/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "userDetailsViews.h"
#import "testCollectionViewCell.h"

@implementation userDetailsViews


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //该方法也可以设置itemSize
        layout.itemSize =CGSizeMake((skScreenWidth-30)/4, 50);
        self.conllectionView=[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.conllectionView.delegate=self;
        self.conllectionView.dataSource=self;
        self.conllectionView.backgroundColor=[UIColor whiteColor];
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [self.conllectionView registerNib:[UINib nibWithNibName:@"testCollectionViewCell"bundle:nil]forCellWithReuseIdentifier:@"testCollectionViewCell"];
        [self addSubview:self.conllectionView];
    }
    return self;
}

#pragma mark mark - 代理方法UICollectionReusableView
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    testCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"testCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((skScreenWidth-30)/4, 50);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

@end
