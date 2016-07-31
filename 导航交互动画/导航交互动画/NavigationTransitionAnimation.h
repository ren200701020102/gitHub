//
//  NavigationTransitionAnimation.h
//  隐藏导航栏
//
//  Created by 任海平 on 16/7/30.
//  Copyright © 2016年 任海平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NavigationTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, copy) NSString *animationType;

@end
