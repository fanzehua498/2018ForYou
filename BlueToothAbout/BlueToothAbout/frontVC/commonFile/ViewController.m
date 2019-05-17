//
//  ViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/17.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "ViewController.h"
#import <GameKit/GameKit.h>
#import "CoreBlueToothViewController.h"
#import "FriendsViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "DistanceUIAlertView.h"
#import "ZHPhoneTextField.h"
#import "ScoketManger.h"
#import "ChatViewController.h"
#import "AsySocketViewController.h"
#import "imageViewController.h"
#import "FingerPwdViewController.h"
#import "LocalMsgVC.h"

#import "MsgViewController.h"
#import "MVPViewController.h"
#import "USEVC.h"
#import "LineDotChangeVC.h"
#import "FactoryVC.h"

#import "lineView.h"
#import "UserHitView.h"
#import "UserSubOneView.h"
#import <SDWebImage/SDImageCache.h>

#import "ZHRefreshComponet.h"
#import "NSObject+ZHObject.h"
#import "PersonObj.h"
#import "UIView+CornerRadius.h"
#import "UIView+ZHExtension.h"
#import "ModifyReadonly.h"
#import "ZHZombieProxy.h"


#import "sortModel.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GKPeerPickerControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    NSInteger lastIndex;
    ScoketManger *manger;
    
    UIView *redView;
}
@property (weak, nonatomic) IBOutlet UIImageView *theImageView;

@property(strong,nonatomic)GKSession *session;

@property(strong,nonatomic)MCSession *sessionMC;

@property (nonatomic ,strong) ZHRefreshComponet *ref;

@property(copy,nonatomic)NSMutableArray *dadadaArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"main";
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage:)];
    self.theImageView.userInteractionEnabled = YES;
    [self.theImageView addGestureRecognizer:g];
    
    UITextField *te = [[UITextField alloc] initWithFrame:CGRectMake(100, 500, 200, 30)];
    te.delegate = self;
    te.placeholder = @"tttttt";
    [te addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    lastIndex = 0;
//    [self.view addSubview:te];
    
    NSLog(@"home:%@",NSHomeDirectory());
    manger = [[ScoketManger alloc] init];
   
    NSDictionary *dict = @{@"Id":@"123456",@"Phone":@"15300000000",@"Type":@"1",@"VerifyCode":@"k2vt",@"appkey":@"askdnzxm,cnlqwkjnm",@"sign":@"6fde8d39dae9eaf1fffcfdad174a4dac",@"timestamp":@"1530167860"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",json);
    
    [SDImageCache sharedImageCache] ;
    int result = [self lookForSingleDog:@[@1,@1,@2,@2,@3,@3,@4,@4,@5,@5,@6]];
    NSLog(@"result:%d",result);
    int a = 15;
    int b = 20;
    
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
//    NSLog(@"2=%d b=%d",a,b);
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"1"); // 任务1
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"2"); // 任务2
//        });
//        NSLog(@"3"); // 任务3
//    });
//    NSLog(@"4"); // 任务4
////    while (1) {
////    }
//    NSLog(@"5"); // 任务5
    
    
//    NSLog(@"1"); // 任务1
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"2"); // 任务2
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"3"); // 任务3
//        });
//        NSLog(@"4"); // 任务4
//    });
//    NSLog(@"5"); // 任务5
    
    
//    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1"); // 任务1
//    dispatch_async(queue, ^{
//        NSLog(@"2"); // 任务2
//        dispatch_sync(queue, ^{ //同步线程 添加 同步队列 导致线程死锁（阻塞）
//            NSLog(@"3"); // 任务3
//        });
////        NSLog(@"4"); // 任务4
//    });
//    NSLog(@"5"); // 任务5
//    
    
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3"); // 任务3
    
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 25, 25)];
    date.backgroundColor = [UIColor grayColor];
    date.text = @"10";
    date.textAlignment = NSTextAlignmentCenter;
    date.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.6];
    date.textColor = [UIColor colorWithRed:101.997/255.0 green:101.997/255.0 blue:101.997/255.0 alpha:1];
//    [self.view addSubview:date];
    date.layer.cornerRadius = 12.5;
    date.layer.borderWidth = 1.0f;
    date.layer.borderColor = [UIColor redColor].CGColor;
    date.layer.masksToBounds = YES;
    
    lineView *lin = [[lineView alloc] initWithFrame:CGRectMake(0, 100, 375, 100)];
    
    manger.title = @"manam";
//    [self.view addSubview:lin];
    
