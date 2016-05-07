//
//  YMVideoView.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/3/8.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMTopic;

@interface YMVideoView : UIView

/** topic*/
@property (nonatomic, strong) YMTopic *topic;

+(instancetype)videoView;

@end
