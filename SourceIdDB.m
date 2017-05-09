//
//  SourceIdDB.m
//  StarWardrobe
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "SourceIdDB.h"

@implementation SourceIdDB{
    
    FMDatabase *_db;
    
}

+ (instancetype)share
{
    static SourceIdDB *single = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
//    NSLog(@"%@",NSHomeDirectory());
    return single;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _db = [FMDatabase databaseWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"sourceData.db"]];
        
        NSString *sql = @"create table if not exists SourceTable (id integer primary key not null,sourceId text, name text )";
        
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
    
    NSString *sql = @"select * from SourceTable";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    while ([set next]) {
        FashionCellDetailModel *model = [[FashionCellDetailModel alloc]init];
        model.sourceId = [set stringForColumn:@"sourceId"];
        model.text = [set stringForColumn:@"name"];
        [result addObject:model];
    }
    
    return result;
}

-(BOOL)isExists:(FashionCellDetailModel *)model
{
    NSString *sql = @"select * from SourceTable where sourceId = ?";
    
    FMResultSet *set = [_db executeQuery:sql, model.sourceId];
    
    // 如果next后有值表示已经存在
    return [set next];
}

-(void)insert:(FashionCellDetailModel *)model{
    NSString *sql = @"insert into SourceTable (sourceId , name) values (? , ?)";
    
    if (![_db executeUpdate:sql, model.sourceId,model.text]) {
        NSLog(@"插入失败!");
    }
}

-(void)deleteAll{
    NSString *sql = @"delete from SourceTable ";
    
    if (![_db executeUpdate:sql]) {
        NSLog(@"删除失败!");
    }
}

-(void)deleteModel:(FashionCellDetailModel *)model
{
    NSString *sql = @"delete from SourceTable where sourceId = ?";
    
    if (![_db executeUpdate:sql,model.sourceId]) {
        
        NSLog(@"删除失败!");
    }
}



@end
