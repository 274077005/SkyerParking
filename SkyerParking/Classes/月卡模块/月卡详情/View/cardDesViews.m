//
//  cardDesViews.m
//  SkyerParking
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "cardDesViews.h"
#import "viewMonthcardTaocan.h"
#import "viewPlateMonthCard.h"
#import "viewWithMonthCard.h"
#import "cardLiseModel.h"
#import "addPlateViewController.h"
#import "plateListModel.h"
#import "PlateManageViewController.h"
#define KCellID @"cardDesViewsID"
#define KHedderID @"cardDesViewsHedderID"
#define KFooterID @"cardDesViewsFooterID"

@implementation cardDesViews

-(UICollectionView *)collectionView{
    if (nil==_collectionView) {
        
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置headerView的尺寸大小
        //        layout.headerReferenceSize = CGSizeMake(self.frame.size.width, 20);
        //设置尾部的尺寸大小
        layout.footerReferenceSize = CGSizeMake(self.frame.size.width, 30);
        //        该方法也可以设置itemSize
        
        
        layout.itemSize =CGSizeMake((skScreenWidth-50)/3, 60);
        _collectionView=[[UICollectionView alloc] initWithFrame:self.viewContain.bounds collectionViewLayout:layout];
        
        [self.viewContain addSubview:_collectionView];
        [_collectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:KCellID];
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHedderID];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KFooterID];
//        _collectionView.bounces = NO;
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
#pragma mark mark - 代理方法UICollectionReusableView
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return self.arrCardList.count;
    }else{
        
        if (self.arrPlateList.count==0) {
            
            return 1;
            
        }else{
            
            return self.arrPlateList.count;
            
        }
        
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCellID forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    switch (indexPath.section) {
        case 0:
        {
            viewMonthcardTaocan *taocanView=skXibView(@"viewMonthcardTaocan");
            [cell.contentView addSubview:taocanView];
            [taocanView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.top.mas_equalTo(0);
                make.height.mas_equalTo(136);
            }];
            [taocanView skSetBoardRadius:5 Width:0 andBorderColor:nil];
            if (self.indexTaocan==indexPath.row) {
                taocanView.imageBG.image=[UIImage imageNamed:@"xuanzhekuang"];
            }
            cardLiseModel *modelCard=[self.arrCardList objectAtIndex:indexPath.row];
            switch (modelCard.cardType) {
                case 1:
                {
                    taocanView.labCardType.text=@"月卡";
                    taocanView.labTime.text=@"1个月";
                    taocanView.labMoney.text=[NSString stringWithFormat:@"%ld",modelCard.price];
                    [taocanView.labSumMoney setHidden:YES];
                }
                    break;
                case 2:
                {
                    taocanView.labCardType.text=@"季卡";
                    taocanView.labTime.text=@"3个月";
                    taocanView.labMoney.text=[NSString stringWithFormat:@"%ld",modelCard.price];
                    [taocanView.labSumMoney setHidden:NO];
                    taocanView.labSumMoney.text=[NSString stringWithFormat:@"折合￥%ld/月",modelCard.price/3];
                }
                    break;
                case 3:
                {
                    taocanView.labCardType.text=@"年卡";
                    taocanView.labTime.text=@"12个月";
                    taocanView.labMoney.text=[NSString stringWithFormat:@"%ld",modelCard.price];
                    [taocanView.labSumMoney setHidden:NO];
                    taocanView.labSumMoney.text=[NSString stringWithFormat:@"折合￥%ld/月",modelCard.price/12];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        case 1:
        {
            
            if (self.arrPlateList.count==0) {
                
                viewWithMonthCard *viewCard=skXibView(@"viewWithMonthCard");
                [cell.contentView addSubview:viewCard];
                [viewCard skSetBoardRadius:5 Width:0 andBorderColor:nil];
                @weakify(self)
                [[viewCard.btnBanding rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                    @strongify(self)
                    addPlateViewController *view=[[addPlateViewController alloc] init];
                    [skVSView.navigationController pushViewController:view animated:YES];
                }];
                
            }else{
                
                plateListModel *model=[self.arrPlateList objectAtIndex:indexPath.row];
                viewPlateMonthCard *viewPate=skXibView(@"viewPlateMonthCard");
                [cell.contentView addSubview:viewPate];
                [viewPate mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.size.mas_equalTo(CGSizeMake(110, 30));
                    make.right.left.top.mas_equalTo(0);
                    make.height.mas_equalTo(36);
                }];
                NSString *selectRow=[NSString stringWithFormat:@"%ld",indexPath.row];
                if ([self.arrSelect containsObject:selectRow]) {
                    [viewPate skSetBoardRadius:4 Width:2 andBorderColor:skColorAppMain];
                }else{
                    [viewPate skSetBoardRadius:4 Width:0 andBorderColor:skColorAppMain];
                }
                viewPate.labPlate.text=model.plateCardNo;
                
                
            }
            
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake((skScreenWidth-50)/3, 136);
    }else{
        
        if (self.arrPlateList.count==0) {
            
            return CGSizeMake((skScreenWidth-40), 80);
            
        }else{
            
            return CGSizeMake((skScreenWidth-50)/3, 50);
            
        }
        
    }
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(100, 30);
}

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


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind ==UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KHedderID forIndexPath:indexPath];
        
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, skScreenWidth-20, 20)];
        for (UIView *view in headerView.subviews) {
            if (view) {
                [view removeFromSuperview];
            }
        }
        switch (indexPath.section) {
            case 0:
            {
                lab.text=@"选择时长";
            }
                break;
            case 1:
            {
                lab.text=@"选择开通车辆";
            }
                break;
                
            default:
                break;
        }
        [headerView addSubview:lab];
        
        return headerView;
    }
    
    if (kind ==UICollectionElementKindSectionFooter) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KFooterID forIndexPath:indexPath];
        
        
        
        return headerView;
    }
    return nil;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了=%ld",indexPath.row);
    [self skUserClick:indexPath];
}
-(void)skUserClick:(NSIndexPath *)indexPath{
    
}

@end
