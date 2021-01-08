//
//  NSData+KJBase64.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2021/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KJBase64)
- (NSString*)kj_base64EncodedString;

@end

NS_ASSUME_NONNULL_END
