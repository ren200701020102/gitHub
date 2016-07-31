//
//  NavigationControllerDelegate.m
//  隐藏导航栏
//
//  Created by 任海平 on 16/7/30.
//  Copyright © 2016年 任海平. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "NavigationTransitionAnimation.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface NavigationControllerDelegate ()

@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;

@property(nonatomic,strong)NavigationTransitionAnimation *animation;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@property (nonatomic,assign)BOOL interActiving;

@end

@implementation NavigationControllerDelegate

- (void)awakeFromNib {
    
    self.animation = [[NavigationTransitionAnimation alloc] init];
    
    self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
    
    [self.navigationController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        _animation.animationType = @"pop";
    }else{
        _animation.animationType = @"push";
    }
    
    return _animation;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interActiving ? self.interactionController : nil;
}


- (void)handleGesture:(UIPanGestureRecognizer *)gesture {
    UIView* view = self.navigationController.view;
    CGPoint location = [gesture locationInView:gesture.view];
    CGPoint translation = [gesture translationInView:gesture.view];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            _interActiving = YES;
            if (location.x < CGRectGetMidX(view.bounds) && self.navigationController.viewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = fabs(translation.x / view.bounds.size.width);
            [_interactionController updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            _interActiving = NO;
            CGFloat fraction = fabs(translation.x / view.bounds.size.width);
            if (fraction < 0.5 || [gesture velocityInView:view].x < 0 || gesture.state == UIGestureRecognizerStateCancelled) {
                [_interactionController cancelInteractiveTransition];
            } else {
                [_interactionController finishInteractiveTransition];
            }
            
            break;
        }
        default:
            break;
    }
}



@end
