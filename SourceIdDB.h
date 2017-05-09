//
//  SourceIdDB.h
//  StarWardrobe
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//点击立即购买时的假数据，

@interface SourceIdDB : NSObject

+ (instancetype)share;

- (NSArray *)findAll;

- (BOOL)isExists:(FashionCellDetailModel *)model;

- (void)insert:(FashionCellDetailModel *)model;

- (void)deleteAll;

-(void)deleteModel:(FashionCellDetailModel *)model;


@end
