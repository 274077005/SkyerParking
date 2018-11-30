//
//  skUserDetailsViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/25.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skUserDetailsViewController.h"
#import "skUserDesHeadTableViewCell.h"
#import "skUserDesTableViewCell.h"
#import "userCenterInfoModel.h"
#import "ChangeUserInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "ChangImageModel.h"
#import "BDImagePicker.h"


@interface skUserDetailsViewController ()
@property (nonatomic,strong) userCenterInfoModel *modelUser;
@property (nonatomic,strong) skUserDesHeadTableViewCell *cellUserDesHead;
@end

@implementation skUserDetailsViewController

-(skUserDesHeadTableViewCell *)cellUserDesHead{
    if (nil==_cellUserDesHead) {
        self.cellUserDesHead = skXibView(@"skUserDesHeadTableViewCell");
        [self.cellUserDesHead.imageHeader skSetBoardRadius:25 Width:0 andBorderColor:nil];
    }
    return _cellUserDesHead;
}

-(void)addTableView{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    self.tableView.backgroundColor=skLineColor;
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"用户详情";
    [self addTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getUserInfosById];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 70;
            break;
        case 1:
            return 44;
            break;
            
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, skScreenWidth, 15)];
    view.backgroundColor=skLineColor;
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        {
            return self.cellUserDesHead;
        }
            break;
        case 1:
        {
            static NSString *cellIdentifier = @"skUserDesTableViewCell";
            skUserDesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = skXibView(@"skUserDesTableViewCell");
            }
            switch (indexPath.row) {
                case 0:
                {
                    cell.labTitle.text=@"昵称";
                    cell.labName.text=self.modelUser.nickName;
                }
                    break;
                    
                default:
                    break;
            }
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0://修改头像
        {
            [self aleShowView];
            
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0://修改昵称
                {
                    ChangeUserInfoViewController *view=[[ChangeUserInfoViewController alloc] init];
                    view.model=self.modelUser;
                    [self.navigationController pushViewController:view animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)aleShowView
{
    skWeakSelf(self)
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        [weakself changUserImage:image];
    }];
}


-(void)changUserImage:(UIImage *)image{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cellUserDesHead.imageHeader.image=image;
        
        
        [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/uploadheadPic"];
        
        NSData *data = UIImageJPEGRepresentation(image, 0.5f);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
        encodedImageStr=[encodedImageStr stringByReplacingOccurrencesOfString:@"+"withString:@" "];
        
        
        NSDictionary *parame=@{@"memberId":skUser.memberId,
                               @"headImgPath":[NSString stringWithFormat:@"%@",encodedImageStr]
                               };
        
        NSLog(@"====%@",parame);
        
        [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
            
            [self getUserInfosById];
            
        } failure:^(NSError * _Nullable error) {
            
        }];
    });
    
}

-(void)getUserInfosById{
    if (skUser.phone.length==11) {
        [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/getUserInfosById"];
        
        NSDictionary *parame=@{@"memberId":skUser.memberId};
        
        [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:NO success:^(skResponeModel * _Nonnull responseObject) {
            
            self.modelUser=[userCenterInfoModel mj_objectWithKeyValues:responseObject.data];
            
            [self.cellUserDesHead.imageHeader sd_setImageWithURL:[NSURL URLWithString:self.modelUser.headPic] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            
            [self.tableView reloadData];
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
}
@end
