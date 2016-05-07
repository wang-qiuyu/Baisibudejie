//
//  YMVoiceView.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/7.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMTopic;

@interface YMVoiceView : UIView

/** topic*/
@property (nonatomic, strong) YMTopic *topic;

+(instancetype)voiceView;


@end
