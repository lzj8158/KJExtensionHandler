//
//  UINavigationBar+KJExtension.m
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UINavigationBar+KJExtension.h"

@implementation UINavigationBar (KJExtension)
- (UINavigationBar *)kj_hiddenNavigationBarBottomLine{
    if (@available(iOS 13.0, *)) {
        self.standardAppearance.shadowColor = [UIColor clearColor];
    }else{
        if (@available(iOS 10.0, *)){
            [self kj_hiddenLine:YES];
        }else{
            self.shadowImage = [UIImage new];
        }
    }
    return self;
}
- (UINavigationBar * (^)(UIColor *))kj_changeNavigationBarBackgroundColor{
    return ^(UIColor * color){
        if (color == UIColor.clearColor || CGColorGetAlpha(color.CGColor) <= 0.0001) {
            if (@available(iOS 13.0, *)) {
                [self.standardAppearance configureWithTransparentBackground];
                self.standardAppearance.shadowColor = [UIColor clearColor];
            }else{
                [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
                if (@available(iOS 10.0, *)){
                    [self kj_hiddenLine:YES];
                }else{
                    self.shadowImage = [UIImage new];
                }
            }
        }else{
            if (@available(iOS 13.0, *)) {
                [self.standardAppearance configureWithOpaqueBackground];
                [self.standardAppearance setBackgroundColor:color];
                [self.standardAppearance setBackgroundImage:nil];
            }else{
                [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
                [self setBarTintColor:color];
            }
        }
        return self;
    };
}
/// 设置图片背景导航栏
- (UINavigationBar * (^)(UIImage *))kj_changeNavigationBarImage{
    return ^(UIImage *image){
        UIColor *color = [UIColor colorWithPatternImage:image];
        return self.kj_changeNavigationBarBackgroundColor(color);
    };
}
- (UINavigationBar * (^)(UIColor *, UIFont *))kj_changeNavigationBarTitle{
    return ^(UIColor * color, UIFont * font){
        if (@available(iOS 13.0, *)) {
            [self.standardAppearance setTitleTextAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
        }else{
            [self setTitleTextAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
        }
        return self;
    };
}
- (void)kj_resetNavigationBarSystem{
    if (@available(iOS 13.0, *)){
        [self.standardAppearance configureWithDefaultBackground];
        self.standardAppearance.shadowImage = nil;
    }else{
        [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        if (@available(iOS 10.0, *)){
            [self kj_hiddenLine:NO];
        }else{
            self.shadowImage = nil;
        }
    }
}
- (void)kj_changeNavigationBarBackImage:(NSString*)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (@available(iOS 13.0, *)){
        [self.standardAppearance setBackIndicatorImage:image transitionMaskImage:image];
    }else{
        self.backIndicatorTransitionMaskImage = self.backIndicatorImage = image;
    }
}
/// 隐藏线条
- (void)kj_hiddenLine:(BOOL)hidden{
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        for (UIView *view in self.subviews){
            for (id obj in view.subviews) {
                if ([obj isKindOfClass:[UIImageView class]]) {
                    ((UIImageView*)obj).hidden = hidden;
                }
            }
        }
    }
}

@end


