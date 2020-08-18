//
//  JgwButton.h
//  AccountManager
//
//  Created by  eadkenny on 2020/4/7.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JgwButtonTitleStyle)
{
    JgwButtonTitleStyleDefault = 0, //图片在左边，标题在右边
    JgwButtonTitleStyleUnder,    //标题在下边，图片在上边
    JgwButtonTitleStyleAbove,    //标题在上边，图片在下边
    JgwButtonTitleStyleLeft     //标题在左边，图片在右边
};

typedef NS_ENUM(NSInteger, JgwContentAligement)
{
    JgwContentAligementDefault = 0, //内容居中
    JgwContentAligementLeft,    //内容靠左
    JgwContentAligementRight    //内容靠右
};

NS_ASSUME_NONNULL_BEGIN

@interface JgwButton : UIButton
@property (nonatomic, assign)JgwButtonTitleStyle titleStyle;
@property (nonatomic, assign)JgwContentAligement contentAligement;

@end

NS_ASSUME_NONNULL_END
