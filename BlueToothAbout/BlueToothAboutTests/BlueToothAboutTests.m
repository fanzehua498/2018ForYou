//
//  BlueToothAboutTests.m
//  BlueToothAboutTests
//
//  Created by 知合金服-Mini on 2018/5/17.
//  Copyright © 2018年 知合金服-Mini. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BlueToothAboutTests : XCTestCase

@end

@implementation BlueToothAboutTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //初始化
    NSLog(@"初始化");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    //销毁清楚
    NSLog(@"销毁");
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"测试案例");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
    //性能测试
    NSLog(@"性能测试");
}

@end
