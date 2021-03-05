//
//  _KJQuickCreateHandle.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/24.
//  https://github.com/yangKJ/KJExtensionHandler
//  快速链式创建UI控件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol KJQuickCreateHandle <NSObject>
@optional;
#pragma mark - common
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_frame)(CGFloat x,CGFloat y,CGFloat w,CGFloat h);
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_add)(UIView*);
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_background)(UIColor*);
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_image)(UIImage*);
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_imageName)(NSString*);
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_text)(NSString*);
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_font)(UIFont*);
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_fontSize)(CGFloat);
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_textColor)(UIColor*);

#pragma mark - button
@property(nonatomic,copy,readonly)id<KJQuickCreateHandle>(^kj_buttonSelectedImage)(UIImage*);

@end
/// 公共部分
#define Quick_Create_Common \
- (id<KJQuickCreateHandle>(^)(UIView *))kj_add{\
    return ^(UIView * superview) {\
        [superview addSubview:self];\
        return self;\
    };\
}\
- (id<KJQuickCreateHandle> (^)(CGFloat, CGFloat, CGFloat, CGFloat))kj_frame{\
    return ^(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {\
        self.frame = CGRectMake(x, y, w, h);\
        return self;\
    };\
}\
- (id<KJQuickCreateHandle>(^)(UIColor *))kj_background{\
    return ^(UIColor * color) {\
        self.backgroundColor = color;\
        return self;\
    };\
}\
