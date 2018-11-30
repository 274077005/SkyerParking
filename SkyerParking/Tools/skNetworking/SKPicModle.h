//
//  SKPicModle.h
//  GpsDuplicate
//
//  Created by SoKing on 2017/11/24.
//  Copyright © 2017年 skyer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKPicModle : NSObject

/**
 *  上传的图片的名字
 */
@property (nonatomic, copy) NSString *picName;
/**
 *  上传的图片
 */
@property (nonatomic, strong, nullable) UIImage *pic;

/**
 *  上传的二进制文件
 */
@property (nonatomic, strong) NSData *picData;

/**
 *  上传的资源url
 */
@property (nonatomic, copy) NSString *url;

@end

NS_ASSUME_NONNULL_END