//    self.ref = [[ZHRefreshComponet alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
//    self.ref.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:self.ref];
    
    UserHitView *hit = [[UserHitView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    hit.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:hit];
    [hit ZH_AddCornerRadius:50 bounds:hit.bounds];
    hit.assPro = 0.1;
    NSLog(@"%f",hit.assPro);
//
//    UserSubOneView *sub = [[UserSubOneView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
//    [self.view addSubview:sub];
//    sub.backgroundColor = [UIColor orangeColor];
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(200, 200, 25, 25) cornerRadius:25];
////    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:date.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(12.5, 12.5)];
//    CAShapeLayer *sharp = [[CAShapeLayer alloc] init];
//    sharp.borderWidth = 2.0;
//
//    sharp.borderColor = [UIColor redColor].CGColor;
//    sharp.frame = date.bounds;
//    sharp.path = path.CGPath;
//    date.layer.mask = sharp;
    
    [self viewAnimation];
    
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@1,@2,nil];
//    self.dadadaArr = [NSMutableArray array];
//    [self.dadadaArr addObjectsFromArray:array];
//    NSLog(@"1:%@",self.dadadaArr);
////    [self.dadadaArr removeObjectAtIndex:0];
//    NSLog(@"2:%@",self.dadadaArr);
    ModifyReadonly *readON = [[ModifyReadonly alloc] initWithName:@"modeify"];
    NSLog(@"改变前:%@",readON.name);
    
//    [readON setValue:@"readOnly" forKey:@"name"];
    NSLog(@"改变后:%@",readON.name);
    
//    Dog *dog = [ZHZombieProxy proxyWithObj:[Dog alloc]] ;
//    [dog barking:4];
    
    sortModel *model1 = [sortModel new];
    model1.name = @"mode1";
    model1.TypeCode = @"99";
    sortModel *model2 = [sortModel new];
    model2.name = @"mode2";
    model2.TypeCode = @"99";
    sortModel *model3 = [sortModel new];
    model3.name = @"mode3";
    model3.TypeCode = @"01";
    NSMutableArray *array = [NSMutableArray arrayWithObjects:model1,model2,model3, nil];
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"TypeCode" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sorter count:1];
    [array sortUsingDescriptors:sortDescriptors];
    NSLog(@"%@", array);
    
    
    
    NSMutableArray*foraarr = [NSMutableArray arrayWithArray:@[@"10",@"10",@"1",@"2",@"10",@"10",@"3",@"4",@"10",@"5",@"6",@"7",@"10",@"10"]];
    
    for (int i = 0; i < foraarr.count; i ++) {
        if ([foraarr[i] isEqualToString:@"10"]) {
            [foraarr removeObjectAtIndex:i];
            i--;
        }
        NSLog(@"%d --- %lu",i,(unsigned long)foraarr.count);
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"3:%@",self.dadadaArr);
//    redView.transform = CGAffineTransformMakeRotation(-M_PI_4);
//    redView.transform = CGAffineTransformRotate(redView.transform, -M_PI_4);
    redView.layer.transform = CATransform3DRotate(redView.layer.transform, -M_PI_4, 0, 1, 0);
//    [manger connectToServer];
    
    PersonObj *pObj = [[PersonObj alloc] init];
    pObj.name = @"copy一下";
    USEVC *vc = [USEVC new];
    vc.pObj = pObj;

//    [self.navigationController pushViewController:vc animated:YES];
//
//    FactoryVC *vc = [FactoryVC new];
//    [self.navigationController pushViewController:vc animated:YES];
//    imageViewController *vc = [imageViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
    
//    LocalMsgVC *vc = [LocalMsgVC new];
//    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"title:%@",manger.title);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) return YES;//输入长度限定 11位
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 13) {
        return NO;
    }
    return YES;
}


- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (textField.text.length >= lastIndex) {
        
        if (textField.text.length == 3) {
            textField.text = [textField.text stringByAppendingString:@" "];
        }
        
        if (textField.text.length == 8) {
            textField.text = [textField.text stringByAppendingString:@" "];
        }
        lastIndex = textField.text.length;
    }
    
    if (textField.text.length < lastIndex) {
        if (textField.text.length == 4) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 3)];
        }
        if (textField.text.length == 9) {
            textField.text = [textField.text substringWithRange:NSMakeRange(0, 8)];
        }
        lastIndex = textField.text.length;
    }
    
    
}



