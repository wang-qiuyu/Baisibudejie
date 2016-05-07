//
//  YMTopicPictureView.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/20.
//  Copyright © 2016年 hrscy. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>
@class YMTopic;

@interface YMTopicPictureView : UIView

/** topic*/
@property (nonatomic, strong) YMTopic *topic;

+(instancetype)pictureView;

@end
