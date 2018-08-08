//
//  DataManger.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/28.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "DataManger.h"

#define kPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
@interface DataManger ()
{
    FMDatabase *_dataBase;
}
@end

@implementation DataManger

+ (instancetype)shareManager
{
    
    static DataManger *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[super allocWithZone:nil] init];
        }
    });
    return manager;
}

- (void)createDataBase
{
    _dataBase = [[FMDatabase alloc] initWithPath:[kPath stringByAppendingString:@"xasknjkz.sql"]];
    if ([_dataBase open]) {
        BOOL result = [_dataBase executeUpdate:@"create table if not exists Person(id )"];
    }
}

@end
