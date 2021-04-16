//
//  UIButton+KJCreate.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJCreate.h"

@interface UIButton ()<KJButtonDelegate>
@end
@implementation UIButton (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createButton:(void(^)(id<KJButtonDelegate>))handle{
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.adjustsImageWhenDisabled = button.adjustsImageWhenHighlighted = NO;
    if (handle) handle(button);
    return button;
}
UIButton * kCreateButtonDelegate(void(^handle)(id<KJButtonDelegate>delegate)){
    return [UIButton kj_createButton:handle];
}
#pragma mark - KJQuickCreateHandle
Quick_Create_Common
- (id<KJImageViewDelegate>(^)(UIImage *))kj_image{
    return ^(UIImage * image) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}
- (id<KJImageViewDelegate>(^)(NSString *))kj_imageName{
    return ^(NSString * name) {
        UIImage *image = [UIImage imageNamed:name];
        if (image) [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}
- (id<KJLabelDelegate>(^)(NSString *))kj_text{
    return ^(NSString * text) {
        [self setTitle:text forState:(UIControlStateNormal)];
        return self;
    };
}
- (id<KJLabelDelegate>(^)(UIFont *))kj_font{
    return ^(UIFont * font) {
        self.titleLabel.font = font;
        return self;
    };
}
- (id<KJLabelDelegate>(^)(CGFloat))kj_fontSize{
    return ^(CGFloat size) {
        self.titleLabel.font = [UIFont systemFontOfSize:size];
        return self;
    };
}
- (id<KJLabelDelegate>(^)(UIColor *))kj_textColor{
    return ^(UIColor * color) {
        [self setTitleColor:color forState:(UIControlStateNormal)];
        return self;
    };
}
- (id<KJButtonDelegate>(^)(UIImage *,UIControlState))kj_stateImage{
    return ^(UIImage * image,UIControlState state) {
        [self setImage:image forState:state];
        return self;
    };
}
- (id<KJButtonDelegate>(^)(NSString*,UIColor*,UIControlState))kj_stateTitle{
    return ^(NSString*string, UIColor *color, UIControlState state) {
        [self setTitle:string forState:state];
        [self setTitleColor:color forState:state];
        return self;
    };
}

@end

/* **************************** 快捷创建文本 ****************************/
@interface UILabel ()<KJLabelDelegate>
@end
@implementation UILabel (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createLabel:(void(^)(id<KJLabelDelegate>))handle{
    UILabel *label = [[self alloc] init];
    if (handle) handle(label);
    return label;
}
UILabel * kCreateLabelDelegate(void(^handle)(id<KJLabelDelegate>delegate)){
    return [UILabel kj_createLabel:handle];
}
#pragma mark - KJQuickCreateHandle
Quick_Create_Common
- (id<KJLabelDelegate>(^)(NSString *))kj_text{
    return ^(NSString * text) {
        self.text = text;
        return self;
    };
}
- (id<KJLabelDelegate>(^)(UIFont *))kj_font{
    return ^(UIFont * font) {
        self.font = font;
        return self;
    };
}
- (id<KJLabelDelegate>(^)(CGFloat))kj_fontSize{
    return ^(CGFloat size) {
        self.font = [UIFont systemFontOfSize:size];
        return self;
    };
}
- (id<KJLabelDelegate>(^)(UIColor *))kj_textColor{
    return ^(UIColor * color) {
        self.textColor = color;
        return self;
    };
}

@end

// UIImageView
@interface UIImageView ()<KJImageViewDelegate>
@end
@implementation UIImageView (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createImageView:(void(^)(id<KJImageViewDelegate>delegate))handle{
    UIImageView *imageView = [[UIImageView alloc] init];
    if (handle) handle(imageView);
    return imageView;
}
UIImageView * kCreateImageViewDelegate(void(^handle)(id<KJImageViewDelegate>delegate)){
    return [UIImageView kj_createImageView:handle];
}
#pragma mark - KJQuickCreateHandle
Quick_Create_Common
- (id<KJImageViewDelegate>(^)(UIImage *))kj_image{
    return ^(UIImage * image) {
        self.image = image;
        return self;
    };
}
- (id<KJImageViewDelegate>(^)(NSString *))kj_imageName{
    return ^(NSString * name) {
        UIImage *image = [UIImage imageNamed:name];
        if (image) self.image = image;
        return self;
    };
}
@end

@interface UIView ()<KJViewDelegate>
@end
@implementation UIView (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createView:(void(^)(id<KJViewDelegate>delegate))handle{
    UIView *view = [[UIView alloc] init];
    if (handle) handle(view);
    return view;
}
UIView * kCreateViewDelegate(void(^handle)(id<KJViewDelegate>delegate)){
    return [UIView kj_createView:handle];
}
#pragma mark - KJQuickCreateHandle
Quick_Create_Common


@end
