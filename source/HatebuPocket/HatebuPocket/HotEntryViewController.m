//
//  ViewController.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/10/27.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import "HotEntryViewController.h"
#import "FeedDownloader.h"
#import "FeedItemManager.h"
#import "FeedItem.h"

#define BASE_URL @"http://b.hatena.ne.jp/entrylist/%@?sort=hot&threshold=&mode=rss"


@interface HotEntryViewController (){
    FeedDownloader *_feedDownloader;
    FeedItemManager *_feedManager;
}

@end

@implementation HotEntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _feedDownloader = [[FeedDownloader alloc] init];
    [_feedDownloader dictionaryFromRSSWithURL:[NSString stringWithFormat:BASE_URL,_categoryKeyword]];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(downloadedFeed:) name:KODDownloadFeedNotification object:nil];
    
    _feedManager = [[FeedItemManager alloc]init];
    _myTableView.dataSource = _feedManager;
    _myTableView.dataSource = _feedManager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}

-(void)downloadedFeed:(NSNotification*)notification{
    
    NSMutableArray *items = [[NSMutableArray alloc]init];

    NSDictionary *feedDict = (NSDictionary*)notification;
    
    @try {

        NSArray *tmpItems = [feedDict valueForKeyPath:@"object.feed.rdf:RDF.item"];
        
        for (NSDictionary *tmpDict in tmpItems) {

            NSLog(@"%@",[tmpDict valueForKeyPath:@"title.text"]);
            NSLog(@"%@",[tmpDict valueForKeyPath:@"content:encoded.text"]);
            NSLog(@"%@",[tmpDict valueForKeyPath:@"dc:date.text"]);
            NSLog(@"%@",[tmpDict valueForKeyPath:@"dc:subject.text"]);
            NSLog(@"%@",[tmpDict valueForKeyPath:@"description.text"]);
            NSLog(@"%@",[tmpDict valueForKeyPath:@"hatena:bookmarkcount.text"]);
            NSLog(@"%@",[tmpDict valueForKeyPath:@"link.text"]);
            NSLog(@"%@",[tmpDict valueForKeyPath:@"rdf:about"]);
            
            FeedItem *item = [[FeedItem alloc]initWithTitle:[tmpDict valueForKeyPath:@"title.text"]
                                              encodeContent:[tmpDict valueForKeyPath:@"content:encoded.text"]
                                                       date:[tmpDict valueForKeyPath:@"dc:date.text"]
                                                    subject:[tmpDict valueForKeyPath:@"dc:subject.text"]
                                                description:[tmpDict valueForKeyPath:@"description.text"]
                                              bookmarkCount:[tmpDict valueForKeyPath:@"hatena:bookmarkcount.text"]
                                                       link:[tmpDict valueForKeyPath:@"link.text"]
                                                      about:[tmpDict valueForKeyPath:@"rdf:about"]];
            [items addObject:item];
        }
        
        NSLog(@"%@",items);
        _feedManager.items = items;
        [_myTableView reloadData];
        
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:exception.name
                                                       message:exception.reason
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"OK", nil];
        [alert show];
    }
    @finally {
        
    }
}

@end