//
//  PlateManageTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/7/21.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlateManageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewContain;
@property (weak, nonatomic) IBOutlet UILabel *labPlateCardNo;
@property (weak, nonatomic) IBOutlet UIButton *btnRealnameName;
@property (weak, nonatomic) IBOutlet UIButton *btnIsAutoPay;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end
