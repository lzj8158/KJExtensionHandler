//
//  NSString+KJSecurity.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/5.
//  https://github.com/yangKJ/KJExtensionHandler
//  加密解密工具
//  用法示例：NSString *encryptString = @"原始数据".kj_rsaEncryptPublicKey(@"key");
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (KJSecurity)
/// 生成key
+ (NSString*)kj_createKey;
/// 生成token
+ (NSString*)kj_createToken;

#pragma mark - rsa非对称加密算法
/// 公钥加密
- (NSString*(^)(NSString *key))kj_rsaEncryptPublicKey;
/// 公钥解密
- (NSString*(^)(NSString *key))kj_rsaDecryptPublicKey;
/// 私钥加密
- (NSString*(^)(NSString *key))kj_rsaEncryptPrivateKey;
/// 私钥解密
- (NSString*(^)(NSString *key))kj_rsaDecryptPrivateKey;

#pragma mark - aes对称加密算法
/// 加密
- (NSString*(^)(NSString *key))kj_aesEncryptKey;
/// 解密
- (NSString*(^)(NSString *key))kj_aesDecryptKey;

@end

NS_ASSUME_NONNULL_END
