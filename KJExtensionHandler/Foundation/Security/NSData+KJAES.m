//
//  NSData+KJAES.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/5.
//

#import "NSData+KJAES.h"

@implementation NSData (KJAES)
- (NSData*)kj_aes128operation:(CCOperation)operation key:(NSString*)key{
    char keyPtr[kCCKeySizeAES128 + 1];  //kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t bufferSize = [self length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES,
                                            kCCOptionPKCS7Padding | kCCOptionECBMode,
                                            keyPtr, kCCKeySizeAES128, NULL,
                                            [self bytes], [self length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    if (cryptorStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    if (buffer) free(buffer);
    return nil;
}

@end
