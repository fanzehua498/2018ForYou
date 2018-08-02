//
//  Presenter.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/6/27.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import "Presenter.h"
#import "ServiceTool.h"
@interface Presenter ()

@property (nonatomic ,strong) ServiceTool *tool;
@property (nonatomic, weak) id<ViewProtocol> delegate;
@end

@implementation Presenter


-(void)addDataView:(id<ViewProtocol>)view
{
    self.delegate = view;
    self.tool = [ServiceTool new];
}

- (void)getData:(NSInteger)index
{
    [self.delegate ShowOperate];
    [self.tool getDataSuccess:^(NSDictionary *dict) {
        [self.delegate hideOperate];
        
        //数据赋值
        NSDictionary *diiii =dict[@"data"];
        NSArray *userArr = diiii[@"Result"];
        if ([self localData: userArr].count == 0) {
            [self.delegate showEmpty];
        }
        [self.delegate ViewData:userArr];
    } Fail:^(NSDictionary *dic) {
        
    } index:index];
    
}


- (NSArray *)localData:(NSArray *)data
{
    NSMutableArray *UIData = [NSMutableArray new];
    for (NSDictionary *dic in data) {
        [UIData addObject:dic];
    }
    return UIData;
}

@end
