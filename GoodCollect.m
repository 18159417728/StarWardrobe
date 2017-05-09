//
//  GoodCollect.m
//  StarWardrobe
//
//  Created by apple on 2017/3/30.
//  Copyright © 2017年 qianfeng. All rights reserved.
//

#import "GoodCollect.h"

@implementation GoodCollect
{
    
    FMDatabase *_db;
    
}

+ (instancetype)share
{
    static GoodCollect *single = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
    
    return single;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _db = [FMDatabase databaseWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"goodCollectData.db"]];
        
        NSString *sql = @"create table if not exists GoodCollectTable (id integer primary key not null,picUrl text , desc text, count text, origin_price text , price text, nationalFlag text, country text)";
        
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
    
    NSString *sql = @"select * from GoodCollectTable";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    while ([set next]) {
        ShoppingFristModel *model = [[ShoppingFristModel alloc]init];
        model.picUrl = [set stringForColumn:@"picUrl"];
        model.sourceId = [set stringForColumn:@"id"];
        model.desc = [set stringForColumn:@"desc"];
        model.count = [set stringForColumn:@"count"];
        model.origin_price = [set stringForColumn:@"origin_price"];
        model.price = [set stringForColumn:@"price"];
        model.nationalFlag = [set stringForColumn:@"nationalFlag"];
        model.country = [set stringForColumn:@"country"];
        [result addObject:model];
    }
    
    return result;
}

-(BOOL)isExists:(ShoppingFristModel *)model
{
    NSString *sql = @"select * from GoodCollectTable where id = ?";
    
    FMResultSet *set = [_db executeQuery:sql, model.sourceId];
    
    // 如果next后有值表示已经存在
    return [set next];
}

-(void)insert:(ShoppingFristModel *)model{
    NSString *sql = @"insert into GoodCollectTable (id, picUrl, desc, count, origin_price, price,nationalFlag,country) values (?, ?, ?, ?, ?, ?, ?, ?)";
    
    if (![_db executeUpdate:sql, model.sourceId, model.picUrl, model.desc,@"1", model.origin_price, model.price,model.nationalFlag,model.country]) {
        NSLog(@"插入失败!");
    }
    //    NSLog(@"%@",NSHomeDirectory());
}

-(void)deleteAll{
    NSString *sql = @"delete from GoodCollectTable ";
    
    if (![_db executeUpdate:sql]) {
        NSLog(@"删除失败!");
    }
}

-(void)deleteModel:(ShoppingFristModel *)model
{
    NSString *sql = @"delete from GoodCollectTable where id = ?";
    
    if (![_db executeUpdate:sql,model.sourceId]) {
        
        NSLog(@"删除失败!");
    }
}

-(void)update:(ShoppingFristModel *)model{
    
    NSString *sql = @"update GoodCollectTable set count = ? where id = ?";
    
    if (![_db executeUpdate:sql,model.count, model.sourceId]) {
        
        NSLog(@"修改失败");
    }
}
@end
