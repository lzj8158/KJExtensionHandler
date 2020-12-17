//
//  NSString+KJExtension.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler
//  字符串扩展属性

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJExtension)
/// 是否为空
@property(nonatomic,assign,readonly)bool isEmpty;
/// 转换为URL
@property(nonatomic,strong,readonly)NSURL *URL;
/// 获取图片
@property(nonatomic,strong,readonly)UIImage *image;
/// 取出HTML
@property(nonatomic,strong,readonly)NSString *HTMLString;
/// Josn字符串转字典
@property(nonatomic,strong,readonly)NSDictionary *jsonDict;

/// 获取文本宽度
- (CGFloat)kj_maxWidthWithFont:(UIFont*)font Height:(CGFloat)height Alignment:(NSTextAlignment)alignment LinebreakMode:(NSLineBreakMode)linebreakMode LineSpace:(CGFloat)lineSpace;
/// 获取文本高度
- (CGFloat)kj_maxHeightWithFont:(UIFont*)font Width:(CGFloat)width Alignment:(NSTextAlignment)alignment LinebreakMode:(NSLineBreakMode)linebreakMode LineSpace:(CGFloat)lineSpace;

@end

NS_ASSUME_NONNULL_END
