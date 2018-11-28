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

@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,strong) CBCharacteristic *characteristic;


@end

@implementation CoreBlueToothViewController

#pragma mark 1.初始化
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

/**
*  --  初始化成功自动调用
*  --  必须实现的代理，用来返回创建的centralManager的状态。
*  --  注意：必须确认当前是CBCentralManagerStatePoweredOn状态才可以调用扫描外设的方法：
scanForPeripheralsWithServices
*/
#pragma mark - 2.搜索扫描外围设备
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
        // 开始扫描周围的外设。
        /*
         -- 两个参数为Nil表示默认扫描所有可见蓝牙设备。
         -- 注意：第一个参数是用来扫描有指定服务的外设。然后有些外设的服务是相同的，比如都有FFF5服务，那么都会发现；而有些外设的服务是不可见的，就会扫描不到设备。
         -- 成功扫描到外设后调用didDiscoverPeripheral
         */
        [self.mgr scanForPeripheralsWithServices:nil options:nil];
    }
}
#pragma mark - 3.连接外设--成功
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mgr stopScan];
    //连接外设
    CBPeripheral *peripheral = self.perArr[indexPath.row];
    [self.mgr connectPeripheral:peripheral options:nil];
    NSString *ss = @"NSUTF8StringEncoding";
    NSData *data = [ss dataUsingEncoding:NSUTF8StringEncoding];
    //    peripheral.services
    //    peripheral writeValue:data forCharacteristic:<#(nonnull CBCharacteristic *)#> type:<#(CBCharacteristicWriteType)#>
}
#pragma mark - peripheral.delegate 连接外设--成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //扫描服务 nil:所有服务
    [peripheral discoverServices:nil];
    
    peripheral.delegate = self;
    
    self.peripheral = peripheral;
    //4.扫描外设的服务
    /**
     --     外设的服务、特征、描述等方法是CBPeripheralDelegate的内容，所以要先设置代理peripheral.delegate = self
     --     参数表示你关心的服务的UUID，比如我关心的是"FFE0",参数就可以为@[[CBUUID UUIDWithString:@"FFE0"]].那么didDiscoverServices方法回调内容就只有这两个UUID的服务，不会有其他多余的内容，提高效率。nil表示扫描所有服务
     --     成功发现服务，回调didDiscoverServices
     */
    //    peripheral discoverServices:<#(nullable NSArray<CBUUID *> *)#>
}
// 连接外设——失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@", error);
}
// 取消与外设的连接回调
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"%@", peripheral);
}
#pragma mark - 设置外设的代理
#pragma mark - 4.发现服务回调
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    //发现服务调用此方法
    
    CBService * findService = nil;
    //遍历服务
    for (CBService *service in peripheral.services) {
        NSLog(@"UUID:%@ UUIDDATA：%@ UUIDsrt：%@",service.UUID,service.UUID.data,service.UUID.UUIDString);
        
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"9FA480E0-4967-4542-9390-D343DC5D04AE"]]) {
            findService = service;
        }
        
