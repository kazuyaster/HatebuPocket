//
//  ViewController.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/10/27.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import "ViewController.h"
#import "FeedManager.h"

#define BASE_URL @"http://b.hatena.ne.jp/entrylist/it?sort=hot&threshold=&mode=rss"


@interface ViewController (){
    FeedManager *_feedManager;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _feedManager = [[FeedManager alloc] init];
    NSDictionary *feedDict = [_feedManager dictionaryFromRSSWithURL:BASE_URL];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(downloadedFeed:) name:KODDownloadFeedNotification object:nil];
    NSLog(@"%@",feedDict);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}

-(void)downloadedFeed:(NSNotification*)notification{
    NSLog(@"DOWNLOADED:%@",notification);
}

@end