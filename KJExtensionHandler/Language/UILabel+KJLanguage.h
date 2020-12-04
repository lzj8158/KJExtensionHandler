//
//  UILabel+KJLanguage.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/2.
//  https://github.com/yangKJ/KJExtensionHandler

#import <UIKit/UIKit.h>
#import "NSBundle+KJLanguage.h"
NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface UILabel (KJLanguage)
@property(nonatomic,strong)IBInspectable NSString *LocalizedKey;

@end

NS_ASSUME_NONNULL_END
