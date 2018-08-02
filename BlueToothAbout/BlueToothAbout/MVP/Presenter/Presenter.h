//
//  Presenter.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/27.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewProtocol.h"

@interface Presenter : NSObject

/**
 *  将一个实现了 ViewProtocol 协议的对象绑定到 presenter上来
 *
 *  @param view 实现了ViewProtocol的对象，一般来说，应该就是控制器，在MVP中，V 和 VC 共同组成UI 层。
 */
- (void)addDataView:(id<ViewProtocol>) view;

//填写数据
- (void)getData:(NSInteger)index;
@end
