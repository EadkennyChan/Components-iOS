//
//  JgwTabBarController.h
//
//  Created by eadkennychan on 2020/05/06.
//  Copyright © 2020年 eadkennychan. All rights reserved.
//
//  Github地址：https://github.com/EadkennyChan/

#import <UIKit/UIKit.h>
#import "ZWMacroDef.h"

NS_ASSUME_NONNULL_BEGIN

@interface JgwTabBarController : UITabBarController

//ViewDidAppear完成后调用的block
@property (nonatomic, copy, nonnull)BlockVoid blockAppearFinished;
// 完成后调用的block，不需要再block中popViewController
@property (nonatomic, copy, nullable)BlockObject blockComplete;

@end

NS_ASSUME_NONNULL_END
