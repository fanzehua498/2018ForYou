
//
//  ChatViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/30.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatFriendsCell.h"

#import "ScoketManger.h"
#import "ChatModel.h"
#import "ChatMeCell.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIButton *send;
    ScoketManger *manger;
}
@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)NSMutableArray *dataArr;

@property(strong,nonatomic)UITextField *chatField;
@property(strong,nonatomic)UIView *backView;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    self.backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.backView];
    self.backView.userInteractionEnabled = YES;
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    
    self.table.estimatedRowHeight = 60;
    [self.backView addSubview:self.table];
    __weak ChatViewController *weakSelf = self;
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.backView);
        make.left.mas_equalTo(weakSelf.backView);
        make.right.mas_equalTo(weakSelf.backView);
        make.bottom.equalTo(weakSelf.backView.mas_bottom).offset(-44);
    }];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.tableFooterView = [UIView new];
    self.dataArr = [NSMutableArray array];
    
    manger = [[ScoketManger alloc] init];
    //    [manger connectToServer];
    [manger connectToServerWithBlock:^(BOOL success, NSString *callMsg) {
        if (success) {
            //连接成功
            self.title = callMsg;
        }else{
            //连接失败
            self.title = callMsg;
        }
    }];
    
    [manger blockSuccessAction:^(NSDictionary *success) {
        
        NSString *content = success[@"msg"];
        
        ChatModel *model = [ChatModel new];
        model.content = content;
        model.me = NO;
        model.type = success[@"type"];
        [weakSelf.dataArr addObject:model];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self changeToRealHeight];
        });
    }];
    
    UIView *chatView = [UIView new];
    chatView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:248/255.0 alpha:1];
    [self.backView addSubview:chatView];
    [chatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backView.mas_bottom).offset(-44);
        make.left.mas_equalTo(weakSelf.backView);
        make.right.mas_equalTo(weakSelf.backView);
        make.height.mas_equalTo(44);
    }];
    chatView.userInteractionEnabled = YES;
    self.chatField = [UITextField new];
    self.chatField.borderStyle = UITextBorderStyleRoundedRect;
    self.chatField.placeholder = @"说话啊 制杖";
    [chatView addSubview:self.chatField];
    self.chatField.backgroundColor = [UIColor whiteColor];
    [self.chatField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.chatField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(chatView);
        make.left.mas_equalTo(chatView);
        make.bottom.mas_equalTo(chatView);
        make.right.equalTo(chatView.mas_right).offset(-80);
    }];
    
    send = [UIButton new];
    [send setTitle:@"发送" forState:UIControlStateNormal];
    [send setTitle:@"不可用" forState:UIControlStateDisabled];
    //    send.enabled = NO;
    [send setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [chatView addSubview:send];
    [send addTarget:self action:@selector(sendMsg:) forControlEvents:UIControlEventTouchUpInside];
    [send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(chatView);
        make.left.equalTo(self.chatField.mas_right).offset(40);
        make.bottom.mas_equalTo(chatView);
        make.right.equalTo(chatView.mas_right).offset(0);
    }];
    
    
    UIButton *imageBtn = [UIButton new];
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"aio_icons_ptt_75x75_"] forState:UIControlStateNormal];
    [chatView addSubview:imageBtn];
    [imageBtn addTarget:self action:@selector(selectImageToPost:) forControlEvents:UIControlEventTouchUpInside];
    [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(chatView);
        make.left.equalTo(self.chatField.mas_right).offset(0);
        make.bottom.mas_equalTo(chatView);
        make.right.equalTo(self->send.mas_left).offset(0);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

#pragma mark -//当键盘出现或改变时调用

- (void)keyboardWillShow:(NSNotification *)aNotification{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    self.backView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-height-64);
    
    [self changeToRealHeight];
}

- (void)keyboardWillHide:(NSNotification *)aNotification{
    
    self.backView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
    [self changeToRealHeight];
}

#pragma mark - action
//发送图片
- (void)selectImageToPost:(UIButton *)sender
{
    UIImagePickerController *pick = [UIImagePickerController new];
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pick.delegate = self;
    
    [self presentViewController:pick animated:YES completion:nil];
}

- (void)sendMsg:(UIButton *)sender
{
    [manger sendData:self.chatField.text];
    ChatModel *model = [ChatModel new];
    model.content = self.chatField.text;
    model.me = YES;
    model.type = @"txt";
    [self.dataArr addObject:model];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table reloadData];
    });
    
    self.chatField.text = @"";
    [self changeToRealHeight];
    
}

- (void)changeToRealHeight
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table reloadData];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGFloat ch=self.table.contentSize.height;
        CGFloat h=self.table.bounds.size.height;
        
        if(ch > h){
            [self.table setContentOffset:CGPointMake(0, ch-h) animated:NO];
        }else{
            [self.table setContentOffset:CGPointMake(0, 0) animated:NO];
        }
        
    });
}

- (void)textFieldDidChange:(UITextField *)textField
{
    NSString *text = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (text.length <=0) {
        
        send.enabled = NO;
    }else{
        
        send.enabled = YES;
    }
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId1 = @"cellId1";
    static NSString *cellId2 = @"cellId2";
    
    
    ChatModel *model = self.dataArr[indexPath.row];
    if (!model.me) {
        ChatFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if (!cell) {
            cell = [[ChatFriendsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId1];
        }
        [cell configDataWithModel:model];
        return cell;
    }else{
        ChatMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        if (!cell) {
            cell = [[ChatMeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId2];
        }
        [cell configDataWithModel:model];
        return cell;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - uiimagepickerVCDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImage *image = [UIImage imageNamed:@"head"];
    
    NSData *imaged = UIImageJPEGRepresentation(image, 0.1);
    NSString *imageStr = [imaged base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    //    NSData *imageData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    //    [manger sendImageData:imaged];
    [manger sendData:imageStr];
    [self dismissViewControllerAnimated:YES completion:^{
        ChatModel *model = [ChatModel new];
        model.content = imageStr;
        model.me = YES;
        model.type = @"img";
        [self.dataArr addObject:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
            [self changeToRealHeight];
        });
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
