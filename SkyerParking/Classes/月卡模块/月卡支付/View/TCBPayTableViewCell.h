//
//  TCBPayTableViewCell.h
//  SkyerParking
//
//  Created by skyer on 2018/11/16.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCBPayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageHeader;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageSelect;
@property (weak, nonatomic) IBOutlet UIButton *btnCharge;

@end

NS_ASSUME_NONNULL_END
