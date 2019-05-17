//
//  ModifyReadonly.m
//  BlueToothAbout
//
//  Created by rrjj on 2018/12/3.
//  Copyright © 2018 fanzehua. All rights reserved.
//

#import "ModifyReadonly.h"

@implementation ModifyReadonly

-(instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

+(BOOL)accessInstanceVariablesDirectly
{
    //返回NO可避免kvc修改readOnly属性
    
    return NO;
}

@end
