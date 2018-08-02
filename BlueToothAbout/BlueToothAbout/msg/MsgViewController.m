//
//  MsgViewController.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/19.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "MsgViewController.h"
#import "ReadOnlyObj.h"
#import "SubReadOnlyObj.h"
@interface MsgViewController ()
{
    SubReadOnlyObj *subObj;
}
@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ReadOnlyObj *obj = [ReadOnlyObj new];
//    obj.read = @"adsasdas";
    NSLog(@"berfor read:%@",obj.read);
    [obj setValue:@"asdqwzxc" forKey:@"read"];
    NSLog(@"after read:%@--%@",obj.read,obj.proG);
    subObj = [SubReadOnlyObj new];
    [subObj performSelector:@selector(ObjActionClassaa)];
}
- (void)ObjAction
{
    NSLog(@"我是控制器方法--%s",__func__);
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
