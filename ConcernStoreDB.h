//
//  ConcernStoreDB.h
//  StarWardrobe
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//关注的品牌

@interface ConcernStoreDB : NSObject

+ (instancetype)share;

- (NSArray *)findAll;

- (BOOL)isExists:(shoppingStoreModel *)model;

- (void)insert:(shoppingStoreModel *)model;

- (void)deleteAll;

-(void)deleteModel:(shoppingStoreModel *)model;

@end
