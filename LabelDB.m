//
//  LabelDB.m
//  StarWardrobe
//
//  Created by qianfeng on 16/11/16.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "LabelDB.h"

@implementation LabelDB{
    

FMDatabase *_db;

}

+ (instancetype)share
{
    static LabelDB *single = nil;
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
        
        NSString *sql = @"create table if not exists LabelTable (id integer primary key not null, tag text)";
        
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
    
    NSString *sql = @"select * from LabelTable";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    while ([set next]) {
        List *list = [[List alloc]init];
        list.tag = [set stringForColumn:@"tag"];
        list.id = [set stringForColumn:@"id"];
        [result addObject:list];
    }
    
    return result;
}

- (BOOL)isExists:(List *)model
{
    NSString *sql = @"select * from LabelTable where tag = ?";
    
    FMResultSet *set = [_db executeQuery:sql, model.tag];
    
    // 如果next后有值表示已经存在
    return [set next];
}

- (void)insert:(List *)model
{
    NSString *sql = @"insert into LabelTable (tag , id) values (?, ?)";
    
    if (![_db executeUpdate:sql, model.tag , model.id]) {
        NSLog(@"插入失败!");
    }
        NSLog(@"%@",NSHomeDirectory());
}

-(void)deleteAll{
    NSString *sql = @"delete from LabelTable ";
    
    if (![_db executeUpdate:sql]) {
        NSLog(@"删除失败!");
    }
}

-(void)deleteModel:(List *)model{
    
    NSString *sql = @"delete from LabelTable where tag = ?";
    
    if (![_db executeUpdate:sql,model.tag]) {
        
        NSLog(@"删除失败!");
    }
}

@end
