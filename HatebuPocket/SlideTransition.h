//
//  SlideTransition.h
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/12/22.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SlideTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) BOOL presenting;

@end
