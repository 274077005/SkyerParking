//
//  prakingSearchTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/8/9.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "nearParkModel.h"

@interface prakingSearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labParkName;
@property (weak, nonatomic) IBOutlet UIButton *btnAction;


-(void)updateData:(nearParkModel*)model;
@end
