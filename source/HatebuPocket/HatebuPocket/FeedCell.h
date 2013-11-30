//
//  FeedCell.h
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/30.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *description;

+ (CGFloat)cellHeight;
@end
