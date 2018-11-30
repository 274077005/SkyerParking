//
//  TCBIRechargeViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "TCBIRechargeViewController.h"
#import "TCBIDesView.h"
#import "skListModel.h"
#import "TCBIListModel.h"
#import "TCBIChargeView.h"
#import "skSurePayViewController.h"
#import "respDataModel.h"
#import "TCBIItemView.h"
#import "skTCBIViewController.h"

@interface TCBIRechargeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) skListModel *model;
@property (nonatomic,strong) TCBIChargeView *viewTCBI;
@property (nonatomic,assign) NSInteger indexSelect;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UILabel *labCountTotle;
@property (nonatomic,strong) respDataModel *modelM;
@property (nonatomic,strong) UILabel *labTitle;
@end

@implementation TCBIRechargeViewController
-(UILabel *)labCountTotle{
    if (nil==_labCountTotle) {
        _labCountTotle=[[UILabel alloc] initWithFrame:CGRectMake(30, 40, 200, 40)];
        _labCountTotle.textColor=[UIColor whiteColor];
        _labCountTotle.font=[UIFont systemFontOfSize:30];
    }
    return _labCountTotle;
}

- (UILabel *)labTitle{
    if (nil==_labTitle) {
        _labTitle=[[UILabel alloc] initWithFrame:CGRectMake(30, 10, 200, 30)];
        self.labTitle.textColor=[UIColor whiteColor];
    }
    return _labTitle;
}
-(UICollectionView *)collectionView{
    if (nil==_collectionView) {
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置headerView的尺寸大小
        layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
        //设置尾部的尺寸大小
        layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 137);
        //该方法也可以设置itemSize
        layout.itemSize =CGSizeMake((skScreenWidth-30)/2, 80);
        _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        [self.view addSubview:_collectionView];
        
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
            make.right.left.mas_equalTo(0);
            make.bottom.mas_equalTo(self.viewTCBI.mas_top);
        }];
        _collectionView.backgroundColor = [UIColor clearColor];
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView"];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
- (TCBIChargeView *)viewTCBI{
    if (nil==_viewTCBI) {
        _viewTCBI=skXibView(@"TCBIChargeView");
        [self.view addSubview:_viewTCBI];
        [_viewTCBI mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(60);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
        }];
        
        [[_viewTCBI.btnSure rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            skSurePayViewController *viewCharge=[[skSurePayViewController alloc] init];
            viewCharge.typePayFor=rechargeTypeBalance;//余额充值
            NSDictionary *dic=[self.model.list objectAtIndex:self.indexSelect];
            viewCharge.dicPay=dic;
            NSLog(@"传过去的数据%@",dic);
            //关键语句，必须有
            viewCharge.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
            viewCharge.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:viewCharge animated:YES completion:^(void){
                
            }];
        }];
        
    }
    return _viewTCBI;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"停车币购买";
    @weakify(self)
    [[[self skCreatBtn:@"记录" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        skTCBIViewController *view=[[skTCBIViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self RechargeOptionlist];
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




#pragma mark mark - 代理方法UICollectionReusableView
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    UIColor *colorSelect=skLineColor;
    UIColor *colorTitls=[UIColor blackColor];
    if (indexPath.row==_indexSelect) {
        colorSelect=skColorAppMain;
        colorTitls=[UIColor whiteColor];
    }
    
    TCBIItemView *view=skXibView(@"TCBIItemView");
    [cell.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    NSDictionary *dic=self.model.list[indexPath.row];
    TCBIListModel *modelList=[TCBIListModel mj_objectWithKeyValues:dic];
    view.labCount.text=[NSString stringWithFormat:@"%ld",modelList.number];
    view.labCountS.text=[NSString stringWithFormat:@"送%ld个停车币",modelList.sendNumber];
    
    [view skSetBoardRadius:5 Width:1 andBorderColor:colorSelect];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((skScreenWidth-30)/2, 80);
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


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind ==UICollectionElementKindSectionHeader){
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
        headerView.backgroundColor =skColorAppMain;
        
        self.labTitle.text=@"可用停车币";
        [headerView addSubview:self.labTitle];
        
        
        self.labCountTotle.text=[NSString stringWithFormat:@"%.02f",self.modelM.tingchebis];
        [headerView addSubview:self.labCountTotle];
        return headerView;
    }
    
    if (kind ==UICollectionElementKindSectionFooter) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView" forIndexPath:indexPath];
        TCBIDesView *view=skXibView(@"TCBIDesView");
        [headerView addSubview:view];
        return headerView;
    }
    return nil;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了=%ld",indexPath.row);
    _indexSelect=indexPath.row;
    [self.collectionView reloadData];
}
-(void)RechargeOptionlist{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizRechargeOption/list"];
    
    
    NSDictionary *dicandConds=@{
                                @"value":@"2",
                                @"operator":@"=",
                                @"columnName":@"type"
                                
                                };
    NSArray *andConds=@[dicandConds];
    
    NSDictionary *parame=@{
                           @"andConds":andConds,
                           @"member_id":skUser.memberId
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        
        NSLog(@"请求列表成功");
        self.model=[skListModel mj_objectWithKeyValues:responseObject.data];
        self.modelM=[respDataModel mj_objectWithKeyValues:responseObject.respData];
        
        [self viewTCBI];
        [self.collectionView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
