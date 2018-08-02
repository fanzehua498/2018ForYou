//
//  ReadOnlyObj.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/19.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadOnlyObj : NSObject
@property (nonatomic ,readonly) NSString *read;
@property (nonatomic ,readonly,getter=isPro) NSString *proG;
@property (nonatomic ,strong,setter=issetp:) NSString *setpro;
@end
