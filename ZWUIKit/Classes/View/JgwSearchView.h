//
//  ZWLabelTextViewCell.h
//  SCBase
//
//  Created by Eadkenny on 2018/1/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 导航栏上的搜索窗
 */
@interface JgwSearchView : UIView

@property (nonatomic, copy, nullable)NSString *strKeyword;
@property (nonatomic, copy, nullable)NSString *strPlaceholder;
@property (nonatomic, retain, nullable)UIColor *placeholderColor;
@property(nullable, nonatomic,weak)id<UITextFieldDelegate> delegate;
@property (nonatomic, copy, nullable)BlockVoid blockCancel;
@property (nonatomic, copy, nullable)BlockObject blockTextChanged;

+ (JgwSearchView *)navSearchView:(CGRect)frame placeholder:(NSString *)strPlaceholder;

- (void)showBottomLine:(BOOL)bShow;

@end

@interface UIControl (JgwPlaceHolderSearchView)

//搜索占位控件条，不可输入，圆角
+ (UIControl *)placeholderSearchView:(NSString *)strText;

//搜索占位控件条，不可输入，半圆形
+ (UIControl *)placeholderArchSearchView:(NSString *)strText;

@end

NS_ASSUME_NONNULL_END
