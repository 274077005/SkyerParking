//
//  mothCardTableViewCell.h
//  SkyerParking
//
//  Created by skyer on 2018/11/12.
//  Copyright © 2018 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface mothCardTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labParkingName;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;
@property (weak, nonatomic) IBOutlet UILabel *labPlaceName;
@property (weak, nonatomic) IBOutlet UILabel *labMonthCard;
@property (weak, nonatomic) IBOutlet UILabel *labQuarterCard;
@property (weak, nonatomic) IBOutlet UILabel *labYearCard;

@end

NS_ASSUME_NONNULL_END
