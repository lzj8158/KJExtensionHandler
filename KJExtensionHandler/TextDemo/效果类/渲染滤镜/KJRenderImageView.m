//
//  KJRenderImageView.m
//  KJDecorationView
//
//  Created by 杨科军 on 2020/7/26.
//  Copyright © 2020 杨科军. All rights reserved.
//

#import "KJRenderImageView.h"

@interface KJRenderImageView ()
@property(nonatomic,strong)UIImage *originImage;
@property(nonatomic,strong)EAGLContext *eagContext;
@property(nonatomic,strong)CIContext *ciContext;
@end
@implementation KJRenderImageView
/// 初始化
- (instancetype)kj_initWithOriImage:(UIImage*)image ExtendParameterBlock:(void(^_Nullable)(KJRenderImageView *obj))paramblock{
    if (self==[super init]) {
        self.userInteractionEnabled = NO;
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.];
        self.originImage = image;
        if (paramblock) paramblock(self);
    }
    return self;
}
/// 修改效果
- (void)kj_changeRenderInfo:(KJRenderInfo*)info{
    self.alpha = info.opacity;
    if (info.type == KJRenderFilterTypeOriginal) {
        self.image = self.originImage;
    }else if (info.type == KJRenderFilterTypeColor) {
        self.image = [self kj_colorRenderInfo:info];
    }else if (info.type == KJRenderFilterTypeSketch) {
        [self kj_sketchRenderInfo:info];
    }else if (info.type == KJRenderFilterTypeCoreImage) {
        [self kj_coreImageRenderInfo:info];
    }
}
#pragma mark - privately method
/// 颜色滤镜
- (UIImage*)kj_colorRenderInfo:(KJRenderInfo*)info{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.originImage drawInRect:self.bounds];
    CGContextSetFillColorWithColor(context, [info.color colorWithAlphaComponent:info.extend].CGColor);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextFillRect(context, self.bounds);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    return newImage;
}
/// 素描滤镜
- (void)kj_sketchRenderInfo:(KJRenderInfo*)info{
    _weakself;
    kGCD_QUEUE_ASYNC(^{
        /// 去色
        CIImage * inputImage = [[CIImage alloc] initWithImage:weakself.originImage];
        CIFilter * monoFilter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
        [monoFilter setValue:inputImage forKey:kCIInputImageKey];
        CIImage * outImage = [monoFilter outputImage];
        /// 拷贝反色
        CIImage * invertImage = [outImage copy];
        CIFilter * invertFilter = [CIFilter filterWithName:@"CIColorInvert"];
        [invertFilter setValue:invertImage forKey:kCIInputImageKey];
        invertImage = [invertFilter outputImage];
        /// 高斯模糊
        CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [blurFilter setDefaults];
        [blurFilter setValue:@(info.extend*100) forKey:kCIInputRadiusKey];
        [blurFilter setValue:invertImage forKey:kCIInputImageKey];
        invertImage = [blurFilter valueForKey:kCIOutputImageKey];
        /// 混合叠加到去色图片
        CIFilter * blendFilter = [CIFilter filterWithName:@"CIColorDodgeBlendMode"];
        [blendFilter setValue:invertImage forKey:kCIInputImageKey];
        [blendFilter setValue:outImage forKey:kCIInputBackgroundImageKey];
        CIImage * sketchImage = [blendFilter outputImage];
        /// 渲染图片
        CGImageRef cgImage = [weakself.ciContext createCGImage:sketchImage fromRect:[inputImage extent]];
        kGCD_MAIN_ASYNC(^{
            weakself.image = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
        });
    });
}
/// coreImage 滤镜
- (void)kj_coreImageRenderInfo:(KJRenderInfo*)info{
    _weakself;
    dispatch_queue_t globel = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globel, ^{
        CIFilter *filter = [CIFilter filterWithName:KJRenderCoreImageFilterTypeStringMap[info.coreType]];
        [filter setDefaults];
        [filter setValue:[[CIImage alloc] initWithImage:weakself.originImage] forKey:kCIInputImageKey];
        NSString *string = KJRenderCoreImageFilterTypeKeyStringMap[info.coreType];
        if (![string isEqualToString:@""]) [filter setValue:@(info.extend) forKey:string];
        CIImage *outputImage  = [filter outputImage];
        CGImageRef filterimge = [weakself.ciContext createCGImage:outputImage fromRect:outputImage.extent];
        dispatch_queue_t main = dispatch_get_main_queue();
        dispatch_async(main, ^{
            weakself.image = [UIImage imageWithCGImage:filterimge];
            CGImageRelease(filterimge);
        });
    });
}
#pragma mark - lazy
- (EAGLContext*)eagContext{
    if (!_eagContext) {
        _eagContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    return _eagContext;
}
- (CIContext*)ciContext{
    if (!_ciContext) {
        _ciContext = [CIContext contextWithEAGLContext:self.eagContext options:@{kCIContextWorkingColorSpace:[NSNull null]}];
    }
    return _ciContext;
}
#pragma mark - ExtendParameterBlock 扩展参数
- (KJRenderImageView *(^)(UIView*))kAddView {
    return ^(UIView *view){
        [view addSubview:self];
        return self;
    };
}
- (KJRenderImageView *(^)(CGRect))kFrame {
    return ^(CGRect rect){
        self.frame = rect;
        return self;
    };
}
@end
@implementation KJRenderInfo
- (instancetype)init{
    self = [super init];
    if (self) {
        self.opacity = 1.;
    }
    return self;
}
@end
