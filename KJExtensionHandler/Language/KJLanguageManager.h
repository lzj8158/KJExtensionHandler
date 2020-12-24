//
//  KJLanguageManager.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/21.
//  https://github.com/yangKJ/KJExtensionHandler
//  解决循环导入

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN
static NSString *kAppLanguageKey = @"KJ_CURRENT_LANGUAGE_KEY";
@interface KJLanguageManager : NSBundle
/// 自定义strings文件，默认Localizable.strings
@property(nonatomic,strong,class)NSString *customStringsName;
/// 当前语言
@property(nonatomic,strong,readonly,class)NSString *currentLanguage;

@end

NS_ASSUME_NONNULL_END
