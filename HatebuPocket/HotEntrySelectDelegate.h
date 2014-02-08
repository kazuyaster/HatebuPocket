//
//  HotEntrySelectDelegate.h
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/11/24.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedItem;

@protocol HotEntrySelectDelegate <NSObject>
- (void)selected:(FeedItem*)item;
@end
