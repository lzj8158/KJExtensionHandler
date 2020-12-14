//
//  UIImageView+KJBlur.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/14.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIImageView+KJBlur.h"
#import "UIImage+KJMask.h"
#import "UIImage+KJAccelerate.h"
#import "_KJGCD.h"

@implementation UIImageView (KJBlur)
/// 模糊处理
- (void)kj_blurImageViewWithBlurType:(KJImageBlurType)type BlurImage:(UIImage*)image BlurRadius:(CGFloat)radius{
    __weak __typeof(&*self) weakself = self;
    if (type == KJImageBlurTypeGaussian) {
        kGCD_async(^{
            CIContext *context = [CIContext contextWithOptions:nil];
            CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
            CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp" keysAndValues:kCIInputImageKey,ciimage,nil];
            CIImage *clampResult = [clampFilter valueForKey:kCIOutputImageKey];
            
            CIFilter *gaussianFilter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey,clampResult,nil];
            [gaussianFilter setValue:@(radius) forKey:kCIInputRadiusKey];
            CIImage *gaussianResult = [gaussianFilter valueForKey:kCIOutputImageKey];
            
            CGImageRef cgImage = [context createCGImage:gaussianResult fromRect:[ciimage extent]];
            UIImage *newImage = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            kGCD_main(^{
                weakself.image = newImage;
            });
        });
    }else if (type == KJImageBlurTypeMask) {
        self.image = [self.image kj_maskImage:image];
    }else if (type == KJImageBlurTypeBlurEffect) {
        self.image = image;
        UIBlurEffect *effect;
        if (radius<10) {
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        }else if (radius<20) {
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        }else{
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        }
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
    }else if (type == KJImageBlurTypevImage) {
        self.image = [image kj_linearBlurryImageBlur:radius];
    }
}

@end
