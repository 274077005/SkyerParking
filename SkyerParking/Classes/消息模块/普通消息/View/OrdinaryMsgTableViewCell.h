//
//  OrdinaryMsgTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/9/11.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdinaryMsgTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewContain;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labContain;

@end
