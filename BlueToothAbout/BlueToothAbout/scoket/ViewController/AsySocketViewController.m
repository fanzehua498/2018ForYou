//
//  AsySocketViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/5.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "AsySocketViewController.h"
//#import <GCDAsyncSocket.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface AsySocketViewController ()<GCDAsyncSocketDelegate>
@property (nonatomic ,strong) GCDAsyncSocket *socket;
@end

@implementation AsySocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error;

    [self.socket connectToHost:@"192.168.0.19" onPort:8888 error:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
}
-(void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
//    [self showMessageWithStr:@"链接成功"];
    self.title = [NSString stringWithFormat:@"链接成功 服务器IP: %@ 端口: %d", host,port];
//    [self showMessageWithStr:[NSString stringWithFormat:@"服务器IP: %@-------端口: %d", host,port]];
    
    // 连接成功开启定时器
//    [self addTimer];
    // 连接后,可读取服务端的数据
    [self.socket readDataWithTimeout:- 1 tag:0];
}

/**
 读取数据
 
 @param sock 客户端socket
 @param data 读取到的数据
 @param tag 本次读取的标记
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"text:%@",text);
    // 读取到服务端数据值后,能再次读取
    [self.socket readDataWithTimeout:- 1 tag:0];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSData *data = [@"woshinidie" dataUsingEncoding:NSUTF8StringEncoding];
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.socket writeData:data withTimeout:- 1 tag:0];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
