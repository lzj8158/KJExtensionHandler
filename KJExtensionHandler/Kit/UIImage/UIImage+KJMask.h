//
//  UIImage+KJMask.h
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/25.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  蒙版处理，图片拼接

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJImageWaterType) {
    KJImageWaterTypeTopLeft = 0, /// 左上
    KJImageWaterTypeTopRight, /// 右上
    KJImageWaterTypeBottomLeft, /// 左下
    KJImageWaterTypeBottomRight, /// 右下
    KJImageWaterTypeCenter, /// 正中
};
@interface UIImage (KJMask)
/// 文字水印
- (UIImage*)kj_waterText:(NSString*)text direction:(KJImageWaterType)direction textColor:(UIColor*)color font:(UIFont*)font margin:(CGPoint)margin;
/// 图片水印
- (UIImage*)kj_waterImage:(UIImage*)image direction:(KJImageWaterType)direction waterSize:(CGSize)size margin:(CGPoint)margin;
/// 图片添加水印
- (UIImage*)kj_waterMark:(UIImage*)mark InRect:(CGRect)rect;
/// 蒙版图片处理
- (UIImage*)kj_maskImage:(UIImage*)maskImage;

#pragma mark - 其他
/// 椭圆形图片，图片长宽不等会出现切出椭圆
- (UIImage*)kj_ellipseImage;
/// 圆形图片
- (UIImage*)kj_circleImage;
/// 边框圆形图片
- (UIImage*)kj_squareCircleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;
/// 图片透明区域点击穿透处理
- (bool)kj_transparentWithPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
