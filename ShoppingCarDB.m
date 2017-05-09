//
//  ShoppingCarDB.m
//  StarWardrobe
//
//  Created by qianfeng on 16/11/23.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "ShoppingCarDB.h"

@implementation ShoppingCarDB{
    
    FMDatabase *_db;
    
}

+ (instancetype)share
{
    static ShoppingCarDB *single = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
    
    return single;
}

- (instancetype)init
{
    
    if (self = [super init]) {
        
        _db = [FMDatabase databaseWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"shoppingcarData.db"]];
        
        NSString *sql = @"create table if not exists ShoppingcarTable (id integer primary key not null,picUrl text , desc text, count text, origin_price text , price text , selectState bool)";
        
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
    
    NSString *sql = @"select * from ShoppingcarTable";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    while ([set next]) {
        ShoppingFristModel *model = [[ShoppingFristModel alloc]init];
        model.picUrl = [set stringForColumn:@"picUrl"];
        model.sourceId = [set stringForColumn:@"id"];
        model.desc = [set stringForColumn:@"desc"];
        model.count = [set stringForColumn:@"count"];
        model.origin_price = [set stringForColumn:@"origin_price"];
        model.price = [set stringForColumn:@"price"];
        model.selectState = [set boolForColumn:@"selectState"];
        [result addObject:model];
    }
    
    return result;
}

-(BOOL)isExists:(ShoppingFristModel *)model
{
    NSString *sql = @"select * from ShoppingcarTable where id = ?";
    
    FMResultSet *set = [_db executeQuery:sql, model.sourceId];
    
    // 如果next后有值表示已经存在
    return [set next];
}

-(void)insert:(ShoppingFristModel *)model{
    NSString *sql = @"insert into ShoppingcarTable (id, picUrl, desc, count, origin_price, price,selectState) values (?, ?, ?, ?, ?, ? ,?)";
    
    if (![_db executeUpdate:sql, model.sourceId, model.picUrl, model.desc,@"1", model.origin_price, model.price,model.selectState]) {
        NSLog(@"插入失败!");
    }
    //    NSLog(@"%@",NSHomeDirectory());
}

-(void)deleteAll{
    NSString *sql = @"delete from ShoppingcarTable ";
    
    if (![_db executeUpdate:sql]) {
        NSLog(@"删除失败!");
    }
}

-(void)deleteModel:(ShoppingFristModel *)model
{
    NSString *sql = @"delete from ShoppingcarTable where id = ?";
    
    if (![_db executeUpdate:sql,model.sourceId]) {
        
        NSLog(@"删除失败!");
    }
}

-(void)update:(ShoppingFristModel *)model{
    
    NSString *sql = @"update ShoppingcarTable set count = ? where id = ?";
    
    if (![_db executeUpdate:sql,model.count, model.sourceId]) {
        
        NSLog(@"修改失败");
    }
}



@end
