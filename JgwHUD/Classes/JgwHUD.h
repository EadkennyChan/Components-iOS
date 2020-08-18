//
//  AMapManager.h
//
//
//  Created by Eadkenny on 2018/11/23.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface JgwHUD : NSObject

+ (void)setup;

/**
 显示 "正在加载，请稍后..."，不可点击其他部分
 */
+ (void)showMaskLoadingHUD;

/**
 显示“正在上传图片...”，不可点击其他部分
 */
+ (void)showMaskUploadingPictureWithProgress:(CGFloat)progress;
/**
 显示“删除成功”
 */
+ (void)showDeleteSuccessHUD;

+ (void)showNoRelateData;

+ (void)showInfo:(NSString *)strMsg;

@end

NS_ASSUME_NONNULL_END
