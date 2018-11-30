//
//  WalletTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/7/19.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageDes;
@property (weak, nonatomic) IBOutlet UILabel *labCount;
@property (weak, nonatomic) IBOutlet UILabel *labDes;
@property (weak, nonatomic) IBOutlet UILabel *labTime;

@end
