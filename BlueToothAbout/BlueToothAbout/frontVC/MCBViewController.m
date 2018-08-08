//
//  MCBViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/22.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//


/**
 双方WIFI和蓝牙都没有打开：无法实现
 双方都开启蓝牙：通过蓝牙发现和传输
 双方都开启WIFI：通过WIFI Direct发现和传输，速度接近AirDrop
 双方同时开启了WIFI和蓝牙：模拟AirDrop，通过低功耗蓝牙技术扫描发现握手，然后通过WIFI Direct传输
 */


#import "MCBViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface MCBViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MCBrowserViewControllerDelegate,MCSessionDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *theImageView;

@property(strong,nonatomic)MCSession *session;

//广播
@property(strong,nonatomic)MCAdvertiserAssistant *adver;
//搜索蓝牙设备
@property(strong,nonatomic)MCBrowserViewController *mcVC;

@property(strong,nonatomic)MCPeerID *PeerID;
@end

@implementation MCBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MCPeerID *ID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
    self.session = [[MCSession alloc] initWithPeer:ID];
    self.session.delegate = self;
    self.adver = [[MCAdvertiserAssistant alloc] initWithServiceType:@"chat-files" discoveryInfo:nil session:self.session];
    [self.adver start];
    
}

- (IBAction)chooseImage:(UIButton *)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }

    UIImagePickerController *pickVc = [UIImagePickerController new];
    pickVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickVc.delegate = self;
    [self presentViewController:pickVc animated:YES completion:^{

    }];
   
}

- (IBAction)connectDevice:(UIButton *)sender {
    
    self.mcVC = [[MCBrowserViewController alloc] initWithServiceType:@"chat-files" session:self.session];
    self.mcVC.delegate = self;
//    [self.navigationController pushViewController:self.mcVC animated:YES];
    [self presentViewController:self.mcVC animated:YES completion:nil];
}

- (IBAction)postImage:(UIButton *)sender {
    
    UIImage *image = self.theImageView.image;
    NSData *data = UIImagePNGRepresentation(image);
    NSError *error;
    [self.session sendData:data toPeers:@[self.PeerID] withMode:MCSessionSendDataReliable error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
}



#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.theImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)browserViewControllerDidFinish:(nonnull MCBrowserViewController *)browserViewController {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.mcVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)browserViewControllerWasCancelled:(nonnull MCBrowserViewController *)browserViewController {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.mcVC dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary<NSString *,NSString *> *)info
{
    self.PeerID = peerID;
    NSLog(@"info:%@-- peerID:%@",info,peerID);
    return YES;
}


#pragma mark - MCSessionDelegate
-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    switch (state) {
        case MCSessionStateConnected:
            NSLog(@"链接了");
            break;
        case MCSessionStateNotConnected:
            NSLog(@"未链接");
            break;
        case MCSessionStateConnecting:
            NSLog(@"链接中。。。");
            break;
        default:
            break;
    }
    
    
    
}

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    NSLog(@"laile");
    UIImage *image = [UIImage imageWithData:data];
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.theImageView.image = image;
         NSLog(@"final");
    });
}

#pragma mark - 懒加载
//-(MCSession *)session
//{
//    if (!_session) {
//        MCPeerID *ID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
//        _session = [[MCSession alloc] initWithPeer:ID];
//    }
//    return _session;
//}


@end
