//
//  JgwButton.m
//  AccountManager
//
//  Created by  eadkenny on 2020/4/7.
//

#import "JgwButton.h"

@implementation JgwButton
/*
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
  CGSize sizeBtn = self.frame.size;
  CGRect rect = [super titleRectForContentRect:contentRect];
  CGRect rectIcon;
  switch (self.contentAligement) {
    case JgwContentAligementRight:
    {
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          break;
        case JgwButtonTitleStyleAbove:
          break;
        case JgwButtonTitleStyleLeft:
          rect.origin.y = (sizeBtn.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom - rect.size.height) / 2.0;
          break;
        default:
          rect.origin.x = (sizeBtn.width - rect.size.width - self.contentEdgeInsets.left - self.contentEdgeInsets.right);
          rect.origin.y = (sizeBtn.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom - rect.size.height) / 2.0;
          break;
      }
    }
    break;
    case JgwContentAligementLeft:
    {
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          break;
        case JgwButtonTitleStyleAbove:
          break;
        case JgwButtonTitleStyleLeft:
          rect.origin.x = self.contentEdgeInsets.left;
          rect.origin.y = (sizeBtn.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom - rect.size.height) / 2.0;
          break;
        default:
          rect.origin.y = (sizeBtn.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom - rect.size.height) / 2.0;
          rect.origin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left + self.imageEdgeInsets.right + self.imageView.image.size.width + self.titleEdgeInsets.left;
          break;
      }
    }
    break;
    default:
    {
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          
          break;
        case JgwButtonTitleStyleAbove:
          
          break;
        case JgwButtonTitleStyleLeft:
          
          break;
        default:
          break;
      }
    }
    break;
  }
  return rect;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
  CGSize sizeBtn = self.frame.size;
  CGRect rect = [super imageRectForContentRect:contentRect];
  switch (self.contentAligement) {
    case JgwContentAligementRight:
    {/*
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          break;
        case JgwButtonTitleStyleAbove:
          break;
        case JgwButtonTitleStyleLeft:
          rect.origin.y = (sizeBtn.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom - rect.size.height) / 2.0;
          break;
        default:
          rect.origin.x = (sizeBtn.width - rect.size.width - self.contentEdgeInsets.left - self.contentEdgeInsets.right);
          rect.origin.y = (sizeBtn.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom - rect.size.height) / 2.0;
          break;
      }*//*
    }
    break;
    case JgwContentAligementLeft:
    {
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          break;
        case JgwButtonTitleStyleAbove:
          break;
        case JgwButtonTitleStyleLeft:
//          rect.origin.x = self.contentEdgeInsets.left;
//          rect.origin.y = (sizeBtn.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom - rect.size.height) / 2.0;
          break;
        default:
          rect.origin.y = (sizeBtn.height - self.contentEdgeInsets.top - self.contentEdgeInsets.bottom - rect.size.height) / 2.0;
          rect.origin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left;
          break;
      }
    }
    break;
    default:
    {
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          
          break;
        case JgwButtonTitleStyleAbove:
          
          break;
        case JgwButtonTitleStyleLeft:
          
          break;
        default:
          break;
      }
    }
    break;
  }
  return rect;
}

- (CGRect)contentRectForBounds:(CGRect)bounds {
  CGRect rect = [super contentRectForBounds:bounds];
  return rect;
}*/

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect rect;
  switch (self.contentAligement) {
    case JgwContentAligementRight: {
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          break;
        case JgwButtonTitleStyleAbove:
          break;
        case JgwButtonTitleStyleLeft:
          rect = self.imageView.frame;
          rect.origin.x = self.frame.size.width - self.contentEdgeInsets.right - rect.size.width - self.imageEdgeInsets.right;
          self.imageView.frame = rect;
          rect = self.titleLabel.frame;
          rect.origin.x = self.imageView.frame.origin.x - self.titleEdgeInsets.right - self.imageEdgeInsets.left - rect.size.width;
          self.titleLabel.frame = rect;
          break;
        default:
          rect = self.titleLabel.frame;
          rect.origin.x = self.frame.size.width - self.contentEdgeInsets.right - rect.size.width - self.titleEdgeInsets.right;
          self.titleLabel.frame = rect;
          rect = self.imageView.frame;
          rect.origin.x = self.titleLabel.frame.origin.x - self.titleEdgeInsets.left - self.imageEdgeInsets.right - rect.size.width;
          self.imageView.frame = rect;
          break;
      }
    }
    break;
    case JgwContentAligementLeft: {
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          break;
        case JgwButtonTitleStyleAbove:
          break;
        case JgwButtonTitleStyleLeft:
          rect = self.titleLabel.frame;
          rect.origin.x = self.contentEdgeInsets.left + self.titleEdgeInsets.left;
          self.titleLabel.frame = rect;
          rect = self.imageView.frame;
          rect.origin.x = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + self.imageEdgeInsets.left + self.titleEdgeInsets.right;
          self.imageView.frame = rect;
          break;
        default:
          rect = self.imageView.frame;
          rect.origin.x = self.contentEdgeInsets.left + self.imageEdgeInsets.left;
          self.imageView.frame = rect;
          rect = self.titleLabel.frame;
          rect.origin.x = self.imageView.frame.origin.x + self.imageView.frame.size.width + self.imageEdgeInsets.right + self.titleEdgeInsets.left;
          self.titleLabel.frame = rect;
          break;
      }
    }
    break;
    default: {
      switch (self.titleStyle) {
        case JgwButtonTitleStyleUnder:
          
          break;
        case JgwButtonTitleStyleAbove:
          
          break;
        case JgwButtonTitleStyleLeft:
          
          break;
        default:
          break;
      }
    }
    break;
  }
}

@end
