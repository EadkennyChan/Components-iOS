//
//  JgwTopTipVC.h
//  BaseUI
//
//  Created by Eadkenny on 2018/12/27.
//

#import "JgwDailogVC.h"

NS_ASSUME_NONNULL_BEGIN
/**
 顶部提示窗管理控制器
 */
@interface JgwTopTipVC<__covariant ViewType> : JgwDailogVC

- (ViewType)contentView;

- (void)showTopTipMsg:(NSString *)strMsg;

- (void)showTopTipView:(__kindof UIView *)customView;

- (void)hiddenTopTip;

- (void)cancelFirstRespond;

- (void)setupBottomView:(__kindof UIView *)bottomView height:(CGFloat)fHeight;

@end

NS_ASSUME_NONNULL_END
