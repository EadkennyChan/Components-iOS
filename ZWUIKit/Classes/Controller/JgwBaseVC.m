//
//  JgwBaseVC.m
//  BaseUI
//
//  Created by Eadkenny on 2018/12/27.
//

#import "JgwBaseVC.h"
//#import "UIColor+SuperCode.h"
#import "UIViewController+NavigationBackround.h"
//#import "UIViewController+Navigation.h"
#import "ZWIntrinsicControl.h"
#import "ZWUtilt+Macros.h"
#import "ZWVertifyStringKit.h"

@interface JgwBaseVC ()

@end

@implementation JgwBaseVC

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self initSubviews];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloginSucceed) name:@"kMsgReLoginSucceed" object:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initSubviews
{
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (UIBarButtonItem *)defaultLeftBackItem
{
    UIImage *image = [UIImage imageNamed:@"icon_arrow_left_lightblack_10_18"];
    ZWIntrinsicControl *btn = [[ZWIntrinsicControl alloc] initWithFrame:CGRectMake(0, 0, image.size.width + 30.0, nav_bar_height)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [btn addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn);
        make.size.mas_equalTo(image.size);
        make.centerY.equalTo(btn);
    }];
    SEL action = NSSelectorFromString(@"respondsToLeftItemClick");
    if ([self.navigationController respondsToSelector:action])
    {
        [btn addTarget:self.navigationController action:action forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_blockAppearFinished)
    {
        _blockAppearFinished();
        _blockAppearFinished = nil;
    }
}

- (void)reloginSucceed
{
}

#pragma mark

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -

+ (BOOL)isChineseOrLetter:(NSString *)strText
{
    NSString *regex = @"^[\u4e00-\u9fa5a-zA-Z]+$";
    return execRegEx(regex, strText);
}

+ (BOOL)isDigitOrLetter:(NSString *)strText
{
    NSString *regex = @"^[a-zA-Z0-9]+$";
    return execRegEx(regex, strText);
}

@end
