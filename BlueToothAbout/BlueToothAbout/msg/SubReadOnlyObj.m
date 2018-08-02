//
//  SubReadOnlyObj.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/19.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//
#import <objc/message.h>
#import "SubReadOnlyObj.h"
#import "ForWardObj.h"
#import "MsgInvocation.h"
@implementation SubReadOnlyObj
//- (void)ObjAction
//{
//    NSLog(@"我是子类方法--%s",__func__);
//}
void dynamicAdditionMethodIMP(id self, SEL _cmd)
{
    NSLog(@"dynamicAdditionMethodIMP");
}

/** 找不到类方法  */
+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(ObjActionClass)) {
        class_addMethod(objc_getMetaClass("SubReadOnlyObj"), sel, (IMP)dynamicAdditionMethodIMP, "v@:");
        return YES;
    }
    NSLog(@"resolveClassMethod: %@", NSStringFromSelector(sel));
    return [super resolveClassMethod:sel];
}

/** 第一次挽救机会  */
/** 找不到对象方法调  */
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(ObjAction)) {
        class_addMethod([self class], sel, (IMP)dynamicAdditionMethodIMP, "v@:");
        return YES;
    }
    NSLog(@"Instance: %@", NSStringFromSelector(sel));
    return [super resolveInstanceMethod:sel];
}

//-(void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    
//}

//+(void)ObjActionClass
//{
//    NSLog(@"objClassAction");
//}


/** 第二次机会: 备援接收者
 当对象所属类不能动态添加方法后，runtime就会询问当前的接受者是否有其他对象可以处理这个未知的selector
 */
-(id)forwardingTargetForSelector:(SEL)aSelector
{
//    if (aSelector == @selector(ObjActionClassaa)) {
//        return [ForWardObj new];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

/** 第三次机会: 消息重定向
当没有备援接收者时，就只剩下最后一次机会，那就是消息重定向。这个时候runtime会将未知消息的所有细节都封装为NSInvocation对象
 */
-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    ForWardObj *inv = [[ForWardObj alloc] init];
    
    if ([inv respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:inv];
    }else{
       [super forwardInvocation: anInvocation];
    }
    
//    if ([MsgInvocation instancesRespondToSelector:anInvocation.selector]) {
//        [anInvocation invokeWithTarget:[MsgInvocation new]];
//    }
}

/* 必须重新这个方法，消息转发机制使用从这个方法中获取的信息来创建NSInvocation对象 返回nil上面方法不执行 */
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
 
    if (!sig) {
        if ([MsgInvocation instancesRespondToSelector:aSelector]) {
            sig = [MsgInvocation instanceMethodSignatureForSelector:aSelector];
        }
    }else{
        
    }
    return sig;
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"不存在：%@",NSStringFromSelector(aSelector));
}

@end
