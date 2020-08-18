//
//  AMapManager.m
//
//  Created by Eadkenny on 2018/11/23.
//

#import "JgwHUD.h"

@implementation JgwHUD

+ (void)setup
{
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD setErrorImage:nil];
}

+ (void)showMaskLoadingHUD
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:@"正在加载，请稍后..."];
}

+ (void)showMaskUploadingPictureWithProgress:(CGFloat)progress
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showProgress:progress status:@"正在上传图片..."];
}

+ (void)showDeleteSuccessHUD
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
}

+ (void)showNoRelateData
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showInfoWithStatus:@"暂无相关数据"];
}

+ (void)showInfo:(NSString *)strMsg
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showInfoWithStatus:strMsg];
}
@end
