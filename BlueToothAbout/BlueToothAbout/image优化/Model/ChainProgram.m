//
//  ChainProgram.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/13.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "ChainProgram.h"

#import <ReactiveObjC/ReactiveObjC.h>
@implementation ChainProgram


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.add(10).add(20).add(40).add(80);
        RACSignal *sign = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 2.发送信号
            [subscriber sendNext:@(111)];
            // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                
                // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
                // 执行完Block后，当前信号就不在被订阅了。
                NSLog(@"信号被销毁");
            }];
            
        }];
        
//        sign sub
        
    }
    return self;
}

- (ChainProgram* (^)(NSInteger tag))add{
    return ^(NSInteger tag){
        return self;
    };
}
@end
