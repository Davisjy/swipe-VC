//
//  JYTabBarController.m
//  UITabbarController swipe
//
//  Created by qingyun on 15/12/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "JYTabBarController.h"


typedef NS_OPTIONS (NSUInteger, JYType){
    JYTypeJ = 1 << 0,
    JYTypeY = 1 << 1
};

@interface JYTabBarController ()
{
    NSInteger _maxCount;
}
@end

@implementation JYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)swipeHandle:(UISwipeGestureRecognizer *)gesture
{
    _maxCount = self.childViewControllers.count;
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self tabBar:self.tabBar didSwipeIndex:self.selectedIndex == _maxCount ? _maxCount : self.selectedIndex + 1 ];
        self.selectedIndex ++;
    } else {
        [self tabBar:self.tabBar didSwipeIndex:self.selectedIndex == 0 ? 0 : self.selectedIndex - 1 ];
        self.selectedIndex --;
    }
}

- (void)tabBar:(UITabBar *)tabBar didSwipeIndex:(NSInteger)index
{
    NSInteger oldIndex = self.selectedIndex;
    NSInteger newIndex = index;
    
    if (oldIndex == newIndex) return;
    
    if (newIndex == _maxCount) return;
    
    if (newIndex == 0) return;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    if (oldIndex < newIndex) {
        transition.subtype = kCATransitionFromRight;
    } else {
        transition.subtype = kCATransitionFromLeft;
    }
    
    //NSLog(@"%@", self.view.subviews[0]);
    
    [[self.view.subviews[0] layer] addAnimation:transition forKey:@"switchView"];
}






@end