//        [peripheral discoverCharacteristics:nil forService:service];
        //        if ([service.UUID.UUIDString isEqualToString:@"62141A43-6C9A-0B91-99ED-42D47C31B52C"]) {
        //            //如果uuid一致 就开始去扫描特征
        //            [peripheral discoverCharacteristics:nil forService:service];
        //            NSLog(@"来了");
        //        }
    }
    
    if (findService) {
        [peripheral discoverCharacteristics:nil forService:findService];
    }
    
}
// 发现特征回调
/**
 --  发现特征后，可以根据特征的properties进行：读readValueForCharacteristic、写writeValue、订阅通知setNotifyValue、扫描特征的描述discoverDescriptorsForCharacteristic。
 **/
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(nonnull CBService *)service error:(nullable NSError *)error
{
//    for (CBCharacteristic *characteristic in service.characteristics) {
//        CBCharacteristicProperties properties = characteristic.properties;
//        if (properties & CBCharacteristicPropertyWrite) {
//
//        }
//        [peripheral readValueForCharacteristic:characteristic];
//        //        if ([characteristic.UUID.UUIDString isEqualToString:@"62141A43-6C9A-0B91-99ED-42D47C31B52C"]) {
//        //
//        //            [peripheral readValueForCharacteristic:characteristic];
//        ////            peripheral writeValue:<#(nonnull NSData *)#> forCharacteristic:<#(nonnull CBCharacteristic *)#> type:<#(CBCharacteristicWriteType)#>
//        //        }
//    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        /**
         -- 当发现characteristic有descriptor,回调didDiscoverDescriptorsForCharacteristic
         */
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AF0BADB1-5B99-43CD-917A-A77BC549E3CC"]]) {
            
            /**
             -- 读取成功回调didUpdateValueForCharacteristic
             */
            self.characteristic = characteristic;
            // 接收一次(是读一次信息还是数据经常变实时接收视情况而定, 再决定使用哪个)
            //            [peripheral readValueForCharacteristic:characteristic];
            // 订阅, 实时接收
//            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
            // 发送下行指令(发送一条)
            NSData *data = [@"硬件工程师给我的指令, 发送给蓝牙该指令, 蓝牙会给我返回一条数据" dataUsingEncoding:NSUTF8StringEncoding];
            // 将指令写入蓝牙
//            [self.peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            NSDate *date = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YY-MM-dd-hh-mm"];
            NSString *dateString = [dateFormatter stringFromDate:date];
            NSArray *time_strs = [dateString componentsSeparatedByString:@"-"];
            NSLog(@"time_strs = %@",time_strs);
            int num3 =[time_strs[0] intValue];
            int num4 =[time_strs[1] intValue];
            int num5 =[time_strs[2] intValue];
            int num6 =[time_strs[3] intValue];
            int num7 =[time_strs[4] intValue];
            //后三位90-11-5是把CMD_HEAD CMD_LENGHT CMD_SORT 转成的10进制
            int num8 = num3 + num4 +num5 +num6 +num7 +90+11+5;
            Byte   CMD_HEAD = 0x5A;
            Byte   CMD_LENGHT = 0x0B;
            Byte   CMD_SORT = 0x05;
            Byte byte4[] = {CMD_HEAD,CMD_LENGHT,CMD_SORT,num3,num4,num5,num6,num7,num8,0,0};
            NSData *data23 = [NSData dataWithBytes:byte4 length:sizeof(byte4)];
            [self.peripheral writeValue:data23 forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            
//            [self.peripheral readValueForCharacteristic:characteristic];
        }
        
    }
}

#pragma mark - 5.从外围设备读取数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    
//    NSData *jsonData = [characteristic.value dataUsingEncoding:NSUTF8StringEncoding];
    NSData *jsonData = characteristic.value;
//
//    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    // 将字典传出去就可以使用了
    NSLog(@"%@",characteristic.value);
}
//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (characteristic.isNotifying) {
        [peripheral readValueForCharacteristic:characteristic];
    }else{
        NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
        NSLog(@"%@", characteristic);
        [self.mgr cancelPeripheralConnection:peripheral];
    }
}

#pragma mark - 6.给外围设备发送（写入数据）
- (void)writeCheckBluWithBlu
{
//    NSData *data = [@"硬件工程师提供给你的指令, 类似于5E16010203...这种很长一串" dataUsingEncoding:NSUTF8StringEncoding];
//    [self.peripheral writeValue:data forCharacteristic:self. type:CBCharacteristicWriteWithResponse];
}
// 数据写入成功回调
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//     [self.peripheral readValueForCharacteristic:self.characteristic];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }else{
       
        NSLog(@"写入成功 --%@",characteristic.value);
    }
    
    
    
}

#pragma mark 发现外设
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Find device:%@", [peripheral name]);
    //添加一个数组
    if (![self.perArr containsObject:peripheral]) {
        [self.perArr addObject:peripheral];
        // 停止扫描, 看需求决定要不要加
        // [self.mgr stopScan];
    }
    NSLog(@"---%@",self.perArr);
    //显示
    [self.table reloadData];
    
    //设置外设
//    [self.mgr connectPeripheral:peripheral options:nil];
    
    //设置代理
    peripheral.delegate = self;
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
