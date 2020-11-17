//
//  NSString+KJChinese.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  https://github.com/yangKJ/KJExtensionHandler
//  汉字相关处理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJChinese)
/// 汉字转拼音
@property(nonatomic,strong,readonly)NSString *pinYin;
/// 随机汉字
+ (NSString*)kj_randomCreateChinese:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
