//
//  JgwDailogVC.m
//  BaseUI
//
//  Created by Eadkenny on 2018/12/28.
//

#import "JgwDailogVC.h"
#import "UITransluentToolbar.h"
//#import "UIColor+SuperCode.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "JgwView.h"
#import "ZWSeperatorLineCell.h"
#import "UtilityUIKit.h"
#import "UIView+AddLine.h"
#import "ZWLog.h"
//#import "ImagePickerController.h"

@interface JgwDailogVC ()// <ImagePickerControllerDelegate>
{
    UIView *m_viewAlertBk;//弹窗灰色背景，点击可取消弹窗
    UIView *m_viewAlertContent;
    UIView *m_picker;
}
//@property (nonatomic, retain)ImagePickerController *pickerPictureVC;
@end

@implementation JgwDailogVC

- (void)loadView {
  self.view = [[JgwView alloc] init];
}

- (void)dealloc
{
    DLog(@"%@", self);
}

- (void)showMaskBkWithAlpha:(CGFloat)fAlpha
{
    UIWindow *window = getApplicationWindow();
    
    UIControl *viewBack = [[UIControl alloc] initWithFrame:window.bounds];
    viewBack.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    viewBack.backgroundColor = [UIColor clearColor];
    [viewBack addTarget:self action:@selector(hiddenMaskBk) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:viewBack];
    m_viewAlertBk = viewBack;
    {
        //半透明背景设置
        UIView *viewBlackAlpha = [[UIView alloc] init];
        viewBlackAlpha.userInteractionEnabled = NO;
        viewBlackAlpha.backgroundColor = [UIColor blackColor];
        viewBlackAlpha.alpha = fAlpha;
        [viewBack addSubview:viewBlackAlpha];
        [viewBlackAlpha mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(viewBack).with.insets(UIEdgeInsetsZero);
        }];
    }
}

- (void)showMaskBkOnViewWithAlpha:(CGFloat)fAlpha
{
    UIControl *viewBack = [[UIControl alloc] initWithFrame:self.view.bounds];
    viewBack.backgroundColor = [UIColor blackColor];
    viewBack.alpha = fAlpha;
    [self.view addSubview:viewBack];
    [viewBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [viewBack addTarget:self action:@selector(hiddenMaskBk) forControlEvents:UIControlEventTouchUpInside];
    m_viewAlertBk = viewBack;
}

- (UIView *)showGlobalMaskWithAlpha:(CGFloat)fAlpha top:(CGFloat)fY height:(CGFloat)fHeight;
{
  if (m_viewAlertBk) {
    return m_viewAlertBk;
  }
  UIWindow *window = getApplicationWindow();
  CGRect frame = window.bounds;
  frame.origin.y = fY;
  frame.size.height = fHeight;
  UIControl *viewBack = [[UIControl alloc] initWithFrame:frame];
  viewBack.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  viewBack.backgroundColor = [UIColor clearColor];
  [viewBack addTarget:self action:@selector(hiddenMaskBk) forControlEvents:UIControlEventTouchUpInside];
  [window addSubview:viewBack];
  m_viewAlertBk = viewBack;
  {
      //半透明背景设置
      UIView *viewBlackAlpha = [[UIView alloc] init];
      viewBlackAlpha.userInteractionEnabled = NO;
      viewBlackAlpha.backgroundColor = [UIColor blackColor];
      viewBlackAlpha.alpha = fAlpha;
      [viewBack addSubview:viewBlackAlpha];
      [viewBlackAlpha mas_makeConstraints:^(MASConstraintMaker *make) {
          make.edges.equalTo(viewBack).with.insets(UIEdgeInsetsZero);
      }];
  }
  return viewBack;
}

- (void)hiddenMaskBk
{
    [m_viewAlertBk removeFromSuperview];
    m_viewAlertBk = nil;
}

//显示收货时间选择view
- (nonnull UIView *)showPicker:(nonnull Class)classPicker delegate:(nullable id)dataSource okSelector:(SEL)selector isDefault:(BOOL)style
{
    UIWindow *window = getApplicationWindow();
    [self showMaskBkWithAlpha:0.4];
    
    CGRect frame = CGRectMake(0, window.bounds.size.height, window.bounds.size.width, 216 + 44);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    if (@available(iOS 13.0, *)) {
      view.backgroundColor = [UIColor colorWithDynamicProvider:^UIColor * (UITraitCollection * trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
          return RGBSAMECOLOR(30);
        } else {
          return [UIColor whiteColor];
        }
      }];
    } else {
      view.backgroundColor = [UIColor whiteColor];
    }
    [m_viewAlertBk addSubview:m_viewAlertContent = view];
    {
        UIView *toolbar = [JgwDailogVC toolbarForKeyboard:self ok:selector cancel:@selector(hiddenPicker) isDefault:style];
        [view addSubview:toolbar];
        [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(view);
            make.height.mas_equalTo(44.0);
        }];
      UIView *viewLine = [[UIView alloc] init];
      viewLine.backgroundColor = [ZWSeperatorLineCell defaultSeperatorLineColor];
      [view addSubview:viewLine];
      [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.top.equalTo(toolbar.mas_bottom);
        make.height.mas_equalTo(SINGLE_LINE_WIDTH);
      }];
        
        UIPickerView *datePicker = [[classPicker alloc] init];
        if ([datePicker isKindOfClass:[UIDatePicker class]])
        {
            UIDatePicker *picker = (UIDatePicker *)datePicker;
            picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        }
        if (dataSource)
        {
            if ([datePicker respondsToSelector:@selector(setDelegate:)])
                datePicker.delegate = dataSource;
            if ([datePicker respondsToSelector:@selector(setDataSource:)])
                datePicker.dataSource = dataSource;
        }
        [view addSubview:m_picker = datePicker];
        [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(view);
            make.top.equalTo(toolbar.mas_bottom);
        }];
    }
    
    frame.origin.y -= frame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        view.frame = frame;
    }];
    return m_picker;
}

