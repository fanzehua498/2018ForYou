//
//  ModifyReadonly.h
//  BlueToothAbout
//
//  Created by rrjj on 2018/12/3.
//  Copyright © 2018 fanzehua. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModifyReadonly : NSObject
@property (copy, nonatomic,readonly) NSString *name;


-(instancetype)initWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
