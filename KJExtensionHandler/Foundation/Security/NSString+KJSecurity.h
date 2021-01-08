//
//  NSString+KJSecurity.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/5.
//  https://github.com/yangKJ/KJExtensionHandler
//  加密解密工具
//  用法示例：NSString *encryptString = @"原始数据".kj_rsaEncryptPublicKey(@"key");
#import <Foundation/Foundation.h>
#import "NSData+KJRSA.h"
#import "NSData+KJAES.h"
#import "NSData+KJBase64.h"
NS_ASSUME_NONNULL_BEGIN
@interface NSString (KJSecurity)
/// 生成key
+ (NSString*)kj_createKey;
/// 生成token
+ (NSString*)kj_createToken;

#pragma mark - RSA 非对称加密算法
/// 公钥加密
- (NSString*(^)(NSString*))kj_rsaEncryptPublicKey;
/// 公钥解密
- (NSString*(^)(NSString*))kj_rsaDecryptPublicKey;
/// 私钥加密
- (NSString*(^)(NSString*))kj_rsaEncryptPrivateKey;
/// 私钥解密
- (NSString*(^)(NSString*))kj_rsaDecryptPrivateKey;

#pragma mark - AES 对称加密算法
/// 加密
- (NSString*(^)(NSString*))kj_aesEncryptKey;
/// 解密
- (NSString*(^)(NSString*))kj_aesDecryptKey;

#pragma mark - base64
/// Base64编码
- (NSString*)kj_base64EncodedString;
/// Base64解码
- (NSString*)kj_base64DecodingString;

@end

NS_ASSUME_NONNULL_END
