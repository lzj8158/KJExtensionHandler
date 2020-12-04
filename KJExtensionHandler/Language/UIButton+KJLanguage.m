//
//  UIButton+KJLanguage.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/2.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIButton+KJLanguage.h"

@implementation UIButton (KJLanguage)
- (NSString*)LocalizedKey{
    return objc_getAssociatedObject(self, @selector(LocalizedKey));;
}
- (void)setLocalizedKey:(NSString*)LocalizedKey{
    objc_setAssociatedObject(self, @selector(LocalizedKey), LocalizedKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (LocalizedKey == nil) return;
    if (NSBundle.customStringsName) {
        [self setTitle:NSLocalizedStringFromTable(LocalizedKey,NSBundle.customStringsName,nil) forState:UIControlStateNormal];
    }else{
        [self setTitle:NSLocalizedString(LocalizedKey, nil) forState:UIControlStateNormal];
    }
}
- (NSString*)HighlightedKey{
    return objc_getAssociatedObject(self, @selector(HighlightedKey));;
}
- (void)setHighlightedKey:(NSString*)HighlightedKey{
    objc_setAssociatedObject(self, @selector(HighlightedKey), HighlightedKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (HighlightedKey == nil) return;
    if (NSBundle.customStringsName) {
        [self setTitle:NSLocalizedStringFromTable(HighlightedKey,NSBundle.customStringsName,nil) forState:UIControlStateHighlighted];
    }else{
        [self setTitle:NSLocalizedString(HighlightedKey, nil) forState:UIControlStateHighlighted];
    }
}
- (NSString*)SelectedKey{
    return objc_getAssociatedObject(self, @selector(SelectedKey));;
}
- (void)setSelectedKey:(NSString*)SelectedKey{
    objc_setAssociatedObject(self, @selector(SelectedKey), SelectedKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (SelectedKey == nil) return;
    if (NSBundle.customStringsName) {
        [self setTitle:NSLocalizedStringFromTable(SelectedKey,NSBundle.customStringsName,nil) forState:UIControlStateSelected];
    }else{
        [self setTitle:NSLocalizedString(SelectedKey, nil) forState:UIControlStateSelected];
    }
}
- (NSString*)DisabledKey{
    return objc_getAssociatedObject(self, @selector(DisabledKey));;
}
- (void)setDisabledKey:(NSString*)DisabledKey{
    objc_setAssociatedObject(self, @selector(DisabledKey), DisabledKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (DisabledKey == nil) return;
    if (NSBundle.customStringsName) {
        [self setTitle:NSLocalizedStringFromTable(DisabledKey,NSBundle.customStringsName,nil) forState:UIControlStateDisabled];
    }else{
        [self setTitle:NSLocalizedString(DisabledKey, nil) forState:UIControlStateDisabled];
    }
}

@end
