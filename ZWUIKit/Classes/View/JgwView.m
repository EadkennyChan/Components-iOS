//
//  JgwView.m
//  BaseRepo
//
//  Created by  eadkenny on 2020/4/2.
//

#import "JgwView.h"
#import "JgwHUD.h"

@implementation JgwView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *view = [super hitTest:point withEvent:event];
  if (view) {
    [SVProgressHUD dismiss];
  }
  return view;
}

@end
