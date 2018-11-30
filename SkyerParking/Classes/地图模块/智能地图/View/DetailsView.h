//
//  DetailsView.h
//  SkyerParking
//
//  Created by admin on 2018/7/13.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "nearParkModel.h"

@interface DetailsView : UIView
@property (weak, nonatomic) IBOutlet UIView *viewContance;
@property (weak, nonatomic) IBOutlet UILabel *labParkName;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labCharge;
@property (weak, nonatomic) IBOutlet UIButton *btnGoto;
@property (weak, nonatomic) IBOutlet UIButton *btnMiss;
@property (weak, nonatomic) IBOutlet UIButton *btnDes;
@property (weak, nonatomic) IBOutlet UILabel *labNumber;

-(void)updateData:(nearParkModel*)model;
@end
