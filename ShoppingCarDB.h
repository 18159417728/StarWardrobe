//
//  ShoppingCarDB.h
//  StarWardrobe
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//购物车数据库

@interface ShoppingCarDB : NSObject

+ (instancetype)share;

- (NSArray *)findAll;

- (BOOL)isExists:(ShoppingFristModel *)model;

- (void)insert:(ShoppingFristModel *)model;

- (void)deleteAll;

-(void)deleteModel:(ShoppingFristModel *)model;

-(void)update:(ShoppingFristModel *)model;


@end
