//
//  FeedItemManager.h
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/23.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotEntrySelectDelegate.h"

@class FeedItem;

@interface FeedItemManager : NSObject <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,strong) id<HotEntrySelectDelegate> delegate;

+ (id)sharedManager;
- (void)addItem:(FeedItem*)item;
- (void)insertItem:(FeedItem*)item atIndex:(int)index;
- (void)removeItemAtIndex:(int)index;
- (void)moveItemAtInex:(int)fromIndex toIndex:(int)toIndex;
- (void)downloadedFeed:(NSNotification*)notification;
@end
