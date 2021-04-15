//
//  UIViewController+KJFullScreen.m
//  Winpower
//
//  Created by 杨科军 on 2019/10/10.
//  Copyright © 2019 cq. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UIViewController+KJFullScreen.h"
#import <objc/runtime.h>

@implementation UIViewController (KJFullScreen)
//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL originalSelector = @selector(presentViewController:animated:completion:);
//        SEL swizzledSelector = @selector(kj_presentViewController:animated:completion:);
//        Class class = [self class];
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        }else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}
//- (void)kj_presentViewController:(UIViewController*)vc animated:(BOOL)animated completion:(void(^)(void))completion{
//    if (@available(iOS 13.0, *)) {
//        if (![vc isKindOfClass:[UISearchController class]]) {
//            vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        }
//    }
//    [self kj_presentViewController:vc animated:animated completion:completion];
//}
/// 顶部控制器
+ (UIViewController*)topViewController{
    UIViewController *result = nil;
    UIWindow *window = ({
        UIWindow *window;
        if (@available(iOS 13.0, *)) {
            window = [UIApplication sharedApplication].windows.firstObject;
        }else{
            window = [UIApplication sharedApplication].keyWindow;
        }
        window;
    });
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    if ([vc isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)vc;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result = nav.childViewControllers.lastObject;
    }else if ([vc isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)vc;
        result = nav.childViewControllers.lastObject;
    }else{
        result = vc;
    }
    return result;
}
/// 跳转回指定控制器
- (BOOL)kj_popTargetViewController:(Class)clazz block:(void(^)(UIViewController *vc))block{
    UIViewController *vc = nil;
    for (UIViewController *__vc in self.navigationController.viewControllers) {
        if ([__vc isKindOfClass:clazz]) {
            vc = __vc;
            break;
        }
    }
    if (vc == nil) return NO;
    [self.navigationController popToViewController:vc animated:YES];
    if (block) block(vc);
    return YES;
}
/* 完美解决NavigationBar隐藏/显示 */
- (void)navigationController:(UINavigationController*)navigationController willShowViewController:(UIViewController*)viewController animated:(BOOL)animated {
    if (viewController == self){
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        if ([navigationController isKindOfClass:[UIImagePickerController class]]) {
            return;
        }
        [navigationController setNavigationBarHidden:NO animated:YES];
        if (navigationController.delegate == self){
            navigationController.delegate = nil;
        }
    }
}
/// 切换根视图控制器
- (void)kj_changeRootViewController:(void(^)(BOOL success))complete{
    UIWindow *window = ({
        UIWindow *window;
        if (@available(iOS 13.0, *)) {
            window = [UIApplication sharedApplication].windows.firstObject;
        }else{
            window = [UIApplication sharedApplication].keyWindow;
        }
        window;
    });
    [UIView transitionWithView:window duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = self;
        [UIView setAnimationsEnabled:oldState];
    }completion:^(BOOL finished) {
        if (complete) complete(finished);
    }];
}
/// 系统自带分享
- (UIActivityViewController*)kj_shareActivityWithItems:(NSArray*)items complete:(void(^)(BOOL success))complete{
    if (items.count == 0) return nil;
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    if (@available(iOS 11.0, *)) {
        vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypeOpenInIBooks, UIActivityTypeMarkupAsPDF];
    }else if (@available(iOS 9.0, *)) {
        vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypeOpenInIBooks];
    }else{
        vc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeMail];
    }
    UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType activityType, BOOL completed, NSArray * returnedItems, NSError * activityError) {
        if (complete) complete(completed);
    };
    vc.completionWithItemsHandler = itemsBlock;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        vc.popoverPresentationController.sourceView = self.view;
        vc.popoverPresentationController.sourceRect = CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height, 0, 0);
    }
    [self presentViewController:vc animated:YES completion:nil];
    return vc;
}

@end
