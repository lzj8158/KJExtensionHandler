//
//  UIImage+KJQRCode.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/18.
//  https://github.com/yangKJ/KJExtensionHandler
//  二维码/条形码生成器，特别备注文字不能是中文汉字

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJQRCode)
/// 将字符串转成条形码
+ (UIImage*)kj_barCodeImageWithContent:(NSString*)content;

/// 生成二维码
+ (UIImage*)kj_QRCodeImageWithContent:(NSString*)content codeImageSize:(CGFloat)size;
/// 生成指定颜色二维码
+ (UIImage*)kj_QRCodeImageWithContent:(NSString*)content codeImageSize:(CGFloat)size color:(UIColor*)color;

/// 生成条形码
+ (UIImage*)kj_barcodeImageWithContent:(NSString*)content codeImageSize:(CGFloat)size;
/// 生成指定颜色条形码
+ (UIImage*)kj_barcodeImageWithContent:(NSString*)content codeImageSize:(CGFloat)size color:(UIColor*)color;

/// 改变图片尺寸，bitmap方式
- (UIImage*)kj_bitmapChangeImageSize:(CGFloat)size;
/// 改变图片内部像素颜色
- (UIImage*)kj_changeImagePixelColor:(UIColor*)color;

/// 生成二维码
void kQRCodeImage(void(^codeImage)(UIImage * image), NSString *content, CGFloat size);
/// 生成指定颜色二维码
void kQRCodeImageFromColor(void(^codeImage)(UIImage * image), NSString *content, CGFloat size, UIColor *color);

@end

NS_ASSUME_NONNULL_END
