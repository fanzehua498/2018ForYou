//
//  LocalMsgVC.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/6.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "LocalMsgVC.h"
#import "LocalMsgModel.h"
#import "LocalCell.h"

#define kPageSize 10
@interface LocalMsgVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) NSMutableArray *localData;
@property (nonatomic ,strong) NSArray *totalArr;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic ,strong) UITableView *table;


@end

@implementation LocalMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Local.plist" ofType:nil];
    self.totalArr = [NSArray arrayWithContentsOfFile:path];
    self.localData = [NSMutableArray array];
    self.currentIndex = 1;
    [self readDataWithIndex:self.currentIndex];
    
    UIButton *addData = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addData addTarget:self action:@selector(addLocalData) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addData];
}

- (void)addLocalData{
    self.currentIndex ++;
    [self readDataWithIndex:self.currentIndex];
//    LocalMsgModel *model = [LocalMsgModel yy_modelWithDictionary:self.totalArr[0]];
//    [self.localData insertObject:model atIndex:0];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//       [self.table reloadData];;
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//        [self.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
//         [self.table setContentOffset:CGPointMake(0, 140-10) animated:YES];
//    });
}

- (void)readDataWithIndex:(NSInteger )index
{
    WS(weakSelf);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = ((index-1) * kPageSize); i < 10 * (index); i++) {
            LocalMsgModel *model = [LocalMsgModel yy_modelWithDictionary:weakSelf.totalArr[i]];
            [weakSelf.localData insertObject:model atIndex:0];
        }
        [weakSelf.table reloadData];
        
        if (weakSelf.currentIndex > 1) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:weakSelf.localData.count - (index-1) * kPageSize inSection:0];
            [self.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
            NSLog(@"ffff:%f \n %lu",self.table.contentOffset.y,(weakSelf.localData.count - 10 * (index-1))*140);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.table setContentOffset:CGPointMake(0, self.table.contentOffset.y-20) animated:YES];

            });

        }
        
    });
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.localData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"LocalCell";
    LocalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LocalCell" owner:nil options:nil].lastObject;
    }
    LocalMsgModel *model = self.localData[indexPath.row];
    [cell localMsgModelData:model];
    return cell;
}



@end
