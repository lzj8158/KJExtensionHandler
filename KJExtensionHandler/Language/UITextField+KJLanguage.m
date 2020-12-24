//
//  UITextField+KJLanguage.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/2.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UITextField+KJLanguage.h"
#import "KJLanguageManager.h"
@implementation UITextField (KJLanguage)
- (NSString*)LocalizedKey{
    return objc_getAssociatedObject(self, @selector(LocalizedKey));;
}
- (void)setLocalizedKey:(NSString*)LocalizedKey{
    objc_setAssociatedObject(self, @selector(LocalizedKey), LocalizedKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (LocalizedKey == nil) return;
    if (KJLanguageManager.customStringsName) {
        self.placeholder = NSLocalizedStringFromTable(LocalizedKey,KJLanguageManager.customStringsName,nil);
    }else{
        self.placeholder = NSLocalizedString(LocalizedKey, nil);
    }
}

@end
