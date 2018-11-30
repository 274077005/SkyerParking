//
//  main.m
//  SkyerParking
//
//  Created by admin on 2018/6/28.
//  Copyright © 2018年 www.skyer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>
#include <stdlib.h>

static int is_debugger_present(void)
{
    int name[4];
    struct kinfo_proc info;
    size_t info_size = sizeof(info);
    
    info.kp_proc.p_flag = 0;
    
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    
    if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
        exit(-1);
    }
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        //添加反调试代码,防逆向工程调试.添加反代码注入等
//        fflush(stdout);
//        while (1)
//        {
//            sleep(1);
//            if (is_debugger_present())
//            {
//                return -1;
//            }
//            fflush(stdout);
//        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
