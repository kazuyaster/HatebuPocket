//
//  HotEntrySelectDelegate.h
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/24.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedItem;

@protocol HotEntrySelectDelegate <NSObject>
- (void)selected:(FeedItem*)item;
@end
