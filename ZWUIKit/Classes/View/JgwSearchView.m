//
//  ZWLabelTextViewCell.m
//  SCBase
//
//  Created by Eadkenny on 2018/1/19.
//

#import "JgwSearchView.h"
#import "Masonry.h"
#import "UIView+AddLine.h"
#import "UtilityUIKit.h"
//#import "UIColor+SuperCode.h"
#import "ZWTextField.h"

@interface JgwSearchView ()
{
    UITextField *m_textField;
    UIView *m_viewLine;
}
@end

@implementation JgwSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        NSString *strText = @"取消";
        [btn setTitle:strText forState:UIControlStateNormal];
        CGFloat fWidth = getSizeForText(strText, btn.titleLabel.font).width + 30.0;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.width.mas_equalTo(fWidth);
            make.top.bottom.equalTo(self);
        }];
        [btn addTarget:self action:@selector(btnClickedCancel) forControlEvents:UIControlEventTouchUpInside];
        
        ZWTextField *textField = [[ZWTextField alloc] init];
        textField.returnKeyType = UIReturnKeySearch;
        textField.layer.cornerRadius = 4.0;
        textField.font = [UIFont systemFontOfSize:13];
        [self addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15.0);
            make.right.equalTo(btn.mas_left);
            make.top.equalTo(self).offset(7.5);
            make.bottom.equalTo(self).offset(-7.5);
        }];
        m_textField = textField;
        
        UIImage *image = [UIImage imageNamed:@"magnifier_gray_13"];
        frame = CGRectMake(0, 0, image.size.width + 20, image.size.height);
        UIView *view = [[UIView alloc] initWithFrame:frame];
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            imageView.userInteractionEnabled = NO;
            [view addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(view);
                make.size.mas_equalTo(image.size);
            }];
        }
        textField.leftView = view;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    }
    return self;
}

- (void)showBottomLine:(BOOL)bShow
{
    if (bShow)
    {
        if (m_viewLine.superview == nil)
        {
            WeakObject(self);
            m_viewLine = [self addHorizontalLineWithColor:nil constraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(weakObject);
            }];
        }
    }
    else
    {
        [m_viewLine removeFromSuperview];
        m_viewLine = nil;
    }
}

- (void)setStrKeyword:(NSString *)strKeyword
{
    m_textField.text = strKeyword;
}
- (NSString *)strKeyword
{
    return m_textField.text;
}
- (void)setStrPlaceholder:(NSString *)strPlaceholder
{
  NSMutableAttributedString *mtAttrStr = [[NSMutableAttributedString alloc] initWithString:strPlaceholder];
  NSRange range = NSMakeRange(0, strPlaceholder.length);
  if (self.placeholderColor) {
    [mtAttrStr addAttribute:NSForegroundColorAttributeName value:self.placeholderColor range:range];
  }
  [mtAttrStr addAttribute:NSFontAttributeName value:m_textField.font range:range];
  m_textField.attributedPlaceholder = mtAttrStr;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    m_textField.delegate = delegate;
}
- (id<UITextFieldDelegate>)delegate
{
    return m_textField.delegate;
}

- (BOOL)becomeFirstResponder
{
    return [m_textField becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [m_textField resignFirstResponder];
}

- (void)removeFromSuperview
{
    [m_textField resignFirstResponder];
    [super removeFromSuperview];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidChange:(NSNotification *)notificaton
{
    UITextField *textField = [notificaton object];
    if (self.blockTextChanged)
    {
        self.blockTextChanged(textField.text);
    }
}

#pragma mark - btn clicked

- (void)btnClickedCancel
{
    [m_textField resignFirstResponder];
    if (self.blockCancel)
    {
        self.blockCancel();
    }
}

#pragma mark - method

+ (JgwSearchView *)navSearchView:(CGRect)frame placeholder:(NSString *)strPlaceholder
{
    JgwSearchView *view = [[JgwSearchView alloc] initWithFrame:frame];
    view.strPlaceholder = strPlaceholder;
    return view;
}

@end


@implementation UIControl (JgwPlaceHolderSearchView)

+ (UIControl *)placeholderSearchView:(NSString *)strText
{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    UIControl *viewRoot = [[UIControl alloc] initWithFrame:frame];
    
    UIView *viewBackground = [[UIView alloc] init];
    viewBackground.userInteractionEnabled = NO;
    viewBackground.backgroundColor = [UIColor whiteColor];
    viewBackground.layer.cornerRadius = 4.0;
    [viewRoot addSubview:viewBackground];
    [viewBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewRoot).offset(15.0);
        make.right.equalTo(viewRoot).offset(-15.0);
        make.top.equalTo(viewRoot).offset(7.5);
        make.bottom.equalTo(viewRoot).offset(-7.5);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = strText;
    label.font = [UIFont systemFontOfSize:13];
    label.userInteractionEnabled = NO;
    [viewRoot addSubview:label];
    CGFloat fWidth = getSizeForText(strText, label.font).width;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.equalTo(viewRoot);
        make.width.mas_equalTo(fWidth);
    }];
    
    UIImage *image = [UIImage imageNamed:@"magnifier_gray_13"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.userInteractionEnabled = NO;
    [viewRoot addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label.mas_left).offset(-10.0);
        make.centerY.equalTo(viewRoot);
        make.size.mas_equalTo(image.size);
    }];
    
    return viewRoot;
}

+ (UIControl *)placeholderArchSearchView:(NSString *)strText
{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    UIControl *viewRoot = [[UIControl alloc] initWithFrame:frame];
    
    UIView *viewBackground = [[UIView alloc] init];
    viewBackground.userInteractionEnabled = NO;
    viewBackground.backgroundColor = [UIColor whiteColor];
    viewBackground.layer.cornerRadius = 14.5;
    [viewRoot addSubview:viewBackground];
    [viewBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewRoot).offset(15.0);
        make.right.equalTo(viewRoot).offset(-15.0);
        make.top.equalTo(viewRoot).offset(7.5);
        make.bottom.equalTo(viewRoot).offset(-7.5);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = strText;
    label.font = [UIFont systemFontOfSize:13];
    label.userInteractionEnabled = NO;
    [viewRoot addSubview:label];
    CGFloat fWidth = getSizeForText(strText, label.font).width;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.equalTo(viewRoot);
        make.width.mas_equalTo(fWidth);
    }];
    
    UIImage *image = [UIImage imageNamed:@"magnifier_gray_13"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.userInteractionEnabled = NO;
    [viewRoot addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(label.mas_left).offset(-10.0);
        make.centerY.equalTo(viewRoot);
        make.size.mas_equalTo(image.size);
    }];
    
    return viewRoot;
}

//+ (UITextField *)

@end
