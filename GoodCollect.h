//
//  GoodCollect.h
//  StarWardrobe
//
//  Created by apple on 2017/3/30.
//  Copyright © 2017年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//商品收藏数据库

@interface GoodCollect : NSObject

+ (instancetype)share;

- (NSArray *)findAll;

- (BOOL)isExists:(ShoppingFristModel *)model;

- (void)insert:(ShoppingFristModel *)model;

- (void)deleteAll;

-(void)deleteModel:(ShoppingFristModel *)model;

-(void)update:(ShoppingFristModel *)model;

@end
