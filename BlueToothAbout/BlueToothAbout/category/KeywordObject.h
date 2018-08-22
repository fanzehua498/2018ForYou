//
//  KeywordObject.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/20.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeywordObject : NSObject

#pragma mark - nonnull
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
- (nonnull NSString *)noAbleString:(nonnull NSString *)name;
- (NSString * _Nonnull)noAbleString2:(NSString *_Nonnull)name;

#pragma mark - nullable
//表示可以为空
@property(copy,nonatomic,nullable)NSString *name4;
@property(copy,nonatomic)NSString *_Nullable name5;
@property(copy,nonatomic)NSString *__nullable name6;

- (nullable NSString *)nullableStrig:(nullable NSString *)name;
- (NSString * _Nullable)nullableString2:(NSString *_Nullable)name;

#pragma mark - null_resettable
//get可以返回空，set不可以。(必须重写get或者set方法，处理值为空的情况)
@property(copy,nonatomic,null_resettable)NSString *name7;


#pragma mark - null_unspecified
//不确定是否为空
@property(copy,nonatomic)NSString *_Null_unspecified name8;
@property(copy,nonatomic,null_unspecified)NSString *name9;
@property(copy,nonatomic)NSString *__null_unspecified name10;


#pragma mark - 读写
/**
     readwrite:默认属性 同时生产setter，getter方法
                如果使用@synthesize关键字，setter、getter方法都会被解析
 
     readonly:只读属性 只产生getter方法，没有setter （不可赋值）
              如果使用@synthesize关键字，getter方法被解析。
 */
#pragma mark - 内存管理
#pragma mark - copy
/**
    1.浅拷贝：指针的复制，只是多了一个指向这块内存的指针。
    2.深拷贝：内存的复制
    copy与strong使用 主要针对可变不可变 mutable有差异 可变需要使用strong,copy进行深拷贝将不指向原对象(比如 NSMutableArray 进行删除等操作 报unrecognized selector 错误) (给属性赋值时调用对象的copy方法 把一个不可变集合赋值给一个可变集合必然报错)
 
 */

#pragma mark - strong
/**
    strong：在arc下等同于retain，声明属性的默认关键字 (对对象浅拷贝)
 */

#pragma mark - assign
/**
     基础数据类型使用（NSInteger CGFloat）C:int,float,double,char
 */

#pragma mark - weak
/**
 对象销毁之后自动置nil (assign会出现野指针)防止野指针 避免循环引用（weak表自动释放的对象）一般在代理使用中使用
 */

#pragma mark - 线程安全
/**
     nonatomic:非原子性访问对于属性赋值的时候不加锁，多线程并发访问会提高性能，如果不加此属性默认是两个访问方法都为原子型事务访问
     atomic:和 nonatomic用来决定编译器生成的getter和setter是否为原子操作，atomic 设置成员变量的@property属性时  默认为是atomic 提供线程安全。
 */


#pragma mark - 补充 -- weak，__unsafe_unretained, unowned 与 assign区别
/**
     __unsafe_unretained: 不会对对象进行retain,当对象销毁时,会依然指向之前的内存空间(野指针)
 
     weak: 不会对对象进行retain,当对象销毁时,会自动指向nil
 
     assign: 实质与__unsafe_unretained等同
 
     unsafe_unretained也可以修饰代表简单数据类型的property，weak也不能修饰用来代表简单数据类型的property。
 
     __unsafe_unretained 与 weak 比较，使用 weak 是有代价的，因为通过上面的原理可知，__weak需要检查对象是否已经消亡，而为了知道是否已经消亡，自然也需要一些信息去跟踪对象的使用情况。也正因此，__unsafe_unretained 比 __weak快,所以当明确知道对象的生命期时，选择__unsafe_unretained 会有一些性能提升，这种性能提升是很微小的。但当很清楚的情况下，__unsafe_unretained 也是安全的，自然能快一点是一点。而当情况不确定的时候，应该优先选用 __weak 。
 
     unowned使用在Swift中，也会分 weak 和 unowned。unowned 的含义跟 __unsafe_unretained 差不多。假如很明确的知道对象的生命期，也可以选择 unowned。
 
 */

@end
