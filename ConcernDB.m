//
//  ConcernDB.m
//  StarWardrobe
//
//  Created by qianfeng on 16/11/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "ConcernDB.h"

@implementation ConcernDB{
    
    FMDatabase *_db;
    
}

+ (instancetype)share
{
    static ConcernDB *single = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
    
    return single;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _db = [FMDatabase databaseWithPath:kDataDB];
        
        NSString *sql = @"create table if not exists ConcernTable (id integer primary key not null, userId text, userName text, icon text)";
        
        [_db open];
        
        if (![_db executeUpdate:sql]) {
            NSLog(@"建表失败！");
        }
    }
    return self;
}

- (NSArray *)findAll
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *sql = @"select * from ConcernTable";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    while ([set next]) {
        
        UserModel *model = [[UserModel alloc]init];
        model.userId = [set stringForColumn:@"userId"];
        model.userName = [set stringForColumn:@"userName"];
        model.icon = [set stringForColumn:@"icon"];

        [result addObject:model];
    }
    
    return result;
}

- (BOOL)isExists:(NSString *)userId
{
    NSString *sql = @"select * from ConcernTable where userId = ?";
    
    FMResultSet *set = [_db executeQuery:sql, userId];
    
    // 如果next后有值表示已经存在
    return [set next];
}

- (void)insert:(UserModel *)model
{
    NSString *sql = @"insert into ConcernTable (userId, userName, icon) values (?, ?, ?)";
    
    if (![_db executeUpdate:sql, model.userId,model.userName,model.icon]) {
        NSLog(@"插入失败!");
    }
//        NSLog(@"%@",NSHomeDirectory());
}

-(void)deleteAll{
    NSString *sql = @"delete from ConcernTable ";
    
    if (![_db executeUpdate:sql]) {
        NSLog(@"删除失败!");
    }
}

-(void)deleteModel:(UserModel *)model{
    
    NSString *sql = @"delete from ConcernTable where userId = ?";
    
    if (![_db executeUpdate:sql,model.userId]) {
        
        NSLog(@"删除失败!");
    }
}

@end
