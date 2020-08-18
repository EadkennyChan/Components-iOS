//
//  UIButton+SuperCode.m
//  SCBaseUI
//
//  Created by Eadkenny on 2018/4/10.
//

#import "ZWVerticalScrollView.h"

@interface ZWVerticalScrollView ()<UIScrollViewDelegate>

@property (nonatomic, readonly, retain)UIView *viewContainer;

@end


@implementation ZWVerticalScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        UIView *viewContent = [[UIView alloc] init];
        [super addSubview:viewContent];
        _viewContainer = viewContent;
    }
    return self;
}

- (void)addSubview:(UIView *)view
{
    [_viewContainer addSubview:view];
}

- (UIView *)containerView
{
    return _viewContainer;
}

- (void)setLastBottomSubview:(UIView *)view
{
    [_viewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self);
        make.bottom.equalTo(view.mas_bottom);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_bAlwaysCanScroll && scrollView.contentSize.height <= scrollView.frame.size.height)
    {
        CGSize size = scrollView.contentSize;
        size.height = scrollView.frame.size.height + 0.5;
        scrollView.contentSize = size;
    }
    if (self.dragging)
    {
        [self endEditing:YES];
    }
}

@end
