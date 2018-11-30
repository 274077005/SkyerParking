//
//  skValiCar.m
//  SkyerParking
//
//  Created by admin on 2018/7/16.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import "skValiCar.h"

@implementation skValiCar
+(BOOL)checkCarID:(NSString *)carID;
{
    if (carID.length==7) {
        //普通汽车，7位字符，不包含I和O，避免与数字1和0混淆
        NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}[a-hj-np-zA-HJ-NP-Z0-9]{4}[a-hj-np-zA-HJ-NP-Z0-9\u4e00-\u9fa5]$";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
        return [carTest evaluateWithObject:carID];
    }else if(carID.length==8){
        //新能源车,8位字符，第一位：省份简称（1位汉字），第二位：发牌机关代号（1位字母）;
        //小型车，第三位：只能用字母D或字母F，第四位：字母或者数字，后四位：必须使用数字;([DF][A-HJ-NP-Z0-9][0-9]{4})
        //大型车3-7位：必须使用数字，后一位：只能用字母D或字母F。([0-9]{5}[DF])
        NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-np-zA-HJ-NP-Z]{1}([0-9]{5}[d|f|D|F]|[d|f|D|F][a-hj-np-zA-HJ-NP-Z0-9][0-9]{4})$";
        NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
        return [carTest evaluateWithObject:carID];
    }
    return NO;
}

@end
