//
//  LabelDB.h
//  StarWardrobe
//
//  Created by qianfeng on 16/11/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//关注的标签数据库

@interface LabelDB : NSObject


+ (instancetype)share;

- (NSArray *)findAll;

- (BOOL)isExists:(List *)model;

- (void)insert:(List *)model;

- (void)deleteAll;

-(void)deleteModel:(List *)model;


@end
