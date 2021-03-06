//
//  FeedManager.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/11/23.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                                                         NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]];
                                                                         return [documentsDirectoryPath URLByAppendingPathComponent:[targetPath lastPathComponent]];
                                                                     } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                                                         
                                                                         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                                                         
                                                                         if (error)return ;
                                                                         
                                                                         NSLog(@"File downloaded to: %@", filePath);
                                                                         
                                                                         NSString *feedString = [NSString stringWithContentsOfURL:filePath
                                                                                                                         encoding:NSUTF8StringEncoding
                                                                                                                            error:&error];
                                                                         if (error)return;
                                                                         
                                                                         NSDictionary *feedDict = [XMLReader dictionaryForXMLString:feedString error:&error];                                                                    
                                                                         
                                                                         if (error) return;
                                                                         
                                                                         NSDictionary *userInfo = @{@"feed":feedDict};
                                                                         NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
                                                                         [notificationCenter postNotificationName:KODDownloadFeedNotification object:userInfo];
                                                                     }];
    [downloadTask resume];
}

@end
