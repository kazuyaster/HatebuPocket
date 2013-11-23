//
//  FeedManager.m
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/23.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import "FeedDownloader.h"
#import "AFURLSessionManager.h"
#import "XMLReader.h"

@implementation FeedDownloader

- (void)dictionaryFromRSSWithURL:(NSString*)urlString{
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                                                         NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]];
                                                                         return [documentsDirectoryPath URLByAppendingPathComponent:[targetPath lastPathComponent]];
                                                                     } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                                                         NSLog(@"File downloaded to: %@", filePath);
                                                                         
                                                                         NSString *feedString = [NSString stringWithContentsOfURL:filePath
                                                                                                                         encoding:NSUTF8StringEncoding
                                                                                                                            error:&error];
                                                                         NSDictionary *feedDict = [XMLReader dictionaryForXMLString:feedString error:&error];
                                                                         NSDictionary *userInfo = @{@"feed":feedDict};
                                                                         NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
                                                                         [notificationCenter postNotificationName:KODDownloadFeedNotification object:userInfo];
                                                                     }];
    [downloadTask resume];

}

@end
