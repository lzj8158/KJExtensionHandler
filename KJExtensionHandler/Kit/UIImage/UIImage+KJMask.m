//
//  UIImage+KJMask.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/25.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIImage+KJMask.h"

@implementation UIImage (KJMask)
/// 文字水印
- (UIImage*)kj_waterText:(NSString*)text direction:(KJImageWaterType)direction textColor:(UIColor*)color font:(UIFont*)font margin:(CGPoint)margin{
    CGRect rect = (CGRect){CGPointZero,self.size};
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [self drawInRect:rect];
    NSDictionary *dict = @{NSFontAttributeName:font,NSForegroundColorAttributeName:color};
    CGRect calRect = [self kj_rectWithRect:rect size:[text sizeWithAttributes:dict] direction:direction margin:margin];
    [text drawInRect:calRect withAttributes:dict];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/// 图片水印
- (UIImage*)kj_waterImage:(UIImage*)image direction:(KJImageWaterType)direction waterSize:(CGSize)size margin:(CGPoint)margin{
    CGRect rect = (CGRect){CGPointZero,self.size};
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [self drawInRect:rect];
    CGSize waterImageSize = CGSizeEqualToSize(size, CGSizeZero) ? image.size : size;
    CGRect waterRect = [self kj_rectWithRect:rect size:waterImageSize direction:direction margin:margin];
    [image drawInRect:waterRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (CGRect)kj_rectWithRect:(CGRect)rect size:(CGSize)size direction:(KJImageWaterType)direction margin:(CGPoint)margin{
    CGPoint point = CGPointZero;
    switch (direction) {
        case KJImageWaterTypeTopLeft:
            break;
        case KJImageWaterTypeTopRight:
            point = CGPointMake(rect.size.width - size.width, 0);
            break;
        case KJImageWaterTypeBottomRight:
            point = CGPointMake(rect.size.width - size.width, rect.size.height - size.height);
            break;
        case KJImageWaterTypeCenter:
            point = CGPointMake((rect.size.width - size.width)*.5f, (rect.size.height - size.height)*.5f);
            break;
        default:
            break;
    }
    point.x += margin.x;
    point.y += margin.y;
    return (CGRect){point,size};
}

// 画水印
- (UIImage*)kj_waterMark:(UIImage*)mark InRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGRect imgRect = CGRectMake(0, 0, self.size.width, self.size.height);
    [self drawInRect:imgRect];
    [mark drawInRect:rect];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}
/// 蒙版图片处理
- (UIImage*)kj_maskImage:(UIImage*)maskImage{
    UIImage *image = self;
    CGImageRef maskRef = maskImage.CGImage;
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    CGImageRef sourceImage = [image CGImage];
    CGImageRef imageWithAlpha = sourceImage;
    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone) {
//        imageWithAlpha = CopyImageAndAddAlphaChannel(sourceImage);
    }
    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);
    CGImageRelease(mask);
    if (sourceImage != imageWithAlpha) CGImageRelease(imageWithAlpha);
    UIImage * retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    return retImage;
}
/// 椭圆形图片
- (UIImage *)kj_ellipseImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/// 圆形图片
- (UIImage*)kj_circleImage{
    CGFloat width = MIN(self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, width), NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, width, width));
    CGContextClip(ctx);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/// 边框圆形图片
- (UIImage*)kj_squareCircleImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor{
    CGFloat width = self.size.width + 2 * borderWidth;
    CGFloat height = width;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [borderColor set];
    CGFloat bigRadius = width * 0.5;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(context, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(context, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(context);
    [self drawInRect:CGRectMake(borderWidth, borderWidth, width, height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/// 透明图片穿透
- (bool)kj_transparentWithPoint:(CGPoint)point{
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel,1,1,8,1,NULL,kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [self drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0f;
    return alpha < 0.01f;
}
/// 渐变色图片，0：从上到下，1：从左到右，2：从左上到右下，3：从右上到左下
+ (UIImage*(^)(CGSize,int))kj_gradientImageColor:(UIColor*)color,...{
    __block NSMutableArray * temps = [NSMutableArray arrayWithObjects:(id)color.CGColor,nil];
    va_list args;UIColor * arg;
    va_start(args, color);
    while ((arg = va_arg(args, UIColor *))) {
        [temps addObject:(id)arg.CGColor];
    }
    va_end(args);
    return ^UIImage * (CGSize size, int index){
        UIGraphicsBeginImageContextWithOptions(size, YES, 1);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGColorSpaceRef colorSpace = CGColorGetColorSpace([[temps lastObject] CGColor]);
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)temps, NULL);
        CGPoint start = CGPointZero,end = CGPointZero;
        switch (index) {
            case 0:
                start = CGPointMake(0.0, 0.0);
                end = CGPointMake(0.0, size.height);
                break;
            case 1:
                start = CGPointMake(0.0, 0.0);
                end = CGPointMake(size.width, 0.0);
                break;
            case 2:
                start = CGPointMake(0.0, 0.0);
                end = CGPointMake(size.width, size.height);
                break;
            case 3:
                start = CGPointMake(size.width, 0.0);
                end = CGPointMake(0.0, size.height);
                break;
            default:
                break;
        }
        CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        CGGradientRelease(gradient);
        CGContextRestoreGState(context);
        CGColorSpaceRelease(colorSpace);
        UIGraphicsEndImageContext();
        return image;
    };
}

@end
