//
//  UITextField+KJExtension.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/4.
//  https://github.com/yangKJ/KJExtensionHandler
//  输入框扩展，快速设置账号密码框

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJTextAndImageStyle) {
    KJTextAndImageStyleNormal = 0,// 图左文右
    KJTextAndImageStyleImageRight,// 图右文左
};
@class KJTextFieldLeftInfo;
IB_DESIGNABLE
@interface UITextField (KJExtension)
/// 设置底部边框线条颜色
@property(nonatomic,strong)IBInspectable UIColor *bottomLineColor;
/// 占位placeholder颜色
@property(nonatomic,strong)IBInspectable UIColor *placeholderColor;
/// 最大长度
@property(nonatomic,assign)IBInspectable NSInteger maxLength;
/// 达到最大字符长度
@property(nonatomic,copy,readwrite)void(^kMaxLengthBolck)(NSString*text);
/// 明文暗文切换
@property(nonatomic,assign)BOOL securePasswords;

/// 设置左边视图，类似账号密码标题
- (UIView*)kj_leftView:(void(^)(KJTextFieldLeftInfo *info))block;
/// 设置右边视图，类似小圆叉
- (UIButton*)kj_rightViewTapBlock:(void(^_Nullable)(bool state))block ImageName:(NSString*)imageName Width:(CGFloat)width Padding:(CGFloat)padding;

@end

/// 左边视图的相关参数设置
@interface KJTextFieldLeftInfo : NSObject
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *imageName;
/// 文本颜色，默认控件字体颜色
@property(nonatomic,strong)UIColor *textColor;
/// 文本字体，默认控件字体
@property(nonatomic,strong)UIFont *font;
/// 图片的最大高度，默认控件高度一半
@property(nonatomic,assign)CGFloat maxImageHeight;
/// 边距，默认0px
@property(nonatomic,assign)CGFloat periphery;
/// 最小宽度，默认实际宽度
@property(nonatomic,assign)CGFloat minWidth;
/// 图文样式，默认图左文右
@property(nonatomic,assign)KJTextAndImageStyle style;
/// 图文间距，默认5px
@property(nonatomic,assign)CGFloat padding;
@end
NS_ASSUME_NONNULL_END
