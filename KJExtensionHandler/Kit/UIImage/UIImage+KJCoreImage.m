//
//  UIImage+KJCoreImage.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/7/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIImage+KJCoreImage.h"
#import "_KJGCD.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

@implementation UIImage (KJCoreImage)
- (EAGLContext*)eagContext{
    EAGLContext *context = objc_getAssociatedObject(self, _cmd);
    if (context == nil) {
        // 创建基于GPU的CIContext对象，处理速度更快，实时渲染
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        objc_setAssociatedObject(self, @selector(eagContext), context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return context;
}
- (CIContext*)ciContext{
    CIContext *context = objc_getAssociatedObject(self, _cmd);
    if (context == nil) {
        context = [CIContext contextWithEAGLContext:self.eagContext options:@{kCIContextWorkingColorSpace:[NSNull null]}];
        objc_setAssociatedObject(self, @selector(ciContext), context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return context;
}
/// Photoshop滤镜相关操作
- (UIImage*)kj_coreImagePhotoshopWithType:(KJCoreImagePhotoshopType)type Value:(CGFloat)value{
    CIImage *cimg = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:KJImageFilterTypeStringMap[type] keysAndValues:kCIInputImageKey,cimg,nil];
    [filter setValue:@(value) forKey:KJCoreImagePhotoshopTypeStringMap[type]];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [self.ciContext createCGImage:result fromRect:[cimg extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return newImage;
}
/// 通用方法 - 传入过滤器名称和需要的参数
- (UIImage*)kj_coreImageCustomWithName:(NSString*_Nonnull)name Dicts:(NSDictionary*_Nullable)dicts{
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:name keysAndValues:kCIInputImageKey,ciImage,nil];
    for (NSString *key in dicts.allKeys) {
        [filter setValue:dicts[key] forKey:key];
    }
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [self.ciContext createCGImage:result fromRect:[ciImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return newImage;
}
/// 调整图像的色调映射，同时保留空间细节（高光和阴影）
- (UIImage*)kj_coreImageHighlightShadowWithHighlightAmount:(CGFloat)HighlightAmount ShadowAmount:(CGFloat)ShadowAmount{
    NSDictionary *dict = @{@"inputHighlightAmount":@(HighlightAmount),
                           @"inputShadowAmount":@(ShadowAmount)};
    return [self kj_coreImageCustomWithName:@"CIHighlightShadowAdjust" Dicts:dict];
}
/// 将灰度图像转换为被alpha遮罩的白色图像，源图像中的白色值将生成蒙版的内部；黑色值变得完全透明
- (UIImage*)kj_coreImageBlackMaskToAlpha{
    return [self kj_coreImageCustomWithName:@"CIMaskToAlpha" Dicts:nil];
}
/// 马赛克
- (UIImage*)kj_coreImagePixellateWithCenter:(CGPoint)center Scale:(CGFloat)scale{
    CIVector *vector1 = [CIVector vectorWithX:center.x Y:center.y];
    NSDictionary *dict = @{@"inputCenter":vector1,
                           @"inputScale":@(scale)};
    return [self kj_coreImageCustomWithName:@"CIPixellate" Dicts:dict];
}
/// 图片圆形变形
- (UIImage*)kj_coreImageCircularWrapWithCenter:(CGPoint)center Radius:(CGFloat)radius Angle:(CGFloat)angle{
    CIVector *vector1 = [CIVector vectorWithX:center.x Y:center.y];
    NSDictionary *dict = @{@"inputCenter":vector1,
                           @"inputRadius":@(radius),
                           @"inputAngle":@(angle)};
    return [self kj_coreImageCustomWithName:@"CICircularWrap" Dicts:dict];
}
/// 环形透镜畸变
- (UIImage*)kj_coreImageTorusLensDistortionCenter:(CGPoint)center Radius:(CGFloat)radius Width:(CGFloat)width Refraction:(CGFloat)refraction{
    CIVector *vector1 = [CIVector vectorWithX:center.x Y:center.y];
    NSDictionary *dict = @{@"inputCenter":vector1,
                           @"inputRadius":@(radius),
                           @"inputWidth":@(width),
                           @"inputRefraction":@(refraction)};
    return [self kj_coreImageCustomWithName:@"CITorusLensDistortion" Dicts:dict];
}
/// 空变形
- (UIImage*)kj_coreImageHoleDistortionCenter:(CGPoint)center Radius:(CGFloat)radius{
    CIVector *vector1 = [CIVector vectorWithX:center.x Y:center.y];
    NSDictionary *dict = @{@"inputCenter":vector1,
                           @"inputRadius":@(radius)};
    return [self kj_coreImageCustomWithName:@"CIHoleDistortion" Dicts:dict];
}
/// 应用透视校正，将源图像中的任意四边形区域转换为矩形输出图像
- (UIImage*)kj_coreImagePerspectiveCorrectionWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft{
    return [self kj_PerspectiveTransformAndPerspectiveCorrection:@"CIPerspectiveCorrection" TopLeft:TopLeft TopRight:TopRight BottomRight:BottomRight BottomLeft:BottomLeft];
}
/// 透视变换，透视滤镜倾斜图像
- (UIImage*)kj_coreImagePerspectiveTransformWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft{
    return [self kj_PerspectiveTransformAndPerspectiveCorrection:@"CIPerspectiveTransform" TopLeft:TopLeft TopRight:TopRight BottomRight:BottomRight BottomLeft:BottomLeft];
}
/// 软装专属透视 - 内部有相对应的坐标转换
- (UIImage*)kj_softFitmentFluoroscopyWithTopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft{
    NSArray *temp = @[NSStringFromCGPoint(TopLeft),
                      NSStringFromCGPoint(TopRight),
                      NSStringFromCGPoint(BottomRight),
                      NSStringFromCGPoint(BottomLeft)];
    CGFloat minY = TopLeft.y,maxY = TopLeft.y;
    CGPoint pt = CGPointZero;
    for (NSString *string in temp) {
        pt = CGPointFromString(string);
        minY = pt.y < minY ? pt.y : minY;
        maxY = pt.y > maxY ? pt.y : maxY;
    }
    CGFloat H = maxY - minY;
    /// 水平方向上下镜像
    TopLeft.y     = -(TopLeft.y + H);
    BottomLeft.y  = -(BottomLeft.y + H);
    BottomRight.y = -(BottomRight.y + H);
    TopRight.y    = -(TopRight.y + H);
    return [self kj_PerspectiveTransformAndPerspectiveCorrection:@"CIPerspectiveTransform" TopLeft:TopLeft TopRight:TopRight BottomRight:BottomRight BottomLeft:BottomLeft];
}
/// 透视相关方法
- (UIImage*)kj_PerspectiveTransformAndPerspectiveCorrection:(NSString*)name TopLeft:(CGPoint)TopLeft TopRight:(CGPoint)TopRight BottomRight:(CGPoint)BottomRight BottomLeft:(CGPoint)BottomLeft{
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:name keysAndValues:kCIInputImageKey, ciImage, nil];
    CIVector *vector1 = [CIVector vectorWithX:TopLeft.x Y:TopLeft.y];
    CIVector *vector2 = [CIVector vectorWithX:TopRight.x Y:TopRight.y];
    CIVector *vector3 = [CIVector vectorWithX:BottomRight.x Y:BottomRight.y];
    CIVector *vector4 = [CIVector vectorWithX:BottomLeft.x Y:BottomLeft.y];
    [filter setValue:vector1 forKey:@"inputTopLeft"];
    [filter setValue:vector2 forKey:@"inputTopRight"];
    [filter setValue:vector3 forKey:@"inputBottomRight"];
    [filter setValue:vector4 forKey:@"inputBottomLeft"];
    /// 输出图片
    CIImage *outputImage = [filter outputImage];
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    return newImage;
}
- (UIImage*)kj_coreImageChangeImageSize:(CGSize)size{
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CGFloat scale = fminf(size.height/self.size.height, size.width/self.size.width);
    NSDictionary *dict = @{kCIInputScaleKey:@(scale),kCIInputAspectRatioKey:@(1.),kCIInputImageKey:ciImage};
    CIFilter *filter = [CIFilter filterWithName:@"CILanczosScaleTransform" withInputParameters:dict];
    CIContext *ciContext = [[CIContext alloc] initWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];
    CGImageRef imageRef = [ciContext createCGImage:filter.outputImage fromRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return newImage;
}

#pragma mark - 二维码/条形码生成器，特别备注文字不能是中文汉字
+ (CIImage*)kj_QRCodeImageWithContent:(NSString*)content{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:contentData forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    return filter.outputImage;
}
/// 生成二维码
+ (UIImage*)kj_QRCodeImageWithContent:(NSString*)content codeImageSize:(CGFloat)size{
    CIImage *image = [self kj_QRCodeImageWithContent:content];
    return [self kj_changeCIImage:image codeImageSize:size];
}
/// 生成指定颜色二维码
+ (UIImage*)kj_QRCodeImageWithContent:(NSString*)content codeImageSize:(CGFloat)size color:(UIColor*)color{
    UIImage *image = [self kj_QRCodeImageWithContent:content codeImageSize:size];
    return [image kj_changeImagePixelColor:color];
}

#pragma mark - 条形码
/// 将字符串转成条形码
+ (UIImage*)kj_barCodeImageWithContent:(NSString*)content{
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setDefaults];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    CGSize size = CGSizeMake(300, 90);
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    UIImage *image = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return image;
}
/// 生成条形码滤镜
+ (CIImage*)kj_barcodeCIImageWithContent:(NSString*)content{
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:contentData forKey:@"inputMessage"];
    [filter setValue:@(0.00) forKey:@"inputQuietSpace"];
    return filter.outputImage;
}
/// 生成条形码
+ (UIImage*)kj_barcodeImageWithContent:(NSString*)content codeImageSize:(CGFloat)size{
    CIImage *image = [self kj_barcodeCIImageWithContent:content];
    return [UIImage kj_changeCIImage:image codeImageSize:size];
}
/// 生成指定颜色条形码
+ (UIImage*)kj_barcodeImageWithContent:(NSString*)content codeImageSize:(CGFloat)size color:(UIColor*)color{
    UIImage *image = [self kj_barcodeImageWithContent:content codeImageSize:size];
    return [image kj_changeImagePixelColor:color];
}

#pragma mark - private
/// 改变图片尺寸
- (UIImage*)kj_bitmapChangeImageSize:(CGFloat)size{
    CIImage *image = [CIImage imageWithCGImage:self.CGImage];
    return [UIImage kj_changeCIImage:image codeImageSize:size];
}
+ (UIImage*)kj_changeCIImage:(CIImage*)image codeImageSize:(CGFloat)size{
    CGRect integralRect = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(integralRect), size/CGRectGetHeight(integralRect));
    size_t width = CGRectGetWidth(integralRect)*scale;
    size_t height = CGRectGetHeight(integralRect)*scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:integralRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, integralRect, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpaceRef);
    UIImage *__image = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return __image;
}
/// 改变图片内部像素颜色
- (UIImage*)kj_changeImagePixelColor:(UIColor*)color{
    CGFloat red=0, green=0, blue=0, a;
    [color getRed:&red green:&green blue:&blue alpha:&a];
    int imageWidth = self.size.width;
    int imageHeight = self.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, space, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t *ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255;
            ptr[2] = green*255;
            ptr[1] = blue*255;
        }else{
            uint8_t *ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, kProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, space, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(space);
    return resultImage;
}
/// 释放
static void kProviderReleaseData(void *info, const void * data, size_t size){
    free((void*)data);
}

/// 生成二维码
void kQRCodeImage(void(^codeImage)(UIImage * image), NSString *content, CGFloat size){
    if (codeImage) {
        kGCD_async(^{
            CIImage *image = [UIImage kj_QRCodeImageWithContent:content];
            UIImage *newImage = [UIImage kj_changeCIImage:image codeImageSize:size];
            kGCD_main(^{
                codeImage(newImage);
            });
        });
    }
}
/// 生成指定颜色二维码
void kQRCodeImageFromColor(void(^codeImage)(UIImage * image), NSString *content, CGFloat size, UIColor *color){
    kQRCodeImage(^(UIImage *image) {
        if (codeImage) {
            kGCD_async(^{
                UIImage *newImage = [image kj_changeImagePixelColor:color];
                kGCD_main(^{
                    codeImage(newImage);
                });
            });
        }
    }, content, size);
}

@end
#pragma clang diagnostic pop
