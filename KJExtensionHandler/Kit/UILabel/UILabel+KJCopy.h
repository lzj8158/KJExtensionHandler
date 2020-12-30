//
//  UILabel+KJCopy.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/18.
//  https://github.com/yangKJ/KJExtensionHandler
//  UILabel添加长按复制功能

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (KJCopy)
/// 是否可以拷贝
@property(nonatomic,assign)BOOL copyable;
/// 移除拷贝长按手势
- (void)kj_removeCopyLongPressGestureRecognizer;

@end

NS_ASSUME_NONNULL_END
