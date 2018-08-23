//
//  UserViewModel.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/23.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserMvvm.h"

@interface UserViewModel : NSObject

@property (nonatomic ,strong) UserMvvm *user;
@property(copy,nonatomic)NSString *userName;

- (instancetype)initWithUser:(UserMvvm *)user;

@end
