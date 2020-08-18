//
//  JgwTopTipVC.m
//  BaseUI
//
//  Created by Eadkenny on 2018/12/27.
//

#import "JgwTopTipVC.h"
#import <objc/runtime.h>
#import "UtilityUIKit.h"
#import "UIButton+TitleStyle.h"

@interface JgwTopTipVC ()
{
    UIView *m_viewContent;
    UIView *m_viewTopTip;
}
@property (nonatomic, retain, nullable)UIView *viewBottom;
@end

@implementation JgwTopTipVC

- (UIView *)contentView
{
    return m_viewContent;
}

- (void)setView:(UIView *)view
{
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *mainView = [[UIView alloc] initWithFrame:frame];
    [super setView:mainView];
    [mainView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mainView);
    }];
    m_viewContent = view;
}

- (void)showTopTipMsg:(NSString *)strMsg
{
    if (strMsg.length == 0)
    {
        return;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBCOLOR(254, 239, 184);
    view.userInteractionEnabled = NO;
    UIImage *image = [UIImage imageNamed:@"icon_warnning"];
    CGFloat fWidth = self.view.frame.size.width - image.size.width - 38;
    UIFont *font = [UIFont systemFontOfSize:13];
    CGFloat fTextWidth = getSizeForText(strMsg, font).width;
    if (fTextWidth > fWidth)
    {
        CGFloat fHeight = getSizeForLabelText(strMsg, font, CGSizeMake(fWidth, 100000)).height;
        view.frame = CGRectMake(0, 0, 0, fHeight + 16.0);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(15.0);
            make.centerY.equalTo(view);
            make.size.mas_equalTo(image.size);
        }];
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.font = font;
        label.text = strMsg;
        label.textColor = RGBCOLOR(50, 50, 50);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(8.0);
            make.top.bottom.equalTo(view);
            make.right.equalTo(view).offset(-15.0);
        }];
    }
    else
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:RGBCOLOR(50, 50, 50) forState:UIControlStateNormal];
        btn.titleLabel.font = font;
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:strMsg forState:UIControlStateNormal];
        [btn setTitleStyle:UIButtonTitleStyleRight indent:8];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        view.frame = CGRectMake(0, 0, 0, 20);
    }
    [self showTopTipView:view];
}

- (void)showTopTipView:(__kindof UIView *)customView
{
    CGFloat fHeight = customView.frame.size.height;
    if (fHeight == 0.0)
    {
        return;
    }
    [self.view addSubview:customView];
    if (m_viewTopTip.superview != nil)
    {
        [m_viewTopTip removeFromSuperview];
    }
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(fHeight);
    }];
    [m_viewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (self.viewBottom.superview)
        {
            make.bottom.equalTo(self.viewBottom.mas_top);
        }
        else
        {
            make.bottom.equalTo(self.view);
        }
        make.top.equalTo(customView.mas_bottom);
    }];
    m_viewTopTip = customView;
}

- (void)hiddenTopTip
{
    if (m_viewTopTip.superview != nil)
    {
        [m_viewTopTip removeFromSuperview];
        m_viewTopTip = nil;
        [m_viewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view);
        }];
    }
}

- (void)setupBottomView:(__kindof UIView *)bottomView height:(CGFloat)fHeight
{
    [self.viewBottom removeFromSuperview];
    self.viewBottom = bottomView;
    if (bottomView == nil)
    {
        [m_viewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo([super view]);
        }];
        return;
    }
    [super.view addSubview:bottomView];
    if (fHeight <= 0)
    {
        fHeight = bottomView.frame.size.height;
    }
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(super.view);
        make.height.mas_equalTo(fHeight);
    }];
    [m_viewContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo([super view]);
        make.bottom.equalTo(bottomView.mas_top);
    }];
}

#pragma mark - override

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)cancelFirstRespond
{
    [self.view endEditing:YES];
}
@end
