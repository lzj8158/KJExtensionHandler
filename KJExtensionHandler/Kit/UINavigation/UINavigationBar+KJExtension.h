//
//  UINavigationBar+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  导航栏管理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (KJExtension)
/// 隐藏导航条底部下划线
- (UINavigationBar *)kj_hiddenNavigationBarBottomLine;
/// 设置导航栏背景色
- (UINavigationBar * (^)(UIColor *))kj_changeNavigationBarBackgroundColor;
/// 设置图片背景导航栏
- (UINavigationBar * (^)(UIImage *))kj_changeNavigationBarImage;
/// 设置导航条标题颜色和字号
- (UINavigationBar * (^)(UIColor *, UIFont *))kj_changeNavigationBarTitle;
/// 默认恢复成系统的颜色和下划线
- (void)kj_resetNavigationBarSystem;
/// 设置自定义的返回按钮
- (void)kj_changeNavigationBarBackImage:(NSString*)imageName;

@end

NS_ASSUME_NONNULL_END
