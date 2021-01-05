//
//  KJRenderImageView.h
//  KJDecorationView
//
//  Created by 杨科军 on 2020/7/26.
//  Copyright © 2020 杨科军. All rights reserved.
//  渲染滤镜

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSInteger, KJRenderFilterType) {
    KJRenderFilterTypeOriginal = 0,/// 原片
    KJRenderFilterTypeColor,/// 颜色滤镜
    KJRenderFilterTypeSketch, /// 素描滤镜
    KJRenderFilterTypeCoreImage,/// CoreImage 自带滤镜
};
/// CoreImage 滤镜
typedef NS_OPTIONS(NSInteger, KJRenderCoreImageFilterType) {
    KJRenderCoreImageFilterTypeSepia = 0,/// 褐色滤镜（怀旧）
    KJRenderCoreImageFilterTypeColorInvert,/// 颜色反转
};
static NSString * const _Nonnull KJRenderCoreImageFilterTypeStringMap[] = {
    [KJRenderCoreImageFilterTypeSepia] = @"CISepiaTone",
    [KJRenderCoreImageFilterTypeColorInvert] = @"CIColorInvert",
};
static NSString * const _Nonnull KJRenderCoreImageFilterTypeKeyStringMap[] = {
    [KJRenderCoreImageFilterTypeSepia] = @"inputIntensity",
    [KJRenderCoreImageFilterTypeColorInvert] = @"",
};
@class KJRenderInfo;
@interface KJRenderImageView : UIImageView
/// 初始化
- (instancetype)kj_initWithOriImage:(UIImage*)image ExtendParameterBlock:(void(^_Nullable)(KJRenderImageView *obj))paramblock;
/// 修改效果
- (void)kj_changeRenderInfo:(KJRenderInfo*)info;
#pragma mark - ExtendParameterBlock 扩展参数
@property(nonatomic,strong,readonly) KJRenderImageView *(^kAddView)(UIView*);
@property(nonatomic,strong,readonly) KJRenderImageView *(^kFrame)(CGRect);
@end
@interface KJRenderInfo : NSObject
@property(nonatomic,assign)KJRenderFilterType type; /// 滤镜
@property(nonatomic,assign)float opacity;/// 透明度，默认 1
@property(nonatomic,assign)float extend;/// 扩展
@property(nonatomic,strong)UIColor *color;/// 颜色滤镜
@property(nonatomic,assign)KJRenderCoreImageFilterType coreType;/// CoreImage 滤镜
@end
NS_ASSUME_NONNULL_END
