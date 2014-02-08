//
//  FeedManager.h
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/11/23.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedDownloader : NSObject

- (void)dictionaryFromRSSWithURL:(NSString*)urlString;
@end
