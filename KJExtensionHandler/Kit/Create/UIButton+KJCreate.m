//
//  UIButton+KJCreate.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJCreate.h"

@interface UIButton ()<KJQuickCreateHandle>
@end
@implementation UIButton (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createButton:(void(^)(id<KJQuickCreateHandle>handle))handle{
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.adjustsImageWhenDisabled = button.adjustsImageWhenHighlighted = NO;
    if (handle) handle(button);
    return button;
}
#pragma mark - KJQuickCreateHandle
Quick_Create_Common
- (id<KJQuickCreateHandle>(^)(UIImage *))kj_image{
    return ^(UIImage * image) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(NSString *))kj_imageName{
    return ^(NSString * name) {
        [self setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(NSString *))kj_text{
    return ^(NSString * text) {
        [self setTitle:text forState:(UIControlStateNormal)];
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(UIFont *))kj_font{
    return ^(UIFont * font) {
        self.titleLabel.font = font;
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(CGFloat))kj_fontSize{
    return ^(CGFloat size) {
        self.titleLabel.font = [UIFont systemFontOfSize:size];
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(UIColor *))kj_textColor{
    return ^(UIColor * color) {
        [self setTitleColor:color forState:(UIControlStateNormal)];
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(UIImage *))kj_buttonSelectedImage{
    return ^(UIImage * image) {
        [self setImage:image forState:UIControlStateSelected];
        return self;
    };
}

@end
