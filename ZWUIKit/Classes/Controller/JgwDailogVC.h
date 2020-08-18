//
//  JgwDailogVC.h
//  BaseUI
//
//  Created by Eadkenny on 2018/12/28.
//

#import <UIKit/UIKit.h>
#import "ZWMacroDef.h"
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface JgwDailogVC : UIViewController

/**
 显示遮挡层 (包括导航栏、状态栏)
 @param fAlpha 透明度
 */
- (void)showMaskBkWithAlpha:(CGFloat)fAlpha;
/**
 在当前self.view上显示半透明遮挡层
 */
- (void)showMaskBkOnViewWithAlpha:(CGFloat)fAlpha;
- (void)hiddenMaskBk;
/**
 显示遮挡层 (全屏)
 @param fAlpha 透明度
        fY :遮挡层顶部开始位置
        fHeight :遮挡层高度
 @ret  内容view，可在该view上自定义内容
 */
- (UIView *)showGlobalMaskWithAlpha:(CGFloat)fAlpha top:(CGFloat)fY height:(CGFloat)fHeight;

/*
 *  @brief：弹出选择窗，弹窗一般为UIPickerView或者UIDatePicker
 *  @param：
 *      classPicker：弹窗类名
 *      dataSource：弹窗类数据源
 */
- (nonnull UIView *)showPicker:(nonnull Class)classPicker delegate:(nullable id)dataSource okSelector:(nonnull SEL)selector isDefault:(BOOL)style;
- (void)hiddenPicker;

/**
 键盘类弹出窗上方的toolbar
 @param target 确定和取消按钮时间响应对象
 @param okSelector 确定按钮点击响应方法
 @param cancelSelector 取消按钮点击响应方法
 @param bIsDefault default场景下，按钮标题为黑色
 @return toolbar
 */
+ (nonnull UIView *)toolbarForKeyboard:(id)target ok:(nonnull SEL)okSelector cancel:(nonnull SEL)cancelSelector isDefault:(BOOL)bIsDefault;
+ (nonnull UIPickerView *)pickerForInputView;
+ (nonnull UIDatePicker *)datePickerForInputView;

- (void)alertView:(nullable NSString *)strTitle selectionTitles:(NSArray<NSString *> *)titles handlers:(NSArray<BlockObject> *)handlers cancelTitle:(NSString *)strCancelTitle;

/**
 判断相册或相机的权限
 @param sourceType 来源
 */
- (void)openPhotoSource:(UIImagePickerControllerSourceType)sourceType;
@end

NS_ASSUME_NONNULL_END
