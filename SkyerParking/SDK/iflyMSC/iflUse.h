//
//  iflUse.h
//  TingCheDao
//
//  Created by skyer on 2018/5/25.
//  Copyright © 2018年 DLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFlyMSC/IFlyMSC.h"
#import "ISRDataHelper.h"

@interface iflUse : NSObject  <IFlyRecognizerViewDelegate>
SkyerSingletonH(iflUse)

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;

-(void)initIfly:(UIViewController *)selfView;
/**
 开始录音
 */

-(void)skyerStartIfly;

/**
 语音识别

 @param result 获取到的结果
 @return 返回的结果
 */
-(NSString *)skyerResultString:(NSString *)result;

@end
