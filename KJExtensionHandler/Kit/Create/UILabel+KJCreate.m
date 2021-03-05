//
//  UILabel+KJCreate.m
//  KJEmitterView
//
//  Created by 杨科军 on 2020/9/14.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UILabel+KJCreate.h"
@interface UILabel ()<KJQuickCreateHandle>
@end
@implementation UILabel (KJCreate)
/// 快速创建处理
+ (instancetype)kj_createLabel:(void(^)(id<KJQuickCreateHandle>handle))handle{
    UILabel *label = [[self alloc] init];
    if (handle) handle(label);
    return label;
}
#pragma mark - KJQuickCreateHandle
Quick_Create_Common
- (id<KJQuickCreateHandle>(^)(NSString *))kj_text{
    return ^(NSString * text) {
        self.text = text;
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(UIFont *))kj_font{
    return ^(UIFont * font) {
        self.font = font;
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(CGFloat))kj_fontSize{
    return ^(CGFloat size) {
        self.font = [UIFont systemFontOfSize:size];
        return self;
    };
}
- (id<KJQuickCreateHandle>(^)(UIColor *))kj_textColor{
    return ^(UIColor * color) {
        self.textColor = color;
        return self;
    };
}

@end
