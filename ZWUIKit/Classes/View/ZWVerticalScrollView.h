//
//  ZWContentScrollView.h
//  
//
//  Created by Eadkenny on 2018/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 常用按钮
 */
@interface ZWVerticalScrollView : UIScrollView

@property (nonatomic, assign)BOOL bAlwaysCanScroll;

- (void)setLastBottomSubview:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
