//
//  NSString+KJExtension.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler
//  字符串扩展属性

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
/// 生成竖直文字
@property(nonatomic,strong,readonly)NSString *verticalText;

/// Josn字符串转字典
@property(nonatomic,strong,readonly)NSDictionary *jsonDict;
/// 字典转Json字符串
NSString * kDictionaryToJson(NSDictionary *dict);
/// 数组转Json字符串
NSString * kArrayToJson(NSArray *array);
/// Json字符串转字典
NSDictionary *kJsonToDictionary(NSString *string);

/// 获取文本宽度
- (CGFloat)kj_maxWidthWithFont:(UIFont*)font
                        Height:(CGFloat)height
                     Alignment:(NSTextAlignment)alignment
                 LinebreakMode:(NSLineBreakMode)linebreakMode
                     LineSpace:(CGFloat)lineSpace;
/// 获取文本高度
- (CGFloat)kj_maxHeightWithFont:(UIFont*)font
                          Width:(CGFloat)width
                      Alignment:(NSTextAlignment)alignment
                  LinebreakMode:(NSLineBreakMode)linebreakMode
                      LineSpace:(CGFloat)lineSpace;
/// 文字转图片
- (UIImage*)kj_textBecomeImageWithSize:(CGSize)size
                       BackgroundColor:(UIColor*)color
                        TextAttributes:(NSDictionary*)attributes;

/// 复制数据至剪切板
- (void)kj_pasteboard;

#pragma mark - 汉字相关处理
/// 汉字转拼音
@property(nonatomic,strong,readonly)NSString *pinYin;
/// 随机汉字
+ (NSString*)kj_randomCreateChinese:(NSInteger)count;
/// 查找数据，返回-1表示未查询到
- (int)kj_searchArray:(NSArray<NSString*>*)temps;
/// 字母排序
- (NSArray*)kj_letterSortArray:(NSArray<NSString*>*)array;

#pragma mark - 谓词相关
/// 过滤空格
- (NSString*)kj_filterSpace;
/// 验证数字
- (BOOL)kj_validateNumber;
/// 验证字符串中是否有特殊字符
- (BOOL)kj_validateHaveSpecialCharacter;
/// 过滤特殊字符
- (NSString*)kj_removeSpecialCharacter:(NSString*_Nullable)character;
/// 验证手机号码
- (BOOL)kj_validateMobileNumber;
/// 验证邮箱格式
- (BOOL)kj_validateEmail;
/// 验证身份证
- (BOOL)kj_validateIDCardNumber;
/// 验证银行卡
- (BOOL)kj_validateBankCardNumber;

@end

NS_ASSUME_NONNULL_END
