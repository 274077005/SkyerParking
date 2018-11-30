//
//  skColorConfig.h
//  SkyerParking
//
//  Created by admin on 2018/7/3.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 app的主色调

 @param 0x508DFF 色调参数
 @return 颜色值
 */
#define skColorAppMain skUIColorFromRGB(0x508DFF)
//统一线条颜色
#define skLineColor skRGBColor(243, 243, 243)
//cell分割线颜色
#define skCellColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]

#define skBaseColor skUIColorFromRGB(0x508DFF)

#define skBaseColorWeak skUIColorFromRGB(0xB8D9FB)

@interface skColorConfig : NSObject

@end
