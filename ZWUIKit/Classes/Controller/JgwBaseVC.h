//
//  JgwBaseVC.h
//  BaseUI
//
//  Created by Eadkenny on 2018/12/27.
//

#import "JgwTopTipVC.h"
#import "ZWMacroDef.h"
#import "NetworkDetection.h"
//#import "UITextField+Common.h"

NS_ASSUME_NONNULL_BEGIN

@interface JgwBaseVC<ViewType> : JgwTopTipVC<ViewType>

- (void)initSubviews;

//ViewDidAppear完成后调用的block
@property (nonatomic, copy, nonnull)BlockVoid blockAppearFinished;
// 完成后调用的block，不需要再block中popViewController
@property (nonatomic, copy, nullable)BlockObject blockComplete;


/**
 判断指定内容是否只包含中文或字母
 */
+ (BOOL)isChineseOrLetter:(NSString *)strText;

+ (BOOL)isDigitOrLetter:(NSString *)strText;

@end

NS_ASSUME_NONNULL_END
