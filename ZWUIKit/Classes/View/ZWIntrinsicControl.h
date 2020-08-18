//
//  UIView+intrinsicContentSize.h
//  AccountManager
//
//  Created by  eadkenny on 2019/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 为了解决iOS11之后，通过UIBarButtonItem的initWithCustomView添加UIControl导致UIBarButtonItem
 最后显示时size为0的问题
 建议了解知识点UIStackView
 https://www.jianshu.com/p/1c64ab77f25c
 */
@interface ZWIntrinsicControl : UIControl

@end

NS_ASSUME_NONNULL_END
