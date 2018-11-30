//
//  skCardDesViewController.m
//  SkyerParking
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skCardDesViewController.h"
#import "cardDesViews.h"
#import "UIView+Shadow.h"
#import "plateListModel.h"
#import "cardLiseModel.h"

@interface skCardDesViewController ()
@property (nonatomic,strong) cardDesViews *viewCardDes;
@property (nonatomic,strong) NSArray *arrCardList;
@property (nonatomic,strong) NSArray *arrPateList;
@property (nonatomic,assign) NSInteger indexTaocan;
@property (nonatomic,strong) NSMutableArray *arrSelect;
@property (nonatomic,strong) cardLiseModel *modelMoney;
@end

@implementation skCardDesViewController
- (NSMutableArray *)arrSelect{
    if (nil==_arrSelect) {
        _arrSelect=[[NSMutableArray alloc] init];
    }
    return _arrSelect;
}
- (cardDesViews *)viewCardDes{
    if (nil==_viewCardDes) {
        _viewCardDes=skXibView(@"cardDesViews");
        [_viewCardDes.btnPayforMonthCard skSetShadowWithColor:skColorAppMain andSizeMake:CGSizeMake(0, 0) Radius:5];
        [self.view addSubview:_viewCardDes];
        _viewCardDes.labParkingName.text=self.modelOther.parkingName;
        _viewCardDes.labAddress.text=self.modelOther.address;
        [_viewCardDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
        
        @weakify(self)
        [[_viewCardDes rac_signalForSelector:@selector(skUserClick:)] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self)
            NSIndexPath *indexPath=x[0];
            if (indexPath.section==0) {
                self.indexTaocan=indexPath.row;
            }else{
                NSString *selectRow=[NSString stringWithFormat:@"%ld",indexPath.row];
                
                if ([self.arrSelect containsObject:selectRow]) {
                    [self.arrSelect removeObject:selectRow];
                }else{
                    [self.arrSelect addObject:selectRow];
                }
            }
            self.viewCardDes.indexTaocan=self.indexTaocan;
            self.viewCardDes.arrSelect=self.arrSelect;
            [self.viewCardDes.collectionView reloadData];
            [self changMoney:indexPath];
        }];
    }
    return _viewCardDes;
}

-(void)changMoney:(NSIndexPath *)indexPath{
    NSInteger money=0;
    NSInteger row=indexPath.row;
    
    if (indexPath.section==0) {
        self.modelMoney=[self.arrCardList objectAtIndex:row];
        money=self.modelMoney.price*self.arrSelect.count;
    }else{
        money=self.modelMoney.price*self.arrSelect.count;
    }
    
    self.viewCardDes.labPayCount.text=[NSString stringWithFormat:@"%ld元",money];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self viewCardDes];
    self.title=@"月卡详情";
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self queryCardAndPlate];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)queryCardAndPlate{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/jfParkingCard/queryCardAndPlate"];
    NSDictionary *parame=@{@"memberId":skUser.memberId,
                           @"parkingId":self.modelOther.ids
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        skListModel *modelList=[skListModel mj_objectWithKeyValues:responseObject.data];
        
        self.arrCardList=[cardLiseModel mj_objectArrayWithKeyValuesArray:modelList.cardList];
        
        self.arrPateList=[plateListModel mj_objectArrayWithKeyValuesArray:modelList.plateList];
        
        self.viewCardDes.arrCardList=self.arrCardList;
        
        self.viewCardDes.arrPlateList=self.arrPateList;
        
        [self.viewCardDes.collectionView reloadData];
        [self changMoney:nil];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
