//
//  Shoes.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/19.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "Shoes.h"

@implementation Shoes

+(NikiFactory *)createFacory
{
    Shoes *shoe = [[Shoes alloc] init];
    return shoe;
}
-(void)buy
{
    NSLog(@"买鞋");
//    if (self.nikiProtocl && [self respondsToSelector:@selector(buy:)]) {
//        [self.nikiProtocl buy:@"mai特么的鞋"];
//    }else{
//        NSLog(@"未响应0");
//    }
    [self.nikiProtocl buy:@"mai特么的鞋"];
}

@end
