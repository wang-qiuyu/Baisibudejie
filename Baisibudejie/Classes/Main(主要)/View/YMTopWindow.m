 //
//  YMTopWindow.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/24.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMTopWindow.h"

@implementation YMTopWindow

static UIWindow *window_;

+(void)initialize {
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, SCREENW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+(void)show {
    window_.hidden = NO;
}

+(void)windowClick {
    
}

@end
