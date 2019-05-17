//
//  ZHZombieProxy.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/8.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "ZHZombieProxy.h"

@interface ZHZombieProxy ()



@end

@implementation ZHZombieProxy

+(instancetype)proxyWithObj:(id)obj
{
    ZHZombieProxy *proxy = [ZHZombieProxy alloc] ;
    proxy->_innerObject = obj;
    return proxy;
}

#pragma mark - 消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_innerObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([_innerObject respondsToSelector:invocation.selector]) {
        NSString *selectorName = NSStringFromSelector(invocation.selector);
        NSLog(@"before call %@",selectorName);
        
        [invocation retainArguments];//????
        
        NSMethodSignature *sig = [invocation methodSignature];
        //获取参数个数
        NSInteger cnt = [sig numberOfArguments];
        for (int i = 0; i < cnt; i ++) {
//            const char * type = [sig getArgumentTypeAtIndex:i];
//            if(strcmp(type, "@") == 0){
//                NSObject *obj;
//                [invocation getArgument:&obj atIndex:i];
//                //这里输出的是："parameter (0)'class is MyProxy"
//                //也证明了这是objc_msgSend的第一个参数
//                NSLog(@"parameter (%d)'class is %@",i,[obj class]);
//            }
//            else if(strcmp(type, ":") == 0){
//                SEL sel;
//                [invocation getArgument:&sel atIndex:i];
//                //这里输出的是:"parameter (1) is barking:"
//                //也就是objc_msgSend的第二个参数
//                NSLog(@"parameter (%d) is %@",i,NSStringFromSelector(sel));
//            }
//            else if(strcmp(type, "q") == 0){
//                int arg = 0;
//                [invocation getArgument:&arg atIndex:i];
//                //这里输出的是:"parameter (2) is int value is 4"
//                //稍后会看到我们再调用barking的时候传递的参数就是4
//                NSLog(@"");
//            }
        }
        
        //消息转发
        [invocation invokeWithTarget:_innerObject];
        const char *retType = [sig methodReturnType];
        if (strcmp(retType, "@") == 0) {
            NSObject *ret;
            [invocation getReturnValue:&ret];
            NSLog(@"return value is %@",ret);
        }
        NSLog(@"after call %@",selectorName);
        
    }
}


@end

@implementation Dog

-(NSString *)barking:(NSInteger)months
{
    return months > 3 ? @"wangwangwang" : @"eng eng";
}
@end
