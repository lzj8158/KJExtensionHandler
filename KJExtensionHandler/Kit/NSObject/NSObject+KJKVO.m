//
//  NSObject+KJKVO.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/10/29.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJKVO.h"
#import <objc/runtime.h>
@implementation NSObject (KJKVO)
/// kvo监听
- (void)kj_observeKey:(NSString*)keyPath ObserveResultBlock:(KJObserveResultBlock)block{
    if (keyPath.length < 1 || [keyPath containsString:@"."]) return;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = NSSelectorFromString(@"dealloc");
        SEL swizzledSelector = @selector(kj_kvo_dealloc);
        Method originalMethod = class_getInstanceMethod(self.class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self.class, swizzledSelector);
        if (class_addMethod(self.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
            class_replaceMethod(self.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    self.usekvo = YES;
    [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:(__bridge_retained void *)([block copy])];
    [self.kObserveDictionary setValue:block forKey:keyPath];
}
- (void)kj_kvo_dealloc{
    if (self.usekvo == NO) {
        [self kj_kvo_dealloc];
        return;
    }
    if (self.kObserveDictionary) {
        for (NSString *keyPath in self.kObserveDictionary.allKeys) {
            [self removeObserver:self forKeyPath:keyPath];
        }
        self.kObserveDictionary = nil;
    }
    [self kj_kvo_dealloc];
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (object == self) {
        KJObserveResultBlock handler = (__bridge KJObserveResultBlock)context;
        handler(change[@"new"],change[@"old"]);
    }
}

#pragma mark - associated
- (BOOL)usekvo{
    return [objc_getAssociatedObject(self, @selector(usekvo)) intValue];
}
- (void)setUsekvo:(BOOL)usekvo{
    objc_setAssociatedObject(self, @selector(usekvo), @(usekvo), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSMutableDictionary*)kObserveDictionary{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, @selector(kObserveDictionary));
    if (dict == nil) dict = [NSMutableDictionary dictionary];
    return dict;
}
- (void)setKObserveDictionary:(NSMutableDictionary*)kObserveDictionary{
    objc_setAssociatedObject(self, @selector(kObserveDictionary), kObserveDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
