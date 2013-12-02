//
//  GcovTestObserver.m
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/12/03.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
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