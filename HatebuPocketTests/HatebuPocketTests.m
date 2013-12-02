//
//  HatebuPocketTests.m
//  HatebuPocketTests
//
//  Created by Kazuyaster on 2013/10/27.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FeedItem.h"

@interface HatebuPocketTests : XCTestCase{
}

@end

@implementation HatebuPocketTests

- (void)setUp
{
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    FeedItem *item = [[FeedItem alloc]initWithTitle:@"title" encodeContent:@"test" date:@"" subject:@"" description:@"" bookmarkCount:@"" link:@"" about:@""];
    XCTAssert([item isEqual:item], @"");
    
    FeedItem *item2 = [[FeedItem alloc]initWithTitle:@"title" encodeContent:@"" date:@"" subject:Nil description:nil bookmarkCount:nil link:nil about:nil];
    
    XCTAssertFalse( [item isEqual:item2],@"");
    
}

@end