//关闭收货时间选择view
- (void)hiddenPicker
{
    UIView *window = m_viewAlertBk.superview;
    
    __weak typeof(m_viewAlertContent) weakAlert = m_viewAlertContent;
    __weak typeof(m_viewAlertBk) weakAlertBk = m_viewAlertBk;
    CGRect frame = m_viewAlertContent.frame;
    frame.origin.y = window.frame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        weakAlert.frame = frame;
    } completion:^(BOOL finished) {
        [weakAlertBk removeFromSuperview];
    }];
    m_viewAlertContent = nil;
    m_viewAlertBk = nil;
}

+ (UIView *)toolbarForKeyboard:(id)target ok:(nonnull SEL)okSelector cancel:(nonnull SEL)cancelSelector isDefault:(BOOL)bIsDefault
{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height = 44.0;
    UIView *viewToolbar = [[UIView alloc] initWithFrame:frame];
    
    UIFont *font = [UIFont systemFontOfSize:16];
    NSString *strMsg = @"取消";
    CGFloat fTextWidth = getSizeForText(strMsg, font).width + 30.0;
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setTitle:strMsg forState:UIControlStateNormal];
    btnCancel.titleLabel.font = font;
    [btnCancel addTarget:target action:cancelSelector forControlEvents:UIControlEventTouchUpInside];
    [viewToolbar addSubview:btnCancel];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(viewToolbar);
        make.width.mas_equalTo(fTextWidth);
    }];
    
    strMsg = @"确定";
    fTextWidth = getSizeForText(strMsg, font).width + 30.0;
    UIButton *btnOk = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOk setTitle:strMsg forState:UIControlStateNormal];
    btnOk.titleLabel.font = font;
    [btnOk addTarget:target action:okSelector forControlEvents:UIControlEventTouchUpInside];
    [viewToolbar addSubview:btnOk];
    [btnOk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(viewToolbar);
        make.width.mas_equalTo(fTextWidth);
    }];
    
    if (bIsDefault)
    {
        if (@available(iOS 13.0, *)) {
          [btnOk setTitleColor:[UIColor colorWithDynamicProvider:^UIColor * (UITraitCollection * trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
              return [UIColor whiteColor];
            } else {
              return [UIColor blackColor];
            }
          }] forState:UIControlStateNormal];
          [btnCancel setTitleColor:[UIColor colorWithDynamicProvider:^UIColor * (UITraitCollection * trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
              return [UIColor whiteColor];
            } else {
              return [UIColor blackColor];
            }
          }] forState:UIControlStateNormal];
        } else {
          [btnOk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    else
    {
    }
    return viewToolbar;
}

+ (UIPickerView *)pickerForInputView
{
    CGFloat fWidth = [UIScreen mainScreen].bounds.size.width;
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, fWidth, 216)];
    return picker;
}

+ (UIDatePicker *)datePickerForInputView
{
    CGFloat fWidth = [UIScreen mainScreen].bounds.size.width;
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, fWidth, 216)];
    picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    return picker;
}

