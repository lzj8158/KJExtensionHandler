//
//  UIColor+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  颜色相关扩展

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,KJGradietColorType) {
    KJGradietColorTypeTopToBottom = 0, /// 从上到下
    KJGradietColorTypeLeftToRight = 1, /// 从左到右
    KJGradietColorTypeUpLeftToLowRight = 2, /// 从左上到右下
    KJGradietColorTypeUpRightToLowLeft = 3, /// 从右上到左下
};
typedef struct KJColorRGBA {float red; float green; float blue; float alpha;}KJColorRGBA;
/// 色相饱和度和亮度
typedef struct KJColorHSL {float hue; float saturation; float light;}KJColorHSL;
@interface UIColor (KJExtension)
@property(nonatomic,assign,readonly)CGFloat red;
@property(nonatomic,assign,readonly)CGFloat green;
@property(nonatomic,assign,readonly)CGFloat blue;
@property(nonatomic,assign,readonly)CGFloat alpha;
@property(nonatomic,assign,readonly)CGFloat hue;/// 色相 -π ~ π
@property(nonatomic,assign,readonly)CGFloat saturation;/// 饱和度 0 ~ 1
@property(nonatomic,assign,readonly)CGFloat light;/// 亮度 0 ~ 1
/// 随机颜色
UIColor * kRandomColor(void);
/// 获取颜色对应的RGBA
- (KJColorRGBA)kj_colorGetRGBA;
/// 获取颜色对应的色相饱和度和透明度
- (KJColorHSL)kj_colorGetHSL;
/// 获取颜色的均值
+ (UIColor*)kj_averageColors:(NSArray<UIColor*>*)colors;
/// 图片生成颜色
+ (UIColor*(^)(UIImage*))kj_imageColor;
/// 可变参数方式渐变色
- (UIColor*(^)(CGSize))kj_gradientColor:(UIColor*)color,...;
/// 兼容Swift版本，可变参数渐变色
- (UIColor*)kj_gradientSize:(CGSize)size color:(UIColor*)color,...;
/// 渐变颜色
+ (UIColor*)kj_gradientColorWithColors:(NSArray*)colors
                          GradientType:(KJGradietColorType)type
                                  Size:(CGSize)size;
/// 竖直渐变颜色
- (UIColor*)kj_gradientVerticalToColor:(UIColor*)color
                                Height:(NSInteger)height;
/// 横向渐变颜色
- (UIColor*)kj_gradientAcrossToColor:(UIColor*)color
                               Width:(NSInteger)width;
/// 生成附带边框的渐变色图片
+ (UIImage*)kj_colorImageWithColors:(NSArray<UIColor*>*)colors
                          locations:(NSArray<NSNumber*>*)locations
                               size:(CGSize)size
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor*)borderColor;

/// UIColor转16进制字符串
+ (NSString*)kj_hexStringFromColor:(UIColor*)color;
NSString *kHexStringFromColor(UIColor *color);
/// 16进制字符串转UIColor
+ (UIColor*)kj_colorWithHexString:(NSString*)hexString;
UIColor * kColorHexString(NSString *hexString);

/// 获取图片上指定点的颜色
+ (UIColor*)kj_colorAtImage:(UIImage*)image Point:(CGPoint)point;
/// 获取ImageView上指定点的图片颜色
+ (UIColor*)kj_colorAtImageView:(UIImageView*)imageView Point:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
