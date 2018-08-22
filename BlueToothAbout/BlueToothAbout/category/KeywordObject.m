//
//  KeywordObject.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/20.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "KeywordObject.h"

@implementation KeywordObject

#pragma mark - nonnull
- (nonnull NSString *)noAbleString:(nonnull NSString *)name{
    return @"zh";
}
- (NSString * _Nonnull)noAbleString2:(NSString *_Nonnull)name{
    return @"zh";
}

#pragma mark - nullable
- (nullable NSString *)nullableStrig:(nullable NSString *)name{
    return nil;
}
- (NSString * _Nullable)nullableString2:(NSString *_Nullable)name
{
    return nil;
}

#pragma mark - 重写其中一个
//-(void)setName7:(NSString *)name7
//{
//    if (name7 == nil) {
//        name7 = @"空的";
//    }
//    _name7 = name7;
//}
- (NSString *)name7
{
    if (_name7 == nil) {
        _name7 = @"空空空";
    }
    return _name7;
}

@end
