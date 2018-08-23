//
//  PersonObj.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/23.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "PersonObj.h"

@implementation PersonObj

-(id)copyWithZone:(NSZone *)zone
{
    PersonObj *model = [[PersonObj alloc] init];
    model.name = self.name;
    
    return model;
}
@end
