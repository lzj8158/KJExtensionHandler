//
//  NSDate+KJExtension.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/16.
//  https://github.com/yangKJ/KJExtensionHandler

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (KJExtension)
/* 判断两个日期是否在同一周 */
- (BOOL)kj_sameDate:(NSDate*)date;

@end

NS_ASSUME_NONNULL_END
