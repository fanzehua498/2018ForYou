//
//  ScoketManger.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/29.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "ScoketManger.h"

@interface ScoketManger ()
{
//    int _ClientSocket;
    NSInteger recivetag;
}
@property (nonatomic, assign) int ClientSocket;
//@property(assign,nonatomic)dispatch_queue_t MsgQueue;
@end

@implementation ScoketManger

- (instancetype)init
{
    self = [super init];
    if (self) {
        /*
         1.AF_INET: ipv4 执行ip协议的版本
         2.SOCK_STREAM：指定Socket类型,面向连接的流式socket 传输层的协议
         3.IPPROTO_TCP：指定协议。 IPPROTO_TCP 传输方式TCP传输协议
         返回值 大于0 创建成功
         */
        self.ClientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    }
    return self;
}
#pragma mark -//建立连接
//建立连接
-(void)connectToServerWithBlock:(connectServerBlock)block
{
    self.callBlock = block;
//    self.MsgQueue = dispatch_queue_create("reciveData", DISPATCH_QUEUE_CONCURRENT);
    struct sockaddr_in addr;
    /* 填写sockaddr_in结构*/
    addr.sin_family = AF_INET;
    //    感觉这边端口 可以操作一下
    addr.sin_port = htons(8888);
    //ip地址  这边填地址应该也需要操作一下
    addr.sin_addr.s_addr = inet_addr("192.168.0.19");
    int connectResult = connect(self.ClientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if (connectResult == -1) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"连接失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        
        self.callBlock(NO, @"连接失败");
    }else if (connectResult == 0){
        NSLog(@"连接成功");
        
        self.callBlock(YES, @"192.168.0.19");
        [self reciveData:nil];

        NSTimer *tim = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
//            [self reciveData:nil];

//            dispatch_async(dispatch_queue_create("reciveQueue", DISPATCH_QUEUE_CONCURRENT), ^{
//                char *buf[10];
//                NSString *recvStr = [NSString string];
//                while (1) {
//                    ssize_t sizeLen = read(self.ClientSocket, buf, sizeof(buf));
//                    NSLog(@"sizeLen==%zd",sizeLen);
//                    if (sizeLen==0) {
//                        recvStr=@"";
//                        break;
//                    }
//
//                    recvStr = [recvStr stringByAppendingString:[[NSString alloc] initWithBytes:buf length:sizeLen encoding:NSUTF8StringEncoding]];
//                    NSLog(@"recvStr:%@",recvStr);
//
//
//                }
//            });
        }];
        recivetag = 0;
        [[NSRunLoop currentRunLoop] addTimer:tim forMode:NSRunLoopCommonModes];
        
    }else{
        NSLog(@"未知错误");
        self.callBlock(NO, @"未知错误");
    }
}

//建立连接
- (void)connectToServer
{
    /*
     终端里面 命令模拟服务器 netcat  nc -lk 12345
     参数一：套接字描述符
     参数二：指向数据结构sockaddr的指针，其中包括目的端口和IP地址
     参数三：参数二sockaddr的长度，可以通过sizeof（struct sockaddr）获得
     返回值 int -1失败 0 成功
     */
    struct sockaddr_in addr;
     /* 填写sockaddr_in结构*/
    addr.sin_family = AF_INET;
//    感觉这边端口 可以操作一下
    addr.sin_port = htons(8888);
    //ip地址  这边填地址应该也需要操作一下
    addr.sin_addr.s_addr = inet_addr("192.168.0.19");
    int connectResult = connect(self.ClientSocket, (const struct sockaddr *)&addr, sizeof(addr));
    if (connectResult == -1) {
      
    }else if (connectResult == 0){
        NSLog(@"连接成功");
        NSTimer *tim = [NSTimer scheduledTimerWithTimeInterval:1000.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self reciveData:nil];
            
        }];
        
        recivetag = 0;
        [[NSRunLoop currentRunLoop] addTimer:tim forMode:NSRunLoopCommonModes];
        
    }else{
        NSLog(@"未知错误");
    }
}

#pragma mark - //发送数据
-(void)sendData:(NSString *)data
{
    /*
     第一个参数指定发送端套接字描述符；
     第二个参数指明一个存放应用程式要发送数据的缓冲区；
     第三个参数指明实际要发送的数据的字符数；
     第四个参数一般置0。
     成功则返回实际传送出去的字符数，失败返回－1，
     */
//    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    const char *sends = [str cStringUsingEncoding:NSUTF8StringEncoding];
    const char *sends = data.UTF8String;
    ssize_t sendLen = send(self.ClientSocket, sends, strlen(sends), 0);
    if (sendLen) {
//        NSLog(@"%zd",sendLen);
    }
}

