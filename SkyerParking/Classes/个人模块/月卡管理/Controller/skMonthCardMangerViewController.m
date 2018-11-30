//
//  skMonthCardMangerViewController.m
//  SkyerParking
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import "skMonthCardMangerViewController.h"
#import "skMonthCartMangerTableViewCell.h"
#import "monthCartMangerModel.h"
@interface skMonthCardMangerViewController ()
@property (nonatomic,strong) NSArray *arrList;
@end

@implementation skMonthCardMangerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"月卡管理";
    [self addTableView];
    [self queryParkingCardCarsList];
}
-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 代理方法
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"skMonthCartMangerTableViewCell";
    skMonthCartMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"skMonthCartMangerTableViewCell");
    }
    monthCartMangerModel *model=[self.arrList objectAtIndex:indexPath.row];
    
    cell.labPlateNo.text=model.plateNo;
    cell.labNoforCar.text=model.cardNum;
    cell.labAddress.text=model.parkingName;
    cell.labDateCanUse.text=[NSString stringWithFormat:@"有限日期:%@",model.validEndDate];
    
    switch (model.cardType) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            cell.imageBg.image=[UIImage imageNamed:@"yuekabg"];
        }
            break;
        case 2:
        {
            cell.imageBg.image=[UIImage imageNamed:@"jikabg"];
        }
            break;
        case 3:
        {
            cell.imageBg.image=[UIImage imageNamed:@"niankabg"];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)queryParkingCardCarsList{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/jfParkingCard/queryParkingCardCarsList"];
    
    NSDictionary *parame=@{@"memberId":skUser.memberId
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        skListModel *modelList=[skListModel mj_objectWithKeyValues:responseObject.data];
        self.arrList=[monthCartMangerModel mj_objectArrayWithKeyValuesArray:modelList.cardList];
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
