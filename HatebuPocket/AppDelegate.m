//
//  AppDelegate.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/10/27.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import "AppDelegate.h"
#import "PocketAPI.h"

@implementation AppDelegate

#ifdef DEBUG
+ (void)initialize {
    [[NSUserDefaults standardUserDefaults] setValue:@"XCTestLog,GcovTestObserver"
                                             forKey:@"XCTestObserverClass"];
}
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [[PocketAPI sharedAPI] setConsumerKey:@"23600-20fcf4fd2f3c2cd6fa2b612b"];
    return YES;
}

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation{
    
    if([[PocketAPI sharedAPI] handleOpenURL:url]){
        return YES;
    }else{
        // if you handle your own custom url-schemes, do it here
        return NO;
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
#ifdef DEBUG
    extern void __gcov_flush(void);
    __gcov_flush();
#endif
}

@end
