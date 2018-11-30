//
//  skMonthCartMangerTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface skMonthCartMangerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageBg;
@property (weak, nonatomic) IBOutlet UILabel *labPlateNo;
@property (weak, nonatomic) IBOutlet UILabel *labNoforCar;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UILabel *labDateCanUse;

@end

NS_ASSUME_NONNULL_END
