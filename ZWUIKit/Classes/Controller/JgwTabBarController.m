//
//  JgwTabBarController.m
//
//  Created by eadkennychan on 2020/05/06.
//  Copyright © 2020年 eadkennychan. All rights reserved.
//
//  Github地址：https://github.com/EadkennyChan/

#import "JgwTabBarController.h"

@interface JgwTabBarController ()

@end

@implementation JgwTabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  if (@available(iOS 13.0, *)) {
    self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
  } else {
    // Fallback on earlier versions
  }
//  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (_blockAppearFinished) {
    _blockAppearFinished();
    _blockAppearFinished = nil;
  }
}

@end
