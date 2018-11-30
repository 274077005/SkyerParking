//
//  iflUse.m
//  TingCheDao
//
//  Created by skyer on 2018/5/25.
//  Copyright © 2018年 DLC. All rights reserved.
//

#import "iflUse.h"

@implementation iflUse
SkyerSingletonM(iflUse)

-(void)initIfly:(UIViewController *)selfView{
    //初始化语音识别控件
    _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:selfView.view.center];
    _iflyRecognizerView.delegate = self;
    [_iflyRecognizerView setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path保存录音文件名，如不再需要，设置value为nil表示取消，默认目录是documents
    [_iflyRecognizerView setParameter:nil forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
}

-(void)skyerStartIfly{
    [_iflyRecognizerView start];
}


/*识别结果返回代理
 @param resultArray 识别结果
 @ param isLast 表示是否最后一次结果
 */
- (void)onResult: (NSArray *)resultArray isLast:(BOOL) isLast
{
    if (!isLast) {
        NSMutableString *result = [[NSMutableString alloc] init];
        NSDictionary *dic = [resultArray objectAtIndex:0];
        
        for (NSString *key in dic) {
            [result appendFormat:@"%@",key];
        }
        NSString * resultFromJson =  [ISRDataHelper stringFromJson:result];
        
        
        [self skyerResultString:resultFromJson];
    }
}
-(NSString *)skyerResultString:(NSString *)result{
    NSLog(@"得到的结果=%@",result);
    return result;
}

/*识别会话错误返回代理
 @ param  error 错误码
 */
- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"%@",error);
    
}

@end
