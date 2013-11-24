//
//  FeedItemManager.m
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/23.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import "FeedItemManager.h"
#import "FeedItem.h"

@implementation FeedItemManager

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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    
    cell.textLabel.text = ((FeedItem*)_items[indexPath.row]).title;
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

@end
