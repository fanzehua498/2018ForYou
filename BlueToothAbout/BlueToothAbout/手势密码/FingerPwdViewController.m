//
//  FingerPwdViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/20.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "FingerPwdViewController.h"
#import "FingerView.h"
#import <LocalAuthentication/LocalAuthentication.h>//指纹识别库
@interface FingerPwdViewController ()

@end

@implementation FingerPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSError *error;
    LAContext *context = [LAContext new];
    context.localizedFallbackTitle = @"使用手势密码";
    BOOL success = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (success) {
        NSLog(@"success");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"我要用你的指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                //fail
                switch (error.code) {
                    case LAErrorSystemCancel:
                        NSLog(@"系统取消授权");
                        break;
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorBiometryNotAvailable:
                    {
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorBiometryNotEnrolled:
                    {
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
            
        }];
        
    }else{
        //不支持指纹
        switch (error.code) {
            case LAErrorBiometryNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    FingerView * fig = [[FingerView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    fig.backgroundColor = [UIColor grayColor];
    [self.view addSubview:fig];

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
