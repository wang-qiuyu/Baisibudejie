//
//  YMRecommandCategory.h
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/13.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMRecommandCategory : NSObject
/**
 *  id
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  总数
 */
@property (nonatomic, assign) NSNumber *count;

/**
 *  这个类别对应的数据
 */
@property (nonatomic, strong) NSMutableArray *users;
/**
 *  总数
 */
@property (nonatomic, assign) NSNumber *total;
/**
 *  总页数
 */
@property (nonatomic, assign) NSNumber *total_page;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;

@end
