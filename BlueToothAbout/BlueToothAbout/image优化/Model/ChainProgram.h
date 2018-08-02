//
//  ChainProgram.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/13.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChainProgram : NSObject
- (ChainProgram* (^)(NSInteger tag))add;
@end
