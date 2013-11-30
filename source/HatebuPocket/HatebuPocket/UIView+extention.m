//
//  UIView+extention.m
//  HatebuPocket
//
//  Created by 小田 和哉 on 2013/11/30.
//  Copyright (c) 2013年 小田 和哉. All rights reserved.
//

#import "UIView+extention.h"

@implementation UIView (extention)

+ (id)loadFromNib
{
    NSString *nibName = NSStringFromClass([self class]);
    return [UINib nibWithNibName:nibName bundle:nil];
//    return [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
}

@end
