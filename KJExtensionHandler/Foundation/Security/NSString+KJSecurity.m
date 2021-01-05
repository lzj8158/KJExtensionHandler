//
//  NSString+KJSecurity.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/5.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSString+KJSecurity.h"
#import "NSData+KJRSA.h"
#import "NSData+KJAES.h"
@implementation NSString (KJSecurity)
/// 生成key
+ (NSString*)kj_createKey{
    NSUInteger size = 16;
    char data[size];
    for (int x=0;x<size;x++) {
        int randomint = arc4random_uniform(2);
        if (randomint == 0) {
            data[x] = (char)('a' + (arc4random_uniform(26)));
        }else{
            data[x] = (char)('0' + (arc4random_uniform(9)));
        }
    }
    return [[NSString alloc] initWithBytes:data length:size encoding:NSUTF8StringEncoding];
}
/// 生成token
+ (NSString*)kj_createToken{
    return [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
#pragma mark - rsa
static NSString * base64_encode_data(NSData *data){
    return [[NSString alloc] initWithData:[data base64EncodedDataWithOptions:0] encoding:NSUTF8StringEncoding];
}
- (NSString*(^)(NSString*key))kj_rsaEncryptPublicKey{
    return ^(NSString*key) {
        NSData *data = [NSData kj_rsaencryptData:[self dataUsingEncoding:NSUTF8StringEncoding] publicKey:key];
        return base64_encode_data(data);
    };
}
- (NSString*(^)(NSString *key))kj_rsaDecryptPublicKey{
    return ^(NSString*key) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        return [[NSString alloc] initWithData:[NSData kj_rsadecryptData:data publicKey:key] encoding:NSUTF8StringEncoding];
    };
}
- (NSString*(^)(NSString*key))kj_rsaEncryptPrivateKey{
    return ^(NSString*key) {
        NSData *data = [NSData kj_rsaencryptData:[self dataUsingEncoding:NSUTF8StringEncoding] privateKey:key];
        return base64_encode_data(data);
    };
}
- (NSString*(^)(NSString *key))kj_rsaDecryptPrivateKey{
    return ^(NSString*key) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        return [[NSString alloc] initWithData:[NSData kj_rsadecryptData:data privateKey:key] encoding:NSUTF8StringEncoding];
    };
}

#pragma mark - aes
/// 加密
- (NSString*(^)(NSString *key))kj_aesEncryptKey{
    return ^(NSString*key) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSData *aesData = [data kj_aes128operation:kCCEncrypt key:key];
        return [aesData base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    };
}
/// 解密
- (NSString*(^)(NSString *key))kj_aesDecryptKey{
    return ^(NSString*key) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
        return [[NSString alloc] initWithData:[data kj_aes128operation:kCCDecrypt key:key] encoding:NSUTF8StringEncoding];
    };
}

@end
