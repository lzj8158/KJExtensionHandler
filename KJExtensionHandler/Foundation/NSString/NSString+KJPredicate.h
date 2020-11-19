//
//  NSString+KJPredicate.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/16.
//  https://github.com/yangKJ/KJExtensionHandler
//  谓词工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJPredicate)
/// 过滤空格
- (NSString*)kj_filterSpace;
/// 验证数字
- (BOOL)kj_validateNumber;
/// 验证字符串中是否有特殊字符
- (BOOL)kj_validateHaveSpecialCharacter;
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
