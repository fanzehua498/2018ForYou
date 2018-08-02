//
//  SocketViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/30.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "SocketViewController.h"
#import "ScoketManger.h"
@interface SocketViewController ()
{
    ScoketManger *manger;
}

@property (weak, nonatomic) IBOutlet UITextField *ipField;
@property (weak, nonatomic) IBOutlet UITextField *portField;
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (weak, nonatomic) IBOutlet UITextView *serverMessageView;

@end

@implementation SocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    manger = [[ScoketManger alloc] init];
}
- (IBAction)connectAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    BOOL select = sender.isSelected;
    [manger connectToServer];
    [self.connectBtn setTitle:@"断开连接" forState:UIControlStateNormal];
//    if (select) {
//        [manger connectToServer];
//        [self.connectBtn setTitle:@"断开连接" forState:UIControlStateNormal];
//        
//    }else{
//        [manger closeServre];
//        [self.connectBtn setTitle:@"连接" forState:UIControlStateNormal];
//    }
}
- (IBAction)sendAction:(UIButton *)sender {
    
    [manger sendData:[self.ipField.text dataUsingEncoding:NSDataBase64Encoding64CharacterLineLength]];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
