//
//  NSData+KJAES.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/5.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSData (KJAES)
- (NSData*)kj_aes128operation:(CCOperation)operation key:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
