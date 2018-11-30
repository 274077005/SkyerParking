//
//  ChangeUserInfoViewController.m
//  SkyerParking
//
//  Created by admin on 2018/9/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import "ChangeViews.h"
#import "BDImagePicker.h"

@interface ChangeUserInfoViewController ()
@property (nonatomic,strong) ChangeViews *viewChange;
@end

@implementation ChangeUserInfoViewController


-(ChangeViews *)viewChange{
    if (nil==_viewChange) {
        _viewChange=skXibView(@"ChangeViews");
        [self.view addSubview:_viewChange];
        [_viewChange mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
        }];
    }
    return _viewChange;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self)
    [[[self skCreatBtn:@"保存" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self bizMemberupdate];
    }];
    
    self.title=@"修改昵称";
    
    self.viewChange.txtName.text=self.model.nickName;
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
-(void)bizMemberupdate{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/bizMember/update"];
    NSDictionary *parame=@{@"memberId":self.model.memberId,
                           @"nickName":self.viewChange.txtName.text,
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:NO showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {

        if (responseObject.returnCode==0) {
            self.model.nickName=self.viewChange.txtName.text;
            skToast(@"修改成功");
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}
@end
