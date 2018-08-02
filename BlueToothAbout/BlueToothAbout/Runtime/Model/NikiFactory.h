//
//  NikiFactory.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/19.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RunProtocol.h"
@interface NikiFactory : NSObject

@property (nonatomic, weak) id<RunProtocol> nikiProtocl;

- (id<RunProtocol>)create;
- (void)buy;
@end
