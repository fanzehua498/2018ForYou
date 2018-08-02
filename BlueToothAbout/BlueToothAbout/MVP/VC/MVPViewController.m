//
//  MVPViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/27.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "MVPViewController.h"
#import "ViewProtocol.h"
#import "Presenter.h"
@interface MVPViewController ()<ViewProtocol,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *table;
@property (nonatomic ,strong)  NSMutableArray *data;

@property (nonatomic ,strong) UIActivityIndicatorView *intdicView;
@end

@implementation MVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"mvp";
    self.data = [NSMutableArray array];
    Presenter *pre = [Presenter new];
    [pre addDataView:self];
    [pre getData:1];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    self.intdicView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    self.intdicView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:self.intdicView];
    [self.intdicView startAnimating];
}

#pragma mark - ViewProtocol
- (void)showEmpty
{
    NSLog(@"无数据");
}
- (void)ShowOperate
{
    self.intdicView.hidden = NO;
}

- (void)hideOperate
{
    [self.intdicView stopAnimating];self.intdicView.hidden = YES;
}

- (void)ViewData:(NSArray *)data
{
    [self.data addObjectsFromArray:data];
    [self.table reloadData];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    NSDictionary *dict = self.data[indexPath.row];
    cell.textLabel.text = dict[@"ProductName"];
    cell.detailTextLabel.text = dict[@"ProductCode"];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
/**
 Amount = 500000;
 AmountMultiple = 100;
 AppContext = "<null>";
 BorrowAmountMax = 0;
 BorrowAmountMin = 0;
 BorrowEndTime = "<null>";
 BorrowStartTime = "<null>";
 BorrowerCode = RB180525EI69V8UM;
 BorrowerId = 1429;
 CalculateExplain = "<null>";
 CompanyInfo = "<null>";
 Context = "<null>";
 CountDown = "-16999";
 CreatedId = 1;
 CreatedTime = "2018-06-27 10:22:08";
 CurrentDbTime = "2018-06-27 15:43:19";
 EffectiveTime = 0;
 FeeStrategy = 0;
 FeeStrategyRemark = "<null>";
 FinishPaymentTotal = 0;
 FullTime = "1970-01-01 00:00:00";
 GuaranteeMode = 3;
 HandleProStatus = 0;
 HandleProType = 0;
 HasRebate = 0;
 Id = 1494;
 InterestAmount = 0;
 InterestRate = 12;
 InverstAmount = 0;
 InverstItemCount = 0;
 InverstTerm = 0;
 InvestProductInfo = "<null>";
 IsAllESign = 0;
 IsAllESignText = "";
 IsFixed = 0;
 IsOnShow = 1;
 IsPaymentPlan = 0;
 IsRegular = 0;
 ItemCount = 0;
 LastModifiedId = 1;
 LastModifiedTime = "2018-06-27 10:31:26";
 LockupPeriod = 0;
 MasterId = 0;
 MaxOrderVolume = 5000;
 Member = "<null>";
 MemberCode = "<null>";
 MemberInfo = "<null>";
 MemberLoginName = "<null>";
 MemberName = "<null>";
 MemberTelephone = "<null>";
 MinOrderVolume = 1;
 OutTradeNo = "<null>";
 ParentId = 0;
 ProductAttachments = "<null>";
 ProductCode = YR180627237;
 ProductName = "\U6807\U7684\U72b6\U6001\U6d4b\U8bd5";
 PublishTime = "2018-06-27 11:00:00";
 PurposeId = "<null>";
 PurposeText = "";
 RealNameVerify = "<null>";
 RealRebate = 0;
 Rebate = 10000;
 RebateRate = 2;
 RefundExplain = "<null>";
 RefundMode = 1;
 RefundTime = "2018-12-28 10:25:27";
 Remark = "<null>";
 RepaymentTotal = 0;
 RewardTotal = 0;
 SellApplyId = 0;
 SignTypeId = 0;
 SingleMaxOrderVolume = 5000;
 SingleMinOrderVolume = 1;
 SpecificTypeId = 2;
 SpecificTypeText = "\U62b5\U62bc\U6807";
 StartInterestTime = "1970-01-01 00:00:00";
 Status = 1;
 Summary = "<null>";
 SurplusAmount = 500000;
 Term = 6;
 TypeId = 1;
 TypeText = "\U501f\U6b3e\U6807";
 Unit = 2;
 UnitText = "\U6708";
 Valid = 1;

 */

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
