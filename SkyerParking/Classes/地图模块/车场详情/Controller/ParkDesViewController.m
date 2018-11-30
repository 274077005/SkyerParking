//
//  ParkDesViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ParkDesViewController.h"
#import "parkingDesVeiw.h"
#import "parkDesTableViewCell.h"
#import "skBMKMapNav.h"
#import "UIImageView+WebCache.h"

@interface ParkDesViewController ()
@property (nonatomic,strong) parkingDesVeiw *viewDesHeader;
@end

@implementation ParkDesViewController

- (parkingDesVeiw *)viewDesHeader{
    if (nil==_viewDesHeader) {
        _viewDesHeader=skXibView(@"parkingDesVeiw");
        
        @weakify(self)
        [[_viewDesHeader.btnGoNav rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [[skBMKMapNav sharedskBMKMapNav]skGoNavView:self.model.latitude longitude:self.model.longitude andPlace:self.model.parking_name];
        }];
    }
    return _viewDesHeader;
}



-(void)addTableView{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor=skLineColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableView];
    NSLog(@"%@",self.model);
    self.title=@"停车场详情";
}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}
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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 300;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.viewDesHeader.labPlace.text=self.model.parking_name;
    self.viewDesHeader.labAre.text=self.model.address;
    self.viewDesHeader.LabDistance.text=[NSString stringWithFormat:@"%@ km",self.model.distance];
//    self.viewDesHeader.labCount.text=self.model.freeTmpCarsNum;
//    [self.viewDesHeader.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.picUrl] placeholderImage:[UIImage imageNamed:@"moren1"]];
    return self.viewDesHeader;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"parkDesTableViewCell";
    parkDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = skXibView(@"parkDesTableViewCell");
    }
    cell.contentView.backgroundColor=skLineColor;
    switch (indexPath.row) {
        case 0:
        {
            cell.labTitle.text=@"联系方式";
//            cell.labDes.text=[self.model.contactPhone length]>1?self.model.contactPhone:@"暂无联系方式";
            cell.labDes.text=@"后台无此字段";
        }
            break;
        case 1:
        {
            cell.labTitle.text=@"收费标准";
            cell.labDes.text=@"后台没有返回收费规则字段";
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


@end
