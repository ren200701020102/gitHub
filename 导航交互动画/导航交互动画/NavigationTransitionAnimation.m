//
//  NavigationTransitionAnimation.m
//  隐藏导航栏
//
//  Created by 任海平 on 16/7/30.
//  Copyright © 2016年 任海平. All rights reserved.
//

#import "NavigationTransitionAnimation.h"

@implementation NavigationTransitionAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    //UIViewControllerTransitioningDelegate
    return 2;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //通过键值UITransitionContextToViewControllerKey获得需要呈现的试图控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //通过键值UITransitionContextFromViewControllerKey获得需要退出的试图控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect toVcFinalFrame = [transitionContext finalFrameForViewController:toVC];
    
    CGRect fromVcFinalFrame = [transitionContext initialFrameForViewController:fromVC];
    
    NSLog(@"%@..%@",NSStringFromCGRect(toVcFinalFrame),NSStringFromCGRect(fromVcFinalFrame));
    
    if ([self.animationType isEqualToString:@"push"]) {
        
        UIView *containerView = [transitionContext containerView];
        
        toVC.view.frame = CGRectOffset(toVcFinalFrame, ScreenWidth, 0);
        
        [containerView addSubview:toVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromVC.view.frame = CGRectOffset(fromVcFinalFrame, -ScreenWidth, 0);
            toVC.view.frame = toVcFinalFrame;
            
        } completion:^(BOOL finished) {

            [transitionContext completeTransition:YES];
        }];
        
        
    }else{
        UIView *containerView = [transitionContext containerView];
        
        CGRect toVcFinalFrame = [transitionContext finalFrameForViewController:toVC];
        
        toVC.view.frame = CGRectOffset(toVcFinalFrame, -ScreenWidth, 0);
        
        [containerView addSubview:toVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromVC.view.frame = CGRectOffset(fromVcFinalFrame, ScreenWidth, 0);
            toVC.view.frame = toVcFinalFrame;
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }

}

@end
