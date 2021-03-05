//
//  UIButton+KJBlock.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJBlock.h"
#import <objc/runtime.h>
@implementation UIButton (KJBlock)
static NSString * const _Nonnull KJButtonControlEventsStringMap[] = {
    [UIControlEventTouchDown]        = @"KJ_X_UIControlEventTouchDown",
    [UIControlEventTouchDownRepeat]  = @"KJ_X_UIControlEventTouchDownRepeat",
    [UIControlEventTouchDragInside]  = @"KJ_X_UIControlEventTouchDragInside",
    [UIControlEventTouchDragOutside] = @"KJ_X_UIControlEventTouchDragOutside",
    [UIControlEventTouchDragEnter]   = @"KJ_X_UIControlEventTouchDragEnter",
    [UIControlEventTouchDragExit]    = @"KJ_X_UIControlEventTouchDragExit",
    [UIControlEventTouchUpInside]    = @"KJ_X_UIControlEventTouchUpInside",
    [UIControlEventTouchUpOutside]   = @"KJ_X_UIControlEventTouchUpOutside",
    [UIControlEventTouchCancel]      = @"KJ_X_UIControlEventTouchCancel",
};
#define KJButtonAction(name) \
- (void)kj_action##name{ \
KJButtonBlock block = objc_getAssociatedObject(self, _cmd);\
if (block) block(self);\
}
/// 事件响应方法
KJButtonAction(KJ_X_UIControlEventTouchDown);
KJButtonAction(KJ_X_UIControlEventTouchDownRepeat);
KJButtonAction(KJ_X_UIControlEventTouchDragInside);
KJButtonAction(KJ_X_UIControlEventTouchDragOutside);
KJButtonAction(KJ_X_UIControlEventTouchDragEnter);
KJButtonAction(KJ_X_UIControlEventTouchDragExit);
KJButtonAction(KJ_X_UIControlEventTouchUpInside);
KJButtonAction(KJ_X_UIControlEventTouchUpOutside);
KJButtonAction(KJ_X_UIControlEventTouchCancel);

/// 添加点击事件，默认UIControlEventTouchUpInside
- (void)kj_addAction:(KJButtonBlock)block{
    [self kj_addAction:block forControlEvents:UIControlEventTouchUpInside];
}
/// 添加事件
- (void)kj_addAction:(KJButtonBlock)block forControlEvents:(UIControlEvents)controlEvents{
    if (block == nil || controlEvents>(1<<8)) return;
    if (controlEvents != UIControlEventTouchDown && (controlEvents&1)) return;
    NSString *actionName = [@"kj_action" stringByAppendingFormat:@"%@",KJButtonControlEventsStringMap[controlEvents]];
    SEL selector = NSSelectorFromString(actionName);
    objc_setAssociatedObject(self, selector, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:selector forControlEvents:controlEvents];
}


#pragma mark - 时间相关方法交换
/// 交换方法后实现
- (void)kj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event{
    if (self.timeInterval <= 0) {
        [self kj_sendAction:action to:target forEvent:event];
        return;
    }
    NSTimeInterval time = CFAbsoluteTimeGetCurrent();
    if ((time - self.lastTime >= self.timeInterval)) {
        self.lastTime = time;
        [self kj_sendAction:action to:target forEvent:event];
    }
}
#pragma mark - associated
- (CGFloat)timeInterval{
    return [objc_getAssociatedObject(self, @selector(timeInterval)) doubleValue];
}
- (void)setTimeInterval:(CGFloat)timeInterval{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_ASSIGN);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kExceptionMethodSwizzling([self class], @selector(sendAction:to:forEvent:), @selector(kj_sendAction:to:forEvent:));
    });
}
- (NSTimeInterval)lastTime{
    return [objc_getAssociatedObject(self, @selector(lastTime)) doubleValue];
}
- (void)setLastTime:(NSTimeInterval)lastTime{
    objc_setAssociatedObject(self, @selector(lastTime), @(lastTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 交换实例方法的实现
static void kExceptionMethodSwizzling(Class clazz, SEL original, SEL swizzled){
    Method originalMethod = class_getInstanceMethod(clazz, original);
    Method swizzledMethod = class_getInstanceMethod(clazz, swizzled);
    if (class_addMethod(clazz, original, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(clazz, swizzled, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - 扩大点击域
static char topNameKey,bottomNameKey;
static char leftNameKey,rightNameKey;
- (void)kj_EnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect{
    NSNumber *topEdge   = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge= objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge  = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue, self.bounds.origin.y - topEdge.floatValue, self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue, self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else {
        return self.bounds;
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event{
    UIEdgeInsets touchAreaInsets = self.touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left, bounds.origin.y - touchAreaInsets.top, bounds.size.width + touchAreaInsets.left + touchAreaInsets.right, bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}
#pragma mark - associated
- (UIEdgeInsets)touchAreaInsets{
    return [objc_getAssociatedObject(self, @selector(touchAreaInsets)) UIEdgeInsetsValue];
}
- (void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets{
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
