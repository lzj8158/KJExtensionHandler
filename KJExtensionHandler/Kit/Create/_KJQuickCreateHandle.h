//
//  _KJQuickCreateHandle.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/24.
//  https://github.com/yangKJ/KJExtensionHandler
//  快速链式创建UI控件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol KJCustomDelegate <NSObject>
@optional;
@property(nonatomic,copy,readonly)id<KJCustomDelegate>(^kj_frame)(CGFloat x,CGFloat y,CGFloat w,CGFloat h);
@property(nonatomic,copy,readonly)id<KJCustomDelegate>(^kj_add)(UIView*);
@property(nonatomic,copy,readonly)id<KJCustomDelegate>(^kj_background)(UIColor*);

@end

@protocol KJViewDelegate <KJCustomDelegate>
@optional;

@end

@protocol KJLabelDelegate <KJCustomDelegate>
@optional;
@property(nonatomic,copy,readonly)id<KJLabelDelegate>(^kj_text)(NSString*);
@property(nonatomic,copy,readonly)id<KJLabelDelegate>(^kj_font)(UIFont*);
@property(nonatomic,copy,readonly)id<KJLabelDelegate>(^kj_fontSize)(CGFloat);
@property(nonatomic,copy,readonly)id<KJLabelDelegate>(^kj_textColor)(UIColor*);

@end

@protocol KJImageViewDelegate <KJCustomDelegate>
@optional;
@property(nonatomic,copy,readonly)id<KJImageViewDelegate>(^kj_image)(UIImage*);
@property(nonatomic,copy,readonly)id<KJImageViewDelegate>(^kj_imageName)(NSString*);

@end

@protocol KJButtonDelegate <KJLabelDelegate,KJImageViewDelegate>
@optional;
@property(nonatomic,copy,readonly)id<KJButtonDelegate>(^kj_stateImage)(UIImage*,UIControlState);
@property(nonatomic,copy,readonly)id<KJButtonDelegate>(^kj_stateTitle)(NSString*,UIColor*,UIControlState);

@end


/// 公共部分
#define Quick_Create_Common \
- (id<KJCustomDelegate>(^)(UIView *))kj_add{\
    return ^(UIView * superview) {\
        [superview addSubview:self];\
        return self;\
    };\
}\
- (id<KJCustomDelegate> (^)(CGFloat, CGFloat, CGFloat, CGFloat))kj_frame{\
    return ^(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {\
        self.frame = CGRectMake(x, y, w, h);\
        return self;\
    };\
}\
- (id<KJCustomDelegate>(^)(UIColor *))kj_background{\
    return ^(UIColor * color) {\
        self.backgroundColor = color;\
        return self;\
    };\
}\
