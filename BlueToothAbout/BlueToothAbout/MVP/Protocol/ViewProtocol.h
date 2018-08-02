//
//  ViewProtocol.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/27.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewProtocol <NSObject>

- (void)ViewData:(NSArray *)data;
- (void)ShowOperate;
- (void)hideOperate;
- (void)showEmpty;
@end
