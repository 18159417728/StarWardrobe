//
//  SearchResultDB.h
//  PriceApp
//
//  Created by qianfeng on 16/10/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//搜索结果数据库
@interface SearchResultDB : NSObject

+ (instancetype)share;

- (NSArray *)findAll;

- (BOOL)isExists:(SearshHotWordModel *)model;

- (void)insert:(SearshHotWordModel *)model;

- (void)deleteAll;

-(void)deleteModel:(SearshHotWordModel *)model;

@end
