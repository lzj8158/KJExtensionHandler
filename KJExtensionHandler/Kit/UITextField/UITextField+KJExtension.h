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
@interface KJTextFieldLeftInfo : NSObject
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,strong)NSString *imageName;
@property(nonatomic,assign)CGFloat maxImageHeight;// 图片的最大高度，默认父类高度一半
@property(nonatomic,assign)CGFloat periphery;// 边距，默认0px
@property(nonatomic,assign)CGFloat minWidth;// 最小宽度，默认实际宽度
@property(nonatomic,assign)KJTextAndImageStyle style;// 图文样式
@property(nonatomic,assign)CGFloat padding;// 图文间距，默认5px
@end
@interface UITextField (KJExtension)
/// 设置底部边框线条颜色
@property(nonatomic,strong)UIColor *bottomLineColor;
/// 占位placeholder颜色
@property(nonatomic,strong)UIColor *placeholderColor;
/// 最大长度
@property(nonatomic,assign)NSInteger maxLength;
/// 达到最大字符长度
@property(nonatomic,copy,readwrite)void(^kMaxLengthBolck)(NSString*text);
/// 明文暗文切换
@property(nonatomic,assign)BOOL securePasswords;

/// 设置左边视图，类似账号密码标题
- (UIView*)kj_leftView:(KJTextFieldLeftInfo*(^)(KJTextFieldLeftInfo*info))block;
/// 设置右边视图，类似小圆叉
- (UIButton*)kj_rightViewTapBlock:(void(^_Nullable)(bool state))block ImageName:(NSString*)imageName Width:(CGFloat)width Padding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
