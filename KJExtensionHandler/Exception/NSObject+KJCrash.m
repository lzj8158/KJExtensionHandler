//
//  NSObject+KJCrash.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/18.
//  https://github.com/yangKJ/KJExtensionHandler

#import "NSObject+KJCrash.h"
#import <objc/runtime.h>
@implementation NSObject (KJCrash)
+ (void)kj_openExchangeMethod{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        [NSObject kj_swizzleMethod:@selector(resolveClassMethod:) Method:@selector(kj_resolveClassMethod:)];
//        [NSObject kj_swizzleMethod:@selector(resolveInstanceMethod:) Method:@selector(kj_resolveInstanceMethod:)];
    });
}
//- (void)kj_sayGoodBye{
//    NSLog(@"🎈🎈🎈🎈🎈🎈🎈🎈🎈🎈🎈🎈🎈🎈");
//}
//+ (BOOL)kj_resolveClassMethod:(SEL)sel{
//    BOOL rust;
//    @try {
//        rust = [self kj_resolveClassMethod:sel];
//    }@catch (NSException *exception) {
//        BOOL boo = NO;
//        NSString *string = NSStringFromSelector(sel);
//        unsigned int count;
//        Method *methods = class_copyMethodList([self class], &count);
//        for (int i = 0; i < count; i++) {
//            Method method = methods[i];
//            SEL selector = method_getName(method);
//            NSString *name = NSStringFromSelector(selector);
//            if ([string isEqualToString:name]) {
//                boo = YES;
//                break;
//            }
//        }
//        if (boo == NO) {
//            IMP imp = class_getMethodImplementation(self, @selector(kj_sayGoodBye));
//            Method sayMethod = class_getInstanceMethod(self, @selector(kj_sayGoodBye));
//            const char *type = method_getTypeEncoding(sayMethod);
//            NSString *clazzz = NSStringFromClass([self class]);
//            rust = class_addMethod(objc_getMetaClass((char*)[clazzz UTF8String]), sel, imp, type);
//            [KJExceptionTool kj_crashDealWithException:exception CrashTitle:string];
//        }
//    }@finally {
//        return rust;
//    }
//}

//+ (BOOL)kj_resolveInstanceMethod:(SEL)sel{
//    NSLog(@"%@ 来了", NSStringFromSelector(sel));
//    if (sel == @selector(say888)) {
////        NSLog(@"%@ 来了", NSStringFromSelector(sel));
//        //获取sayGoodBye方法的imp
//        //因为类方法是元类的实例方法所以这里要传入元类
//        IMP imp = class_getMethodImplementation(objc_getMetaClass("TDStudent"), @selector(sayhai));
//        //获取sayGoodBye的实例方法
//        Method sayMethod  = class_getInstanceMethod(objc_getMetaClass("TDStudent"), @selector(sayhai));
//        //获取sayGoodBye的方法签名
//        const char *type = method_getTypeEncoding(sayMethod);
//        //将sel的实现指向sayGoodBye 并加入到方法列表
//        return class_addMethod(objc_getMetaClass("TDStudent"), sel, imp, type);
//    }else if(sel == @selector(say666)){
//        IMP imp = class_getMethodImplementation(self, @selector(sayGoodBye));
//        //获取sayGoodBye的实例方法
//        Method sayMethod  = class_getInstanceMethod(self, @selector(sayGoodBye));
//        //获取sayGoodBye的方法签名
//        const char *type = method_getTypeEncoding(sayMethod);
//        //将sel的实现指向sayGoodBye 并加入到方法列表
//        return class_addMethod(self, sel, imp, type);
//    }
//    return NO;
//}

@end
