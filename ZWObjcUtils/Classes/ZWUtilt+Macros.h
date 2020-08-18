//
//  UILabel+SuperCode.h
//  SCBaseUI
//
//  Created by Eadkenny on 2018/11/8.
//

#define current_app_version ((NSString *)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]).floatValue

//状态栏高度
#define status_bar_height  [[UIApplication sharedApplication] statusBarFrame].size.height
#define nav_bar_height  self.navigationController.navigationBar.frame.size.height

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
