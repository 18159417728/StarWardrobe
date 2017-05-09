//
//  ConcernDB.h
//  StarWardrobe
//
//  Created by qianfeng on 16/11/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

//关注的人和“时尚圈关注”数据库
@interface ConcernDB : NSObject

+ (instancetype)share;

- (NSArray *)findAll;

- (BOOL)isExists:(NSString *)userId;

- (void)insert:(UserModel *)model;

- (void)deleteAll;

-(void)deleteModel:(UserModel *)model;




@end
