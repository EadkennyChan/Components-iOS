//
//  JgwTableView.m
//  AccountManager
//
//  Created by  eadkenny on 2019/6/19.
//

#import "JgwTableView.h"
#import "JgwHUD.h"

@implementation JgwTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.dragging)
    {
        [self endEditing:YES];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *view = [super hitTest:point withEvent:event];
  if (view) {
    [SVProgressHUD dismiss];
  }
  return view;
}

@end
