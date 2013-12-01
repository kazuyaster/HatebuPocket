//
//  FeedManager.h
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/23.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedDownloader : NSObject

- (void)dictionaryFromRSSWithURL:(NSString*)urlString;
@end
