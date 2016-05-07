//
//  YMRecommandUser.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/13.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMRecommandUser : NSObject
/**
 *  头像
 */
@property (nonatomic, copy) NSString *header;
/**
 *  粉丝数
 */
@property (nonatomic, assign) NSInteger fans_count;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *screen_name;

@end
