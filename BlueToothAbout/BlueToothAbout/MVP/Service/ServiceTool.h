//
//  ServiceTool.h
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/27.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessHandler)(NSDictionary *dict);
typedef void(^FailHandler)(NSDictionary *dic);


/**
 *  ServiceTool 用来做数据获取工作等，发起网络请求，并且返回数据给Presenter，这个算是Model，
 */
@interface ServiceTool : NSObject

- (void)getDataSuccess:(SuccessHandler )success Fail:(FailHandler )fail index:(NSInteger)index;

@end
