//
//  FeedItem.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/11/23.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import "FeedItem.h"

@implementation FeedItem

- (id)initWithTitle:(NSString*)title
      encodeContent:(NSString*)content
               date:(NSString*)date
            subject:(NSString*)subject
        description:(NSString*)desctiption
      bookmarkCount:(NSString*)bookmarkCount
               link:(NSString*)link
              about:(NSString*)about{
    
    self = [super init];
    if (self) {
        _title = title;
        _encodedContent = content;
        _date = date;
        _subject = subject;
        _description = desctiption;
        _bookmarkCount = bookmarkCount;
        _link = link;
        _about = about;
    }
    return self;
}

- (BOOL)isEqualToOtherItem:(FeedItem*)otherItem{
    if (self == otherItem) {
        return YES;
    }
    if ( ![_title isEqualToString:otherItem.title] ) {
        return NO;
    }
    if ( ![_encodedContent isEqualToString:otherItem.encodedContent] ) {
        return NO;
    }
    if ( ![_date isEqualToString:otherItem.date] ) {
        return NO;
    }
    if ( ![_subject isEqualToString:otherItem.subject] ) {
        return NO;
    }
    if ( ![_description isEqualToString:otherItem.description] ) {
        return NO;
    }
    if ( ![_bookmarkCount isEqualToString:otherItem.bookmarkCount] ) {
        return NO;
    }
    if ( ![_link isEqualToString:otherItem.link] ) {
        return NO;
    }
    if ( ![_about isEqualToString:otherItem.about] ) {
        return NO;
    }
    
    return YES;
}

- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    return [self isEqualToOtherItem:object];
}

- (NSUInteger)hash{
    return _title.hash ^ _encodedContent.hash ^ _date.hash ^ _subject.hash ^ _description.hash ^ _bookmarkCount.hash ^ _link.hash ^ _about.hash;
}

@end
