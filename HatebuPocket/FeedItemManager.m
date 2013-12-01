//
//  FeedItemManager.m
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/23.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import "FeedItemManager.h"
#import "FeedItem.h"
#import "FeedCell.h"

static FeedItemManager *_sharedInstance = nil;

@implementation FeedItemManager

+ (id)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[FeedItemManager alloc]init];
    });
    return _sharedInstance;
}

- (id)init{
    
    self = [super init];
    if(!self){
        return nil;
    }
    
    //初期化
    _items = [[NSMutableArray alloc]init];
    
    return self;
}

- (void)addItem:(FeedItem*)item{
    if (!item){
        return;
    }
    
    [_items addObject:item];
}

- (void)insertItem:(FeedItem*)item atIndex:(int)index{
    
    if(!item){
        return;
    }
    
    if(index < 0 || index > _items.count){
        return;
    }
    
    [_items insertObject:item atIndex:index];
}

- (void)removeItemAtIndex:(int)index{
    if(index < 0 || index > _items.count - 1){
        return;
    }
    [_items removeObjectAtIndex:index];
}

- (void)moveItemAtInex:(int)fromIndex toIndex:(int)toIndex{
    
    if (fromIndex < 0 || fromIndex > _items.count - 1){
        return;
    }
    
    if (toIndex < 0 || toIndex > _items.count - 1){
        return;
    }
    
    FeedItem *item;
    item = _items[fromIndex];
    [_items removeObject:item];
    [_items insertObject:item atIndex:toIndex];
    
}

#pragma mark -- UITableviewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FeedCell cellHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"FeedCell";
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    
    cell.title.text = ((FeedItem*)_items[indexPath.row]).title;
    cell.description.text = ((FeedItem*)_items[indexPath.row]).description;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate) {
        if ([_delegate conformsToProtocol:@protocol(HotEntrySelectDelegate) ]) {
            if ([_delegate respondsToSelector:@selector(selected:)]) {
                
                [_delegate performSelector:@selector(selected:) withObject:_items[indexPath.row]];
            }
        }
    }
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
        [[self mutableArrayValueForKey:@"items"] insertObjects:items
                                                     atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];

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
