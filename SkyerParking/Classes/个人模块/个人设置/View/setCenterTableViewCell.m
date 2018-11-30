//
//  setCenterTableViewCell.m
//  SkyerParking
//
//  Created by admin on 2018/7/20.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "setCenterTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation setCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 关于我们
 */
-(void)setAboutUs{
    self.labTitle.text=@"关于我们";
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.labDes.text=@"";
}
- (float)fileSizeAtPath{
    //获取缓存图片的大小(字节)
    NSUInteger bytesCache = [[SDImageCache sharedImageCache] getSize];
    //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
    float MBCache = bytesCache/1000/1000;
    
    return MBCache;
}
/**
 清除缓存
 */
-(void)clearCache{
    self.labTitle.text=@"清除缓存";
    self.labDes.text=[NSString stringWithFormat:@"%.02fM",[self fileSizeAtPath]];
}


/**
 修改密码
 */
-(void)changePwd{
    self.labTitle.text=@"修改密码";
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    self.labDes.text=@"";
}
/**
 显示版本号
 */
-(void)version{
    self.labTitle.text=@"版本号";
    self.labDes.text=[NSString stringWithFormat:@"v%@",skAppVersion];
}
@end
