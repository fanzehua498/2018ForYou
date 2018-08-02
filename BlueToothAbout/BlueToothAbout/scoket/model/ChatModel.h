//
//  ChatModel.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/5/30.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

@property(strong,nonatomic)NSString *content;
@property (nonatomic, assign) BOOL  me;
@property (nonatomic ,strong) NSString *type;


@end
