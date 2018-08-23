//
//  UserViewModel.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/23.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "UserViewModel.h"

@implementation UserViewModel

-(instancetype)initWithUser:(UserMvvm *)user
{
    self = [super init];
    if (self) {
        _user = user;
        if (user.name.length > 0) {
            _userName = user.name;
        }else{
            _userName = [NSString stringWithFormat:@"无名字"];
        }
        
    }
    return self;
}

@end
