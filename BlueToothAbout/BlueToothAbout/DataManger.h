//
//  DataManger.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/28.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface DataManger : NSObject

+(instancetype) alloc __attribute__((unavailable("call shareManager instead")));
+(instancetype) new __attribute__((unavailable("call shareManager instead")));
-(instancetype) copy __attribute__((unavailable("call shareManager instead")));
-(instancetype) mutableCopy __attribute__((unavailable("call shareManager instead")));



+ (instancetype)shareManager;

@end