//选择照片
- (IBAction)chooseImage:(id)sender {
//
//    FingerPwdViewController * c = [FingerPwdViewController new];
//    [self.navigationController pushViewController:c animated:YES];
//    [self presentViewController:c animated:YES completion:nil];
    imageViewController*c = [imageViewController new];
//    [self.navigationController pushViewController:c animated:YES];
    
//    CoreBlueToothViewController *c = [CoreBlueToothViewController new];
//    MVPViewController *c = [MVPViewController new];
    [self.navigationController pushViewController:c animated:YES];
    
    
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        return;
//    }
//    
//    UIImagePickerController *pickVc = [UIImagePickerController new];
//    pickVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    pickVc.delegate = self;
//    [self presentViewController:pickVc animated:YES completion:^{
//        
//    }];
    
}
//链接设备
- (IBAction)connectDevice:(id)sender {
    
    AsySocketViewController *c = [AsySocketViewController new];
    [self.navigationController pushViewController:c animated:YES];
    
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"该账号已在其他设备登录，您已被迫下线，如非您本人操作，请及时修改登录密码。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//    [alertView show];
//    MCBrowserViewController *mcVC = [MCBrowserViewController new];
//    mcVC.delegate = self;
//    GKPeerPickerController *pic = [GKPeerPickerController new];
//    pic.delegate = self;
//    
//    //显示控制器
//    [pic show];
    
//    FriendsViewController *new = [FriendsViewController new];
////    [self presentViewController:new animated:YES completion:nil];
//    [self.navigationController pushViewController:new animated:YES];
}
//发送照片
- (IBAction)sendImage:(UIButton *)sender {
    
    NSData *data = UIImageJPEGRepresentation(self.theImageView.image, 0.2);
    NSError *error;
    //数据的传输是通过session来发送
    
//    self.sessionMC sendData:data toPeers:<#(nonnull NSArray<MCPeerID *> *)#> withMode:<#(MCSessionSendDataMode)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>
    
    [self.session sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"didididididdid");
}



#pragma mark - GKPeerPickerControllerDelegate
-(void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(nonnull NSString *)peerID toSession:(nonnull GKSession *)session
{

    
    self.session = session;
    
    [session setDataReceiveHandler:self withContext:nil];
    //移除
    [picker dismiss];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    UIImage *image = [UIImage imageWithData:data];
    self.theImageView.image = image;
}


#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.theImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (int)lookForSingleDog:(NSArray *)arr
{
    if (arr.count%2 == 0) {
        return -1;
    }
    int result = (int)arr.firstObject;
    for (int i = 1; i< arr.count; i++) {
        NSNumber *index = arr[i];
        result = index.intValue ^ result;
    }
    return result;
}


- (void)viewAnimation{
    
    redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    redView.backgroundColor = [UIColor grayColor];
    CAGradientLayer *rlayr = [CAGradientLayer new];
    rlayr.frame = CGRectMake(100, 100,100, CGRectGetHeight(redView.frame));;
    rlayr.colors = @[(id)[[UIColor blueColor] colorWithAlphaComponent:0.2].CGColor,(id)[[UIColor orangeColor] colorWithAlphaComponent:0.2].CGColor,(id)[[UIColor purpleColor] colorWithAlphaComponent:0.2].CGColor];
    rlayr.locations = @[@0.2,@0.5,@0.8];
    rlayr.startPoint = CGPointMake(0, 0.5);
    rlayr.endPoint = CGPointMake(1, 0.5);
//    [self.view.layer addSublayer:rlayr];
    
    [self.view addSubview:redView];
    
//    CATransform3DRotate(<#CATransform3D t#>, <#CGFloat angle#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat z#>)
//    redView.transform = CGAffineTransformMakeRotation(-M_PI_4);
    redView.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    
//    CABasicAnimation *theAnimation;
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    theAnimation.duration=8;
//    theAnimation.removedOnCompletion = NO;
//    theAnimation.repeatCount = 100;
//    theAnimation.fromValue = [NSNumber numberWithFloat:0];
//    theAnimation.toValue = [NSNumber numberWithFloat:M_PI];
//    [rlayr addAnimation:theAnimation forKey:@"animateTransform"];
//    [rlayr setAnchorPoint:CGPointMake(- 0.5, 0.5)];
    
//    UIView *grView = [[UIView alloc] initWithFrame:CGRectMake(250, 100, 100, 100)];
//    grView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:grView];
//
//    CABasicAnimation *theAnimation1;
//    theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    theAnimation1.duration=8;
//    theAnimation1.removedOnCompletion = NO;
//    theAnimation1.repeatCount = 100;
//    theAnimation1.fromValue = [NSNumber numberWithFloat:0];
//    theAnimation1.toValue = [NSNumber numberWithFloat:-M_PI * 2];
//    [grView.layer addAnimation:theAnimation1 forKey:@"animateTransform"];
//    [grView.layer setAnchorPoint:CGPointMake(1, 0.5)];
    
}


@end
