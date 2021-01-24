//
//  UILabel+KJCreate.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  快速创建文本

#import <UIKit/UIKit.h>
#import "_KJQuickCreateHandle.h"
NS_ASSUME_NONNULL_BEGIN

@interface UILabel (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createLabel:(void(^)(id<KJQuickCreateHandle>handle))handle;

@end

NS_ASSUME_NONNULL_END
