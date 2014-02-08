//
//  GcovTestObserver.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/12/03.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import <XCTest/XCTestObserver.h>

@interface GcovTestObserver : XCTestObserver
@end

@implementation GcovTestObserver

- (void) stopObserving
{
    [super stopObserving];
    UIApplication* application = [UIApplication sharedApplication];
    [application.delegate applicationWillTerminate:application];
}

@end