//
//  USEVC.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/2.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "USEVC.h"

typedef void(^MyBlock)(void *, size_t);
typedef void (*work)(void * );
typedef void (*hwcTestForGCD)(void*);
hwcTestForGCD getFuncPointer();


void realFunction(void *input)
{
    for(int i = 0;i < 5;i++)
    {
        printf("%d\n",i);
        sleep(1);
    }
}
hwcTestForGCD getFuncPointer()
{
    return realFunction;
    
}
__weak NSString *weak_String = nil;
@interface USEVC ()

@end

@implementation USEVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear:%@",weak_String);
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear:%@",weak_String);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *string = [NSString stringWithFormat:@"leichunfeng"];
    
//    weak_String = string;

        @autoreleasepool {
    
            NSString *string = [NSString stringWithFormat:@"leichunfeng"];
    
            weak_String = string;
            
    
        }
//    [self apply];
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);

    dispatch_async(dispatch_queue_create("aaaaaaaa", 0), ^{
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        for (int i = 0; i < 10; i ++) {
            NSLog(@"我是aaaa%d号",i);
            sleep(1);
            NSLog(@"我是aaaaa%d号",i);
        }
        NSLog(@"aaa完成");
        
        dispatch_semaphore_signal(sema);
    });
    
    
    
    dispatch_async(dispatch_queue_create("bbbbbb", 0), ^{
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        for (int i = 10; i < 20; i ++) {
            NSLog(@"我是bbbbbb%d号",i);
            sleep(1);
            NSLog(@"我是bbbbbb%d号",i);
        }
        NSLog(@"bbbb完成");
        dispatch_semaphore_signal(sema);
    });
    
}


- (void)codeLockName:(NSString *)codeLockName codeFragment:(void(^)(void))codeFragment {
    if (codeLockName.length <= 0) {
        return;
    }
    
//    NSString *lockNameKey = [NSString stringWithFormat:@"%zi",codeLockName.hash];
    NSString *lockNameKey = [NSString stringWithFormat:@"%@",codeLockName];
    NSMutableDictionary *semaphoreDict = [self semaphoreDictionary];
    dispatch_semaphore_t semaphore_t = semaphoreDict[lockNameKey];
    if (semaphore_t == nil) {
        semaphore_t = dispatch_semaphore_create(1);
        semaphoreDict[lockNameKey] = semaphore_t;
    }
    
    
    dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
    
    if (codeFragment) {
        codeFragment();
    }
    
    dispatch_semaphore_signal(semaphore_t);
}

-(NSMutableDictionary<NSString *,dispatch_semaphore_t> *)semaphoreDictionary {
    static NSMutableDictionary<NSString *,dispatch_semaphore_t>  *instanceSemaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceSemaphore = [[NSMutableDictionary<NSString *,dispatch_semaphore_t> alloc] init];
    });
    
    return instanceSemaphore;
}

- (void)apply
{
    /**
     @param size_t iterations 反复次数
     @param queue 执行线程
     @param block 执行操作
     */
    
    dispatch_queue_t queue = dispatch_queue_create("com.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_apply(10, queue, ^(size_t index) {
//        dispatch_queue_t qqqq = dispatch_queue_create("com.aaaa", DISPATCH_QUEUE_CONCURRENT);
//        dispatch_async(qqqq, ^{
//            for (int i = 0; i < 20; i ++) {
//                NSLog(@"i==========%d",i);
//            }
////            NSLog(@"aaaaaa");
//            NSLog(@"============%ld==============",index);
//        });
//    });
    
    MyBlock block = ^(void *p,size_t t){
        NSLog(@"block来了");
    };
  
//    dispatch_apply_f(<#size_t iterations#>, <#dispatch_queue_t  _Nonnull queue#>, <#void * _Nullable context#>, void (* _Nonnull work)(void * _Nullable, size_t))
    dispatch_apply_f(10, queue, &block, getFuncPointer());
//    dispatch_apply_f(10, queue, 0, void (* _Nonnull work)(void * _Nullable, 10));
    
//    dispatch_sync_f(<#dispatch_queue_t  _Nonnull queue#>, <#void * _Nullable context#>, <#dispatch_function_t  _Nonnull work#>)
}

void* aaa (void * bb,size_t t){
    NSLog(@"我是 aaaa");
    return bb;
}



-(void)dispatchSignal{
    //crate的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
}


@end
