//
//  UIImageView+KJBlur.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/14.
//  https://github.com/yangKJ/KJExtensionHandler
//  模糊处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJImageBlurType) {
    KJImageBlurTypeGaussian, // 高斯模糊，radius：0 - 100
    KJImageBlurTypevImage,// Accelerate模糊，radius：0 - 1
    KJImageBlurTypeBlurEffect,// 毛玻璃，radius：ExtraLight<10，Light<20，Dark>20
    KJImageBlurTypeMask, // 蒙版
};
@interface UIImageView (KJBlur)
/// 模糊处理
- (void)kj_blurImageViewWithBlurType:(KJImageBlurType)type BlurImage:(UIImage*)image BlurRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
