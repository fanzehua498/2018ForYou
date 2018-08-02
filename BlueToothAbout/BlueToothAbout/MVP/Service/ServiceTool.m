//
//  ServiceTool.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/27.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "ServiceTool.h"

@implementation ServiceTool

- (void)getDataSuccess:(SuccessHandler)success Fail:(FailHandler)fail index:(NSInteger)index
{
    NSString *url = @"";
    
    NSString *CurrenIndex = [NSString stringWithFormat:@"%ld",index];
    
    NSDictionary *dict = @{@"AppKey":@"",
                           @"AppSecret":@"",
                           @"TimeStamp":[self getTimeStamp],
                           @"Version":@"version",
                           @"Sign":@"sign",
                           @"PageIndex":CurrenIndex,
                           @"PageSize":@"20",
                           @"TypeId":@"1"
                           };
    
    AFHTTPSessionManager *ma = [AFHTTPSessionManager manager];
    [ma POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            success(@{@"data":responseObject});
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(@{@"msg":error});
    }];
    
    
    //网络请求 获取数据
//    NSArray *result = @[@{@"name":@"mayun",
//                          @"age":@25,
//                          @"gender":@"male",
//                          },
//                        @{@"name":@"mahuateng",
//                          @"age":@25,
//                          @"gender":@"male",
//                          },
//                        @{@"name":@"wanglei",
//                          @"age":@25,
//                          @"gender":@"female",
//                          },
//                        @{@"name":@"liuyanhong",
//                          @"age":@25,
//                          @"gender":@"female",}];
//
//    //模拟网络 延迟2秒加载
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        success(@{@"data":result});
//    });
    
}
-(NSString*)getTimeStamp
{
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f", timeStamp];
}
@end
