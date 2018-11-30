//
//  setCenterTableViewCell.h
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setCenterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDes;
/**
 关于我们
 */
-(void)setAboutUs;
/**
 清除缓存
 */
-(void)clearCache;
/**
 修改密码
 */
-(void)changePwd;
/**
 显示版本号
 */
-(void)version;
@end
