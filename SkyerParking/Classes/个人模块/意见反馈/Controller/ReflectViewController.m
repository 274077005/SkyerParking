//
//  ReflectViewController.m
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "ReflectViewController.h"
#import "ReflectViews.h"
#import "BDImagePicker.h"

@interface ReflectViewController ()
@property (nonatomic,strong) ReflectViews *viewRef;
@property (nonatomic,strong) UIImage *image;
@end

@implementation ReflectViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"意见反馈";
    self.viewRef=skXibView(@"ReflectViews");
    [self.view addSubview:self.viewRef];
    [self.viewRef mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    @weakify(self)
    [[[self skCreatBtn:@"提交" btnTitleOrImage:(btntypeTitle) btnLeftOrRight:(btnStateRight)] rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.viewRef.txtContain.text.length>0) {
            [self msgFeedBack];
        }else{
            skToast(@"请输入反馈内容");
        }
        
    }];
    
    [[self.viewRef.btnImage rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
            self.image=image;
//            [self.viewRef.btnImage setBackgroundImage:self.image forState:(UIControlStateNormal)];
//            [self msgFeedBack];
        }];
    }];
    
    [[self.viewRef.txtContain rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        
        if (x.length>0) {
            [self.viewRef.labPre setHidden:YES];
        }else{
            [self.viewRef.labPre setHidden:NO];
        }
        
        if (x.length<=500) {
            self.viewRef.labCount.text=[NSString stringWithFormat:@"%ld/500",x.length];
        }
        if (x.length>=500) {
            self.viewRef.txtContain.text=[x substringToIndex:499];
        }
        
    }];
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

-(void)msgFeedBack{
    [skParameDealMethod skInitMudlesWithInterface:@"/intf/msgFeedBack/save"];
    
    NSData *data = UIImageJPEGRepresentation(self.image, 0.5f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    encodedImageStr=[encodedImageStr stringByReplacingOccurrencesOfString:@"+"withString:@" "];
    
    NSDictionary *parame=@{@"memberId":skUser.memberId,
                           @"content":self.viewRef.txtContain.text,
                           @"imgPath":encodedImageStr
                           };
    
    [skAFNet SKPOST:skUrl parameters:skParam(parame) showHUD:YES showErrMsg:YES success:^(skResponeModel * _Nonnull responseObject) {
        if (responseObject.returnCode==0) {
            skToast(@"您的意见意见成功反馈");
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

@end
