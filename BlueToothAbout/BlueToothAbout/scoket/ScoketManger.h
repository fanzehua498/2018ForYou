//
//  ScoketManger.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/29.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark - socket客户端编程导入头文件
#import <arpa/inet.h>
#import <netinet/in.h>
#import <sys/socket.h>

typedef void(^ScoketBlock)(NSDictionary *success);

//连接服务器block
typedef void(^connectServerBlock)(BOOL success,NSString *callMsg);
//接收数据block
typedef void(^reciveSuccessBlock)(BOOL success,NSString *msg);

@interface ScoketManger : NSObject

@property(copy,nonatomic)connectServerBlock callBlock;
@property (nonatomic, copy) reciveSuccessBlock reciveBlock;


@property(copy,nonatomic)ScoketBlock block;



- (void)blockSuccessAction:(ScoketBlock )sBlock;
- (void)blockFailAction:(ScoketBlock )fBlock;

/**
 * 连接服务器
 */
- (void)connectToServer;
- (void)connectToServerWithBlock:(connectServerBlock )block;
/**
 * 发送文字数据
 */
- (void)sendData:(NSString *)data;
//发送图片数据
- (void)sendImageData:(NSData *)data;

/**
 * 接收数据
 */
- (void)reciveData:(NSData *)data;
- (void)reciveData:(NSData *)data Block:(reciveSuccessBlock )callBack;
/**
 * 关闭连接
 */
- (void)closeServre;

- (void)listenConect;

@end
