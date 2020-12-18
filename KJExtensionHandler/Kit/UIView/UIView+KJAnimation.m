//
//  UIView+KJAnimation.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/18.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIView+KJAnimation.h"
@interface KJAnimationManager ()
@property(nonatomic,assign)NSInteger repeatCount;
@property(nonatomic,assign)CGFloat repeatDuration;
@property(nonatomic,assign)CGFloat duration;
@property(nonatomic,assign)BOOL autoreverses;
@property(nonatomic,assign)NSInteger ease;
@property(nonatomic,assign)CGFloat multiple;
@property(nonatomic,assign)CGFloat opacity;
@end
@implementation UIView (KJAnimation)
/// 动画组
- (CAAnimationGroup*)kj_animationMoreAnimations:(NSArray<CABasicAnimation*>*)animations{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.animations = animations;
    [self.layer addAnimation:group forKey:@"animations"];
    return group;
}
- (CABasicAnimation*)kj_createBasicAnimation:(NSString*)keyPath Parameter:(KJAnimationManager*)manager{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.duration = manager.duration;
    animation.autoreverses = manager.autoreverses;
    animation.repeatDuration = manager.repeatDuration;
    animation.beginTime = CACurrentMediaTime()+ 0.1;
    animation.repeatCount = manager.repeatCount?:MAXFLOAT;
    return animation;
}
/// 旋转动画效果
- (CABasicAnimation*)kj_animationRotateClockwise:(BOOL)clockwise makeParameter:(void(^)(KJAnimationManager *make))parameter{
    KJAnimationManager *manager = [KJAnimationManager new];
    if (parameter) parameter(manager);
    CABasicAnimation *animation = [self kj_createBasicAnimation:@"transform.rotation.z" Parameter:manager];
    animation.fromValue = @(clockwise ? 0 : M_PI*2);
    animation.toValue   = @(clockwise ? M_PI*2 : 0);
    animation.fillMode = kCAFillModeForwards;
    if (manager.ease == 1) {
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    }else if (manager.ease == 2) {
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }else if (manager.ease == 3) {
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    }
    [self.layer addAnimation:animation forKey:@"rotate-layer"];
    return animation;
}
/// 移动动画效果
- (CABasicAnimation*)kj_animationMovePoint:(CGPoint)point makeParameter:(void(^)(KJAnimationManager *make))parameter{
    KJAnimationManager *manager = [KJAnimationManager new];
    if (parameter) parameter(manager);
    CABasicAnimation *animation = [self kj_createBasicAnimation:@"position" Parameter:manager];
    animation.fromValue = [NSValue valueWithCGPoint:self.layer.position];
    animation.toValue   = [NSValue valueWithCGPoint:point];
    [self.layer addAnimation:animation forKey:@"move-layer"];
    return animation;
}
/// 缩放动画效果
- (CABasicAnimation*)kj_animationZoomMultiple:(CGFloat)multiple makeParameter:(void(^)(KJAnimationManager *make))parameter{
    KJAnimationManager *manager = [KJAnimationManager new];
    if (parameter) parameter(manager);
    CABasicAnimation *animation = [self kj_createBasicAnimation:@"transform.scale" Parameter:manager];
    animation.fromValue = @(manager.multiple);
    animation.toValue   = @(multiple);
    [self.layer addAnimation:animation forKey:@"scale-layer"];
    return animation;
}
/// 渐隐动画效果
- (CABasicAnimation*)kj_animationOpacity:(CGFloat)opacity makeParameter:(void(^)(KJAnimationManager *make))parameter{
    KJAnimationManager *manager = [KJAnimationManager new];
    if (parameter) parameter(manager);
    CABasicAnimation *animation = [self kj_createBasicAnimation:@"opacity" Parameter:manager];
    animation.fromValue = @(opacity);
    animation.toValue   = @(manager.opacity);
    [self.layer addAnimation:animation forKey:@"opacity-layer"];
    return animation;
}

@end
@implementation KJAnimationManager
- (instancetype)init{
    if (self==[super init]) {
        self.duration = 5;
        self.repeatCount = 0;
        self.opacity = self.multiple = 1;
    }
    return self;
}
- (KJAnimationManager * (^)(NSInteger))kRepeatCount{
    return ^KJAnimationManager*(NSInteger xxx) {
        self.repeatCount = xxx;
        return self;
    };
}
- (KJAnimationManager * (^)(CGFloat))kRepeatDuration{
    return ^KJAnimationManager*(CGFloat xxx) {
        self.repeatDuration = xxx;
        return self;
    };
}
- (KJAnimationManager * (^)(CGFloat))kDuration{
    return ^KJAnimationManager*(CGFloat xxx) {
        self.duration = xxx;
        return self;
    };
}
- (KJAnimationManager * (^)(BOOL))kAutoreverses{
    return ^KJAnimationManager*(BOOL boo) {
        self.autoreverses = boo;
        return self;
    };
}
- (KJAnimationManager * (^)(NSInteger))kEaseInEaseOut{
    return ^KJAnimationManager*(NSInteger xxx) {
        self.ease = xxx;
        return self;
    };
}
- (KJAnimationManager * (^)(CGFloat))kBeginMultiple{
    return ^KJAnimationManager*(CGFloat xxx) {
        self.multiple = xxx;
        return self;
    };
}
- (KJAnimationManager * (^)(CGFloat))kEndOpacity{
    return ^KJAnimationManager*(CGFloat xxx) {
        self.opacity = xxx;
        return self;
    };
}

@end
