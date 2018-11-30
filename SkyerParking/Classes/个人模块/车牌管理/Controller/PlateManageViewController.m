//
//  PlateManageViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "PlateManageViewController.h"
#import "PlateManageTableViewCell.h"
#import "addPlateViewController.h"
#import "plateModel.h"
#import "PlateAddTableViewCell.h"

@interface PlateManageViewController ()
@property (nonatomic,strong) NSArray *arrList;
@end

@implementation PlateManageViewController

-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=skLineColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"车牌管理";
    [self addTableView];
    skWeakSelf(self)
    [self createRefreshHeaderViewWithBlock:^{
        [weakself bizLicPlate];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self bizLicPlate];
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
#pragma mark - 代理方法

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrList.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrList.count==0||self.arrList.count==indexPath.row) {
        return 150;
    }
    
    return 210;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (self.arrList.count==0||self.arrList.count==indexPath.row) {
        static NSString *cellIdentifier = @"PlateAddTableViewCell";
        PlateAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = skXibView(@"PlateAddTableViewCell");
            @weakify(self)
            [[cell.btnAdd rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                addPlateViewController *view=[[addPlateViewController alloc] init];
                [self.navigationController pushViewController:view animated:YES];
            }];
        }
        cell.contentView.backgroundColor=skLineColor;
        cell.viewContain.backgroundColor=skLineColor;
        
        CAShapeLayer *layer   = [[CAShapeLayer alloc] init];
        layer.frame            = CGRectMake(0, 0 , cell.viewContain.frame.size.width, cell.viewContain.frame.size.height);
        layer.backgroundColor   = [UIColor clearColor].CGColor;
        
        UIBezierPath *path    = [UIBezierPath bezierPathWithRoundedRect:layer.frame cornerRadius:4.0f];
        layer.path             = path.CGPath;
        layer.lineWidth         = 2.0f;
        layer.lineDashPattern    = @[@4, @4];
        layer.fillColor          = [UIColor clearColor].CGColor;
        layer.strokeColor       = [UIColor grayColor].CGColor;
        
        [cell.viewContain.layer addSublayer:layer];
        
        return cell;
    }else{
        static NSString *cellIdentifier = @"PlateManageTableViewCell";
        PlateManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            @weakify(self)
            cell = skXibView(@"PlateManageTableViewCell");
            [[cell.btnIsAutoPay rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                [self updateAutoPay:x.tag];
            }];
            
            [[cell.btnDelete rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self)
                
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确认删除?" message:@"删除将失去所有认证信息!" preferredStyle:(UIAlertControllerStyleAlert)];
                
                UIAlertAction *action=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *action1=[UIAlertAction actionWithTitle:@"删除" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [self deletes:x.tag];
                }];
                [alert addAction:action];
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
            }];
        }else{
            NSLog(@"5555666复用");
        }
        plateModel *model=[_arrList objectAtIndex:indexPath.row];
        cell.labPlateCardNo.text=model.plateCardNo;
        
        [cell.btnRealnameName setTitle:model.isRealnameName forState:(UIControlStateNormal)];
        UIColor *color=nil;
        if (model.isRealname==0) {
            color=[UIColor lightGrayColor];
            
        }else{
            color=skColorAppMain;
        }
        
        [cell.btnRealnameName setTitleColor:color forState:(UIControlStateNormal)];
        
        NSString *imageName=model.isAutoPay?@"plateIsPay1":@"plateIsPay0";
        
        [cell.btnIsAutoPay setBackgroundImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
        
        cell.btnDelete.tag=indexPath.row;
        cell.btnIsAutoPay.tag=indexPath.row;
        
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 更新是否自动扣费
-(void)updateAutoPay:(NSInteger)index{
    NSLog(@"tag==%ld",index);
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizLicPlate/updateAutoPay"];
    
    plateModel *models=[self.arrList objectAtIndex:index];
    
    Boolean isAutoPay=models.isAutoPay;
    
    NSDictionary *parame=@{@"memberId":skUser.memberId,
                           @"plateId":[NSNumber numberWithInteger:models.plateId],
                           @"isAutoPay":[NSNumber numberWithBool:!isAutoPay]
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        
        [self bizLicPlate];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 获取车牌列表
 */
-(void)bizLicPlate{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizLicPlate/list"];
    
    
    NSDictionary *dicandConds=@{
                                @"value":skUser.memberId,
                                @"operator":@"=",
                                @"columnName":@"owner",
                                };
    NSArray *andConds=@[dicandConds];
    
    NSDictionary *pageModel=@{@"page":@0,
                              @"rows":@20
                              };
    
    
    NSDictionary *parame=@{
                           @"andConds":andConds,
                           @"pageModel":pageModel,
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
        [self headerEndRefreshing];
        skListModel *model=[skListModel mj_objectWithKeyValues:responseObject.data];
        self.arrList = [plateModel mj_objectArrayWithKeyValuesArray:model.list];
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}
#pragma mark - 解除绑定
-(void)deletes:(NSInteger)index{
    NSLog(@"解除绑定");
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizLicPlate/deletes"];
    
    plateModel *models=[self.arrList objectAtIndex:index];
    
    NSInteger plateId=models.plateId;
    
    NSDictionary *parame=@{@"ids":@[[NSNumber numberWithInteger:plateId]]};
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        [self bizLicPlate];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
