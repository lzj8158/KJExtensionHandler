//
//  UIButton+KJCreate.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  快捷链式创建UI

#import <UIKit/UIKit.h>
#import "_KJQuickCreateHandle.h"

NS_ASSUME_NONNULL_BEGIN

// UIView
@interface UIView (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createView:(void(^)(id<KJViewDelegate>delegate))handle;
UIView * kCreateViewDelegate(void(^handle)(id<KJViewDelegate>delegate));

@end

// UILabel
@interface UILabel (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createLabel:(void(^)(id<KJLabelDelegate>delegate))handle;
UILabel * kCreateLabelDelegate(void(^handle)(id<KJLabelDelegate>delegate));

@end

// UIImageView
@interface UIImageView (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createImageView:(void(^)(id<KJImageViewDelegate>delegate))handle;
UIImageView * kCreateImageViewDelegate(void(^handle)(id<KJImageViewDelegate>delegate));

@end

// UIButton
@interface UIButton (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createButton:(void(^)(id<KJButtonDelegate>delegate))handle;
UIButton * kCreateButtonDelegate(void(^handle)(id<KJButtonDelegate>delegate));

@end

NS_ASSUME_NONNULL_END
