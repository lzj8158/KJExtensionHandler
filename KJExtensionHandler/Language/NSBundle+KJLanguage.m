//
//  NSBundle+KJLanguage.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/2.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSBundle+KJLanguage.h"

@interface KJLanguageBundle : NSBundle
@end
@implementation KJLanguageBundle
/// 国际化
- (NSString*)localizedStringForKey:(NSString*)key value:(NSString*)value table:(NSString*)tableName{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:NSBundle.currentLanguage ofType:@"lproj"]];
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    }else{
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

@end

@implementation NSBundle (KJLanguage)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 动态继承修改[NSBundle mainBundle]对象的isa指针使其指向子类，便可以调用子类的方法
        object_setClass([NSBundle mainBundle], [KJLanguageBundle class]);
    });
}
+ (NSString*)customStringsName{
    return objc_getAssociatedObject(self, @selector(customStringsName));
}
+ (void)setCustomStringsName:(NSString*)customStringsName{
    objc_setAssociatedObject(self, @selector(customStringsName), customStringsName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static NSString *kAppLanguageKey = @"KJ_CURRENT_LANGUAGE_KEY";
+ (NSString*)currentLanguage{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:kAppLanguageKey];
    if (language == nil) {
        language = [[NSLocale preferredLanguages] firstObject];
    }
    return language;
}
/// 设置语言
+ (void)kj_setCurrentLanguage:(NSString*)language complete:(void(^)(void))complete{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (language) {
        [userDefaults setObject:language forKey:kAppLanguageKey];
    }else{
        [userDefaults removeObjectForKey:kAppLanguageKey];
    }
    [userDefaults synchronize];
    if (complete) complete();
}
/// 切换动画，自带菊花加载界面
+ (void)kj_switchoverLanguage:(UIViewController*(^)(KJLoadLanguageViewController *loadvc))block complete:(void(^)(void))complete{
    if (block) {
        KJLoadLanguageViewController *__vc = [KJLoadLanguageViewController new];
        __vc.time = .5;
        __block UIViewController *vc = block(__vc);
        if (vc) {
            __vc.loadEnd = ^{
                [vc.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[UIButton class]]) {
                        UIButton *button = (UIButton*)obj;
                        button.LocalizedKey = button.LocalizedKey;
                        button.SelectedKey = button.SelectedKey;
                        button.DisabledKey = button.DisabledKey;
                        button.HighlightedKey = button.HighlightedKey;
                    }else if ([obj isKindOfClass:[UILabel class]]) {
                        UILabel *label = (UILabel*)obj;
                        label.LocalizedKey = label.LocalizedKey;
                    }else if ([obj isKindOfClass:[UITextField class]]) {
                        UITextField *textField = (UITextField*)obj;
                        textField.LocalizedKey = textField.LocalizedKey;
                    }
                }];
                if (complete) complete();
            };
            [vc presentViewController:__vc animated:NO completion:nil];
        }
    }
}

@end
