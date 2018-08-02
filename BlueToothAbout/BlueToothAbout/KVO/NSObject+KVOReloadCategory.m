//
//  NSObject+KVOReloadCategory.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/18.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "NSObject+KVOReloadCategory.h"
#import <objc/message.h>
static NSString *const KVOPrefix = @"ZHKVO_";
static NSString *const KVOAssiociateKey = @"KVO_AssiociateKey";

@implementation NSObject (KVOReloadCategory)

- (void)ZH_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    
    //1 判断keypath是否存在
    SEL setterSelector = NSSelectorFromString(keyPath);
    Class surperClass = object_getClass(self);
    Method setterMethod = class_getInstanceMethod(surperClass, setterSelector);
    //验证无setter方法 提示 keypath是否存在
    if (!setterMethod) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%@:not this %@ setter method",self,keyPath] userInfo:nil];
    }
    //2 动态创建kvo_类
    NSString *surperCalssName = NSStringFromClass(surperClass);
    Class newClass;
    if (![surperCalssName hasPrefix:KVOPrefix]) {
        
        //创建类替换父类
//        newClass
        object_setClass(self, newClass);
    }
    
    
}

@end
