//
//  SearchResultDB.m
//  PriceApp
//
//  Created by qianfeng on 16/10/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "SearchResultDB.h"

@implementation SearchResultDB{
    
    FMDatabase *_db;

}
+ (instancetype)share
{
    static SearchResultDB *single = nil;
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
        
        NSString *sql = @"create table if not exists SearchResultTable (id integer primary key not null, name text)";
        
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
    
    NSString *sql = @"select * from SearchResultTable";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    while ([set next]) {
        
        SearshHotWordModel *model = [[SearshHotWordModel alloc] init];
        model.text = [set stringForColumn:@"name"];
        [result addObject:model];
    }
    
    return result;
}

- (BOOL)isExists:(SearshHotWordModel *)model
{
    NSString *sql = @"select * from SearchResultTable where name = ?";
    
    FMResultSet *set = [_db executeQuery:sql, model.text];
    
    // 如果next后有值表示已经存在
    return [set next];
}

- (void)insert:(SearshHotWordModel *)model
{
    NSString *sql = @"insert into SearchResultTable (name) values (?)";
    
    if (![_db executeUpdate:sql, model.text]) {
        NSLog(@"插入失败!");
    }
//    NSLog(@"%@",NSHomeDirectory());
}

-(void)deleteAll{
    NSString *sql = @"delete from SearchResultTable ";
    
    if (![_db executeUpdate:sql]) {
        NSLog(@"删除失败!");
    }
}

-(void)deleteModel:(SearshHotWordModel *)model{
    
    NSString *sql = @"delete from SearchResultTable where name = ?";
    
    if (![_db executeUpdate:sql,model.text]) {
        
        NSLog(@"删除失败!");
    }
}

@end
