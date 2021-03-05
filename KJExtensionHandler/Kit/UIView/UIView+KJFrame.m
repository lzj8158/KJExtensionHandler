//
//  UIView+KJFrame.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIView+KJFrame.h"
@interface UIView()
@property(nonatomic,assign)CGFloat maxX,maxY;
@end

@implementation UIView (KJFrame)
#pragma mark - 使用Masonry布局之后得到尺寸
@dynamic masonry_x,masonry_y,masonry_width,masonry_height;
- (CGFloat)masonry_x{
    [self.superview layoutIfNeeded];
    return self.frame.origin.x;
}
- (CGFloat)masonry_y{
    [self.superview layoutIfNeeded];
    return self.frame.origin.y;
}
- (CGFloat)masonry_width{
    [self.superview layoutIfNeeded];
    return self.frame.size.width;
}
- (CGFloat)masonry_height{
    [self.superview layoutIfNeeded];
    return self.frame.size.height;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGPoint)origin{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin.x = origin.x;
    frame.origin.y = origin.y;
    self.frame = frame;
}
- (CGFloat)centerX{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)left{
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = self.superview.frame.size.width - right - self.frame.size.width;
    self.frame = frame;
}
- (CGFloat)top{
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = self.superview.frame.size.height - bottom - self.frame.size.height;
    self.frame = frame;
}
@dynamic maxX,maxY;
- (CGFloat)maxX{
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)maxY{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)kj_centerToSuperview{
    if (self.superview) {
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                self.origin = CGPointMake((self.superview.height/2.0) - (self.width/2.0), (self.superview.width/2.0) - (self.height/2.0));
                break;
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
                self.origin = CGPointMake((self.superview.width/2.0) - (self.width/2.0), (self.superview.height/2.0) - (self.height/2.0));
                break;
            case UIInterfaceOrientationUnknown:
                return;
        }
    }
}
- (void)kj_rightToSuperview:(CGFloat)right{
    self.x = self.superview.width - self.width - right;
}
- (void)kj_bottomToSuperview:(CGFloat)bottom{
    self.y = self.superview.height - self.height - bottom;
}
- (CGFloat)kj_subviewMaxY{
    CGFloat y = 0;
    for (UIView *view in [self subviews]) {
        y = MAX(view.maxY, y);
    }
    return y;
}
- (CGFloat)kj_subviewMaxX{
    CGFloat x = 0;
    for (UIView *view in [self subviews]) {
        x = MAX(view.maxX, x);
    }
    return x;
}
/// 寻找子视图
- (UIView*)kj_FindSubviewRecursively:(BOOL(^)(UIView *subview, BOOL *stop))recurse{
    for (UIView *view in self.subviews) {
        BOOL stop = NO;
        if(recurse(view, &stop)) {
            return [view kj_FindSubviewRecursively:recurse];
        }else if(stop) {
            return view;
        }
    }
    return nil;
}
/// 移除所有子视图
- (void)kj_removeAllSubviews{
    while (self.subviews.count) {
        UIView * child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
/// 隐藏/显示所有子视图
- (void)kj_hideSubviews:(BOOL)hide operation:(BOOL(^)(UIView *subview))operation{
    for (UIView *view in self.subviews) {
        if (operation && operation(view) == NO) continue;
        view.hidden = hide;
    }
}
/// 子控件处理手势事件
- (UIView*)kj_childHitTest:(CGPoint)point withEvent:(UIEvent*)event{
    NSInteger count = self.subviews.count;
    for (int i = 0; i < count; i++) {
        UIView *childView  = self.subviews[count - 1 - i];
        CGPoint childPoint = [self convertPoint:point toView:childView];
        UIView *view = [childView hitTest:childPoint withEvent:event];
        if (view) return view;
    }
    return nil;
}
/// xib创建的view
+ (instancetype)kj_viewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
+ (instancetype)kj_viewFromXibWithFrame:(CGRect)frame {
    UIView *view = [self kj_viewFromXib];
    view.frame = frame;
    return view;
}
/// 判断一个控件是否真正显示在主窗口
- (BOOL)kj_isShowingOnKeyWindow{
    UIWindow *keyWindow = ({
        UIWindow *window;
        if (@available(iOS 13.0, *)) {
            window = [UIApplication sharedApplication].windows.firstObject;
        }else{
            window = [UIApplication sharedApplication].keyWindow;
        }
        window;
    });
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}
- (BOOL)showKeyWindow{
    return [self kj_isShowingOnKeyWindow];
}
/// 判断是否有子视图在滚动
- (BOOL)kj_anySubViewScrolling{
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView*)self;
        if (scrollView.dragging || scrollView.decelerating) {
            return YES;
        }
    }
    for (UIView *subview in self.subviews) {
        if ([subview kj_anySubViewScrolling]) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)anySubViewScrolling{
    return [self kj_anySubViewScrolling];
}
/// 当前的控制器
- (UIViewController*)kj_currentViewController{
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }while (responder);
    return nil;
}
- (UIViewController*)viewController{
    return [self kj_currentViewController];
}

@end
