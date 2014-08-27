//
//  PhotoSetManagerTests.m
//  PhotoSetManagerTests
//
//  Created by Benedikt Terhechte on 8/25/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "PhotoSetModel.h"

@interface PhotoSetManagerTests : XCTestCase
@property (retain) PhotoSetItem *item;
@end

@implementation PhotoSetManagerTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
