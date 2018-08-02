//
//  ReadOnlyObj.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/19.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "ReadOnlyObj.h"

@implementation ReadOnlyObj

-(instancetype)init
{
    self = [super init];
    if (self) {
        _read = @"初始化";
    }
    return self;
}

-(void)setRead:(NSString *)read
{
    _read = read;
//    NSLog(@"read:%@",read);
}

-(NSString *)setpro
{
    return @"normolSet";
}

- (NSString *)isPro{
    return @"setterSet";
}

//+(void)ObjActionClass
//{
//    NSLog(@"我是父类方法 objClassAction");
//}

//- (void)ObjAction
//{
//    NSLog(@"我是父类方法--%s",__func__);
//}
@end
