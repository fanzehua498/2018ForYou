//
//  FriendsViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/21.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendModel.h"
#import "MCBViewController.h"

@interface FriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;

@property(strong,nonatomic)NSMutableArray *DataArr;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FriendModel *model = self.DataArr[section];
    if (model.open) {
        return 20;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.DataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"text---%ld",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCBViewController *new = [[UIStoryboard storyboardWithName:@"MCBViewCOntroller" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MCBViewController"];
   
    [self.navigationController pushViewController:new animated:YES];
//    [self presentViewController:new animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FriendModel *model = self.DataArr[section];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:model.title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    button.tag = 10086 + section;
    [button addTarget:self action:@selector(openSection:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)openSection:(UIButton *)sender
{
    NSInteger section = sender.tag-10086;
    FriendModel *model = self.DataArr[section];
    model.open = !model.open;
    [self.tableView reloadData];
    
}
#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


-(NSMutableArray *)DataArr
{
    if (!_DataArr) {
        _DataArr = [NSMutableArray array];
        
        for (int i = 0; i < 20; i++) {
            FriendModel *model = [FriendModel new];
            model.title = [NSString stringWithFormat:@"title:%d",i];
            model.open = NO;
            [_DataArr addObject:model];
        }
    }
    return _DataArr;
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
