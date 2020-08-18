//
//  JgwNavigationController.m
//
//  Created by eadkennychan on 2020/05/06.
//  Copyright © 2020年 eadkennychan. All rights reserved.
//
//  Github地址：https://github.com/EadkennyChan/

#import "JgwNavigationController.h"
//#import "UINavigationController+BarButtonItem.h"

@interface JgwNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JgwNavigationController

- (void)viewDidLoad {
  [super viewDidLoad];
//  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)showBottomLine:(BOOL)bShow
{
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  if (self.childViewControllers.count > 0)
  {
    viewController.hidesBottomBarWhenPushed = YES;
  }
  [super pushViewController:viewController animated:animated];
  if (self.childViewControllers.count > 1)
  {
    SEL aSelector = NSSelectorFromString(@"setDefaultBackBarButtonItem");
    if ([viewController respondsToSelector:aSelector]) {
      [viewController performSelector:aSelector];
    }
  }
}

#pragma mark - overide

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
  self = [super initWithRootViewController:rootViewController];
  if (self)
  {
    self.interactivePopGestureRecognizer.delegate = self;
  }
  return self;
}

@end


#pragma mark - UIGestureRecognizerDelegate

@implementation JgwNavigationController (gesture)

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin:)])
  {
    id<UIGestureRecognizerDelegate> topVC = (id<UIGestureRecognizerDelegate>)self.topViewController;
    return [topVC gestureRecognizerShouldBegin:gestureRecognizer];
  }
  return (self.viewControllers.count > 1);//关闭主界面的右滑返回
}

@end
