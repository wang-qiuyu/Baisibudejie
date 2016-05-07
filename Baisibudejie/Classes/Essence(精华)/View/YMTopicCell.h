//
//  YMTopicCell.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/16.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMTopic;

@interface YMTopicCell : UITableViewCell

/** topic*/
@property (nonatomic, strong) YMTopic *topic;

+(instancetype)cell;

@end
