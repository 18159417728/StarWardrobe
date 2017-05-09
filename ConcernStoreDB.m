//
//  ConcernStoreDB.m
//  StarWardrobe
//
//  Created by apple on 2017/4/9.
//  Copyright © 2017年 qianfeng. All rights reserved.
//

#import "ConcernStoreDB.h"

@implementation ConcernStoreDB
{
    
    
    FMDatabase *_db;
    
}

+ (instancetype)share
{
    static ConcernStoreDB *single = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        single = [[self alloc] init];
    });
    
    return single;
}

- (instancetype)init
{
    if (self = [super init]) {
        
      _db = [FMDatabase databaseWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"ConcernStoreDBData.db"]];
        NSString *sql = @"create table if not exists ConcernStoreTable (id integer primary key not null, business_name text, business_id text,business_brief text, business_image text, detailUrl text,english_name text, search_keyword text, business_banner_url text, brand_title text)";
 
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
    
    NSString *sql = @"select * from ConcernStoreTable";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    while ([set next]) {
        shoppingStoreModel *model = [[shoppingStoreModel alloc]init];
        model.business_name = [set stringForColumn:@"business_name"];
        model.business_id = [set stringForColumn:@"business_id"];
        model.business_brief = [set stringForColumn:@"business_brief"];
        model.business_image = [set stringForColumn:@"business_image"];
        model.detailUrl = [set stringForColumn:@"detailUrl"];
        model.english_name = [set stringForColumn:@"english_name"];
        model.search_keyword = [set stringForColumn:@"search_keyword"];
        model.business_banner_url = [set stringForColumn:@"business_banner_url"];
        model.brand_title = [set stringForColumn:@"brand_title"];
        [result addObject:model];
    }
    
    return result;
}

- (BOOL)isExists:(shoppingStoreModel *)model
{
    NSString *sql = @"select * from ConcernStoreTable where business_id = ?";
    
    FMResultSet *set = [_db executeQuery:sql, model.business_id];
    
    // 如果next后有值表示已经存在
    return [set next];
}

- (void)insert:(shoppingStoreModel *)model
{
    NSString *sql = @"insert into ConcernStoreTable (business_name, business_id, business_brief, business_image, detailUrl, english_name, search_keyword, business_banner_url, brand_title) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    if (![_db executeUpdate:sql, model.business_name,model.business_id, model.business_brief, model.business_image,model.detailUrl,model.english_name,model.search_keyword,model.business_banner_url,model.brand_title]) {
        NSLog(@"插入失败!");
    }
//    NSLog(@"%@",NSHomeDirectory());
}

-(void)deleteAll{
    NSString *sql = @"delete from ConcernStoreTable ";
    
    if (![_db executeUpdate:sql]) {
        NSLog(@"删除失败!");
    }
}

-(void)deleteModel:(shoppingStoreModel *)model{
    
    NSString *sql = @"delete from ConcernStoreTable where business_id = ?";
    
    if (![_db executeUpdate:sql,model.business_id]) {
        
        NSLog(@"删除失败!");
    }
}
@end