- (void)alertView:(NSString *)strTitle selectionTitles:(NSArray<NSString *> *)titles handlers:(NSArray<BlockObject> *)handlers cancelTitle:(NSString *)strCancelTitle
{
    if (@available(iOS 8.0, *))
    {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:strTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        if (strCancelTitle.length > 0)
        {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:strCancelTitle style:UIAlertActionStyleCancel handler:nil];
            [sheet addAction:cancelAction];
        }
        
        NSInteger nCount = titles.count;
        if (handlers.count < nCount)
        {
            nCount = handlers.count;
        }
        UIAlertAction *action;
        NSString *strText;
        BlockObject handler;
        for (NSInteger n = 0; n < nCount; n++)
        {
            strText = titles[n];
            handler = handlers[n];
            action = [UIAlertAction actionWithTitle:strText style:UIAlertActionStyleDefault handler:handler];
            [sheet addAction:action];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:sheet animated:YES completion:nil];
        });
    }
}
/*
#pragma mark - 照片

- (void)alertPictureSourceSelecteOptionalView
{
    NSString *strTitle = nil;
    NSString *strBtnTitle1 = @"拍照";
    NSString *strBtnTitle2 = @"从相册选择";
    
    if (@available(iOS 8.0, *))
    {
        WeakObject(self);
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:strTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:strBtnTitle1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakObject openPhotoSource:UIImagePickerControllerSourceTypeCamera];
        }];
        UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:strBtnTitle2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakObject openPhotoSource:UIImagePickerControllerSourceTypePhotoLibrary];
        }];
        [sheet addAction:cancelAction];
        [sheet addAction:deleteAction];
        [sheet addAction:archiveAction];
        [self presentViewController:sheet animated:YES completion:nil];
    }
}

- (void)openPhotoSource:(UIImagePickerControllerSourceType)sourceType
{
    NSString *strTipContent = getAppDisplayName();
    if (strTipContent.length == 0)
    {
        strTipContent = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        strTipContent = [NSString stringWithFormat:@"请在iPhone的“设置”-“隐私”-“相册”功能中，找到“%@”打开相册访问权限", strTipContent];
        BOOL bDetermined = YES;
        if (@available(iOS 8.0, *))
        {
            bDetermined = [PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusNotDetermined;
            if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied || PHAuthorizationStatusRestricted == [PHPhotoLibrary authorizationStatus])
            {
                showAlertMsg((id<UIAlertViewDelegate>)self, strTipContent, nil, @"确定", nil, nil, nil);
            }
            else
            {
                WeakObject(self);
                ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
                    showAlertMsg((id<UIAlertViewDelegate>)self, strTipContent, nil, @"确定", nil, nil, nil);
                };
                ALAssetsLibraryGroupsEnumerationResultsBlock block = ^(ALAssetsGroup *group, BOOL *stop){
                    [weakObject presentPicturePickerVC:sourceType];
                };
                [[ALAssetsLibrary alloc] enumerateGroupsWithTypes:ALAssetsGroupLibrary
                                                       usingBlock:block
                                                     failureBlock:failureBlock];
            }
        }
    }
    else
    {
        strTipContent = [NSString stringWithFormat:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“%@”打开相册访问权限", strTipContent];
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == ALAuthorizationStatusDenied || authStatus == ALAuthorizationStatusRestricted)
        {
            showAlertMsg((id<UIAlertViewDelegate>)self, strTipContent, nil, @"确定", nil, nil, nil);
            return;
        }
        else
        {
            __weak UIViewController *pickerImageVC = self.pickerPictureVC;
            WeakObject(self);
            dispatch_block_t handle = ^{
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
                {
                    [pickerImageVC dismissViewControllerAnimated:YES completion:nil];
                    showAlertMsg((id<UIAlertViewDelegate>)weakObject, strTipContent, @"确定" , nil, nil, nil, nil);
                }
                else
                {
                    [weakObject presentPicturePickerVC:sourceType];
                }
            };
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), handle);
            }];
        }
    }
}

- (void)presentPicturePickerVC:(UIImagePickerControllerSourceType)sourceType
{
    ImagePickerController *picker = [[ImagePickerController alloc] init];
    UIImage *imageNavBk = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    [picker.navigationBar setBackgroundImage:imageNavBk forBarMetrics:UIBarMetricsDefault];
    [picker.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorBlackText]}];
    [picker.navigationBar setTintColor:[UIColor whiteColor]];
    picker.delegateSelImage = self;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
    self.pickerPictureVC = picker;
}

- (void)imagePickerController:(nonnull UIImagePickerController *)picker didFinishPickingImage:(nonnull UIImage *)image
{    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}*/

@end
