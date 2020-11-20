//
//  NSObject+KJKVO.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/29.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJKVO.h"
#import <objc/runtime.h>
@implementation NSObject (KJKVO)
- (void)kj_kvo_dealloc{
    if (self.kObserveDictionary) {
        for (NSString *keyPath in self.kObserveDictionary.allKeys) {
            [self removeObserver:self forKeyPath:keyPath];
        }
        self.kObserveDictionary = nil;
    }
    [self kj_kvo_dealloc];
}
- (NSMutableDictionary*)kObserveDictionary{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, @selector(kObserveDictionary));
    if (dict == nil) dict = [NSMutableDictionary dictionary];
    return dict;
}
- (void)setKObserveDictionary:(NSMutableDictionary*)kObserveDictionary{
    objc_setAssociatedObject(self, @selector(kObserveDictionary), kObserveDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public
- (void)kj_observeKey:(NSString*)keyPath ObserveResultBlock:(kObserveResultBlock)block{
    if (keyPath.length < 1 || [keyPath containsString:@"."]) return;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kj_swizzleMethod([self class], NSSelectorFromString(@"dealloc"), @selector(kj_kvo_dealloc));
    });
    [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:(__bridge_retained void *)([block copy])];
    [self.kObserveDictionary setValue:block forKey:keyPath];
}
#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (object == self) {
        kObserveResultBlock handler = (__bridge kObserveResultBlock)context;
        handler(change[@"new"],change[@"old"]);
    }
}

#pragma mark - Private
static void kj_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
