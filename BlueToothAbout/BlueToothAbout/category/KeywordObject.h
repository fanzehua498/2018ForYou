//
//  KeywordObject.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/20.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeywordObject : NSObject

//nonnull:不能为空 (用来修饰属性，或者方法的参数，方法的返回值)
//三种使用方法 不适应与assign属性，nonnull用来专门修饰指针
@property(copy,nonatomic,nonnull)NSString *name;
@property(copy,nonatomic)NSString *_Nonnull name1;
@property(copy,nonatomic)NSString * __nonnull name2;

NS_ASSUME_NONNULL_BEGIN
//定义在此中间的属性和方法都默认为nonnull
@property(copy,nonatomic)NSString *name3;

NS_ASSUME_NONNULL_END
//两张定义一样的效果
- (nullable NSString *)nuAbleString:(nonnull NSString *)name;
- (NSString * _Nonnull)nuAbleString2:(NSString *_Nonnull)name;



@end
