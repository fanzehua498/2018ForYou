//
//  CoreBlueToothViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/17.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

/*
 建立中心设备
 
 扫描外设
 
 连接外设
 
 扫描外设中的服务和特征
 
 利用特征与外设做数据交互
 
 断开连接
 
 */

#import "CoreBlueToothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface CoreBlueToothViewController ()<CBCentralManagerDelegate,UITableViewDelegate,UITableViewDataSource,CBPeripheralDelegate>

@property(strong,nonatomic)CBCentralManager *mgr;
@property(strong,nonatomic)NSMutableArray *perArr;

@property(strong,nonatomic)UITableView *table;

@end

@implementation CoreBlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.perArr = [NSMutableArray array];
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    //建立中心设备
    //queue队列
    self.mgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    /*
     CBCentralManagerStateUnknown = CBManagerStateUnknown, 未知设备
     CBCentralManagerStateResetting = CBManagerStateResetting, 重置
     CBCentralManagerStateUnsupported = CBManagerStateUnsupported, 不支持
     CBCentralManagerStateUnauthorized = CBManagerStateUnauthorized, 未授权
     CBCentralManagerStatePoweredOff = CBManagerStatePoweredOff, 没有开启
     CBCentralManagerStatePoweredOn = CBManagerStatePoweredOn, 开启
     
     */
    NSLog(@"statte:%zd",central.state);
    if (central.state == CBManagerStateUnsupported) {
        //不支持
    }
    if (central.state == CBManagerStatePoweredOn) {
        
        [self.mgr scanForPeripheralsWithServices:nil options:nil];
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    //添加一个数组
    if (![self.perArr containsObject:peripheral]) {
        [self.perArr addObject:peripheral];
    }
    NSLog(@"---%@",self.perArr);
    //显示
    [self.table reloadData];
    
    //设置外设
//    [self.mgr connectPeripheral:peripheral options:nil];
    
    //设置代理
    peripheral.delegate = self;
}





#pragma mark - peripheral.delegate
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //扫描服务 nil:所有服务
    [peripheral discoverServices:nil];
    
}


#pragma mark - 设置外设的代理
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    //发现服务调用此方法
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
//        if ([service.UUID.UUIDString isEqualToString:@"62141A43-6C9A-0B91-99ED-42D47C31B52C"]) {
//            //如果uuid一致 就开始去扫描特征
//            [peripheral discoverCharacteristics:nil forService:service];
//            NSLog(@"来了");
//        }
    }
}


-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error
{

    for (CBCharacteristic *characteristic in service.characteristics) {
        [peripheral readValueForCharacteristic:characteristic];
//        if ([characteristic.UUID.UUIDString isEqualToString:@"62141A43-6C9A-0B91-99ED-42D47C31B52C"]) {
//
//            [peripheral readValueForCharacteristic:characteristic];
////            peripheral writeValue:<#(nonnull NSData *)#> forCharacteristic:<#(nonnull CBCharacteristic *)#> type:<#(CBCharacteristicWriteType)#>
//        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.mgr stopScan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.perArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    CBPeripheral *per = self.perArr[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    if (per.name) {
        cell.textLabel.text = [per.identifier.UUIDString stringByAppendingString:per.name] ;
    }else{
        cell.textLabel.text = [per.identifier.UUIDString stringByAppendingString:@"获取不到name"] ;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mgr stopScan];
    CBPeripheral *peripheral = self.perArr[indexPath.row];
    [self.mgr connectPeripheral:peripheral options:nil];
    NSString *ss = @"NSUTF8StringEncoding";
    NSData *data = [ss dataUsingEncoding:NSUTF8StringEncoding];
//    peripheral.services
//    peripheral writeValue:data forCharacteristic:<#(nonnull CBCharacteristic *)#> type:<#(CBCharacteristicWriteType)#>
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
