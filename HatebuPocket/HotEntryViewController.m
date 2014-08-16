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
#import "HotEntrySelectDelegate.h"
#import "ItemViewController.h"
#import "FeedCell.h"

#define BASE_URL @"http://b.hatena.ne.jp/entrylist/%@?sort=count&threshold=&mode=rss"


@interface HotEntryViewController () <HotEntrySelectDelegate>{
    FeedDownloader *_feedDownloader;
}

@end

@implementation HotEntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _feedDownloader = [[FeedDownloader alloc] init];
    [_feedDownloader dictionaryFromRSSWithURL:[NSString stringWithFormat:BASE_URL,_categoryKeyword]];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:[FeedItemManager sharedManager] selector:@selector(downloadedFeed:) name:KODDownloadFeedNotification object:nil];
    
    _tableView.dataSource = [FeedItemManager sharedManager];
    _tableView.delegate = [FeedItemManager sharedManager];
    
    [_tableView registerNib:[FeedCell loadFromNib] forCellReuseIdentifier:@"FeedCell"];
    [[FeedItemManager sharedManager] setItems:[NSMutableArray array]];
    
    [[FeedItemManager sharedManager] addObserver:self forKeyPath:@"items" options:NSKeyValueObservingOptionNew context:nil];
    
    [[FeedItemManager sharedManager] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{

    
    [[FeedItemManager sharedManager]removeObserver:self forKeyPath:@"items" context:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:[FeedItemManager sharedManager]];
}

- (void)selected:(FeedItem *)item{
    
    ItemViewController *itemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"itemWebView"];
    [itemViewController setUrlString:item.link];
    [itemViewController setTitle:item.title];
    [self.navigationController pushViewController:itemViewController animated:YES];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    if (object == [FeedItemManager sharedManager] && [keyPath isEqualToString:@"items"]) {
        
        NSIndexSet *indexSet = change[NSKeyValueChangeIndexesKey];
        if (indexSet == nil) {
            return;
        }
        NSKeyValueChange changeKind = (NSKeyValueChange)[change[NSKeyValueChangeKindKey] integerValue];
        NSMutableArray *indexPaths = [NSMutableArray array];
        
        [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
        }];

        
        [self.tableView beginUpdates];
        if (changeKind == NSKeyValueChangeInsertion) {
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else if (changeKind == NSKeyValueChangeRemoval){
            [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else if (changeKind == NSKeyValueChangeReplacement){
            [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        [self.tableView endUpdates];
        [self.tableView reloadData];
    }
}


@end