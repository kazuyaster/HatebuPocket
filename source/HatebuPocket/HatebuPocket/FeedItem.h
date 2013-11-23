//
//  FeedItem.h
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/23.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *encodedContent;
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *subject;
@property(nonatomic,strong) NSString *description;
@property(nonatomic,strong) NSString *bookmarkCount;
@property(nonatomic,strong) NSString *link;
@property(nonatomic,strong) NSString *about;

- (id)initWithTitle:(NSString*)title
      encodeContent:(NSString*)content
               date:(NSString*)date
            subject:(NSString*)subject
        description:(NSString*)desctiption
      bookmarkCount:(NSString*)bookmarkCount
               link:(NSString*)link
              about:(NSString*)about;

- (BOOL)isEqualToOtherItem:(FeedItem*)otherItem;
@end