-(void)sendImageData:(NSData *)data
{
    NSString *st = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    const char *sends = st.UTF8String;
    ssize_t sendLen = send(self.ClientSocket, sends, strlen(sends), 0);
//    ssize_t sendLen = send(self.ClientSocket, [data bytes], strlen([data bytes]), 0);
    if (sendLen) {
        //        NSLog(@"%zd",sendLen);
    }
}


#pragma mark - 接收数据
-(void)reciveData:(NSData *)data Block:(reciveSuccessBlock)callBack
{
    self.reciveBlock = callBack;
    dispatch_async(dispatch_queue_create("reciveData", DISPATCH_QUEUE_CONCURRENT), ^{
        
        char *buf[1024];
        ssize_t recLen = recv(self.ClientSocket, buf, sizeof(buf), MSG_WAITALL);
        
        NSData *data = [NSData dataWithBytesNoCopy:buf length:recLen freeWhenDone:YES];
        
        NSString *recvStr = [[NSString alloc] initWithBytes:buf length:recLen encoding:NSUTF8StringEncoding];
        
        if (recvStr.length > 0) {
//            self.reciveBlock(YES, recvStr);
            self.block(@{@"type":@"img",@"msg":recvStr});
        }else{
//            free(buf);
//            self.reciveBlock(NO, @"未获取到数据或空数据");
        }
    });
}

- (void)reciveData:(NSData *)data
{
    /*
     第一个参数socket
     第二个参数存放数据的缓冲区
     第三个参数缓冲区长度。
     第四个参数指定调用方式,一般置0
     返回值 接收成功的字符数
     */
    dispatch_async(dispatch_queue_create("reciveData", DISPATCH_QUEUE_CONCURRENT), ^{
        @autoreleasepool{
            
            struct sockaddr_in sockaddr4;
            socklen_t sockaddr4len = sizeof(sockaddr4);
            NSDictionary *dictionary;
            while (1) {
                size_t bufSize = 65535;
                void *buf = malloc(bufSize);
                ssize_t recLen = recvfrom(self.ClientSocket, buf, bufSize, 0, (struct sockaddr *)&sockaddr4, &sockaddr4len);
                //             ssize_t recLen = recv(self.ClientSocket, buf, sizeof(buf), 0);
                if (recLen > 0)
                {
                    NSData *data = [NSData dataWithBytesNoCopy:buf length:recLen freeWhenDone:YES];
//                    dictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    NSData *jsonData = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
                    dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                    //            addr4 = [NSData dataWithBytes:&sockaddr4 length:sockaddr4len];
                    if (dictionary.count > 0) {
                        self.block(dictionary);
//                        self.block(@{@"type":@"img",@"msg":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]});
                    }
//                    self.block(@{@"type":@"img",@"msg":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]});
                }
                else
                {
     
                    free(buf);
                    break;
                }
                
            }
//            self.block(dictionary);
        }

//        char *buf[1];
//        size_t bufSize = 65535;
//        void *buf = malloc(bufSize);
//        NSString *recvStr = [NSString string];
//        ssize_t recLen = recv(self.ClientSocket, buf, sizeof(buf), 0);
//        while (1) {
//            ssize_t recLen = recv(self.ClientSocket, buf, sizeof(buf), 0);
//            recvStr = [recvStr stringByAppendingString:[[NSString alloc] initWithBytes:buf length:recLen encoding:NSUTF8StringEncoding]];
//            NSLog(@"%@,%zd",recvStr,recLen);
//            if (recLen >= 0 && recLen <= 7) {
////                close(self.ClientSocket);
////                recvStr=@"";
//                NSLog(@"final");
//
//                [self performSelectorOnMainThread:@selector(reciveData:) withObject:nil waitUntilDone:NO];
//                break;
//            }
//        }
//        if (recvStr.length > 0) {
//            self.block(recvStr);
//        }
//
       
    
    });
    
}

- (void)closeServre
{
    close(self.ClientSocket);
}

- (void)blockSuccessAction:(ScoketBlock)sBlock
{
    self.block = sBlock;
}
-(void)blockFailAction:(ScoketBlock)fBlock
{
    self.block = fBlock;
}

@end
