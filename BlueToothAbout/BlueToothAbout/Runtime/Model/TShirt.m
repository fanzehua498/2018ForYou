//
//  TShirt.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/19.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "TShirt.h"

@implementation TShirt

+(NikiFactory *)createFacory
{
    return [[TShirt alloc] init];
}

-(void)buy
{
    NSLog(@"买T恤");
    if (self.nikiProtocl && [self respondsToSelector:@selector(buy:)]) {
        [self.nikiProtocl buy:@"mai特么的T恤"];
    }else{
        NSLog(@"未响应T恤");
    }
}
@end
