//
//  SlideTransition.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/12/22.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import "SlideTransition.h"

@implementation SlideTransition

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0f;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];
    
    CGRect inFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect outFrame = CGRectOffset(inFrame, CGRectGetWidth(inFrame), 0);
    
    if (self.presenting) {
        [containerView addSubview:toView];
        
        fromView.frame = inFrame;
        toView.frame = outFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toView.frame = inFrame;
                         } completion:^(BOOL finished) {
                             BOOL completed = ![transitionContext transitionWasCancelled];
                             [transitionContext completeTransition:completed];
                         }
         ];
    }else{
        [containerView insertSubview:toView aboveSubview:fromView];
        toView.frame = inFrame;
        fromView.frame = inFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                            fromView.frame = outFrame;
                         } completion:^(BOOL finished) {
                            BOOL completed = ![transitionContext transitionWasCancelled];
                            [transitionContext completeTransition:completed];
                         }
         ];
    }
    
}

@end
