//
//  NSData+KJRSA.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KJRSA)
+ (NSData*)kj_rsadecryptData:(NSData*)data privateKey:(NSString*)key;
+ (NSData*)kj_rsadecryptData:(NSData*)data publicKey:(NSString*)key;
+ (NSData*)kj_rsaencryptData:(NSData*)data publicKey:(NSString*)key;
+ (NSData*)kj_rsaencryptData:(NSData*)data privateKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
