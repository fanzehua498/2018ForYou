//
//  ZHZombieProxy.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/8/8.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHZombieProxy : NSProxy
{
    //再内部hold住一个要hook的对象
    id _innerObject;
}
+(instancetype)proxyWithObj:(id)obj;

@end

@interface Dog : NSObject


- (NSString *)barking:(NSInteger )months;
@end
