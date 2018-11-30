//
//  surePayView.h
//  SkyerParking
//
//  Created by admin on 2018/7/24.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "surePayModel.h"
@interface surePayView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UILabel *btnCount;
@property (weak, nonatomic) IBOutlet UIButton *btnWXSelect;
@property (weak, nonatomic) IBOutlet UIButton *btnZFBSelect;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
-(void)skSetData:(surePayModel*)data;
@end
