//
//  FactoryVC.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/19.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "FactoryVC.h"
#import "Shoes.h"
#import "TShirt.h"
#import "NikiFactory.h"

static NSString *tatStr = @"tat";

NSString *const constStr = @"constS";

@interface FactoryVC ()<RunProtocol>

@end

@implementation FactoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NikiFactory *fact1=[Shoes createFacory];
    [fact1 buy];
    fact1.nikiProtocl = self;
    
    NikiFactory *tshirt = [TShirt createFacory];
    [tshirt buy];
    tshirt.nikiProtocl = self;
    NSLog(@"1:%@",constStr);
    tatStr = @"sss";
//    constStr = @"11111";
    NSLog(@"2:%@",constStr);
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    constStr = @"222";
    NSLog(@"3:%@",constStr);

}

-(void)buy:(NSString *)str
{
    NSLog(@"-----%@",str);
}

- (void)eat:(NSString *)str {
    NSLog(@"%@ %s",str,__func__);
}


- (void)push:(NSString *)str {
        NSLog(@"%@ %s",str,__func__);
}


- (void)sel:(NSString *)str {
        NSLog(@"%@ %s",str,__func__);
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
