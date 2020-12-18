//
//  UILabel+KJCopy.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/18.
//  https://github.com/yangKJ/KJExtensionHandler

#import "UILabel+KJCopy.h"
#import "objc/runtime.h"
@implementation UILabel (KJCopy)
- (BOOL)copyable{
    return [objc_getAssociatedObject(self, @selector(copyable)) boolValue];
}
- (void)setCopyable:(BOOL)copyable{
    objc_setAssociatedObject(self, @selector(copyable), @(copyable), OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}
- (void)attachTapHandler{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:gesture];
}
- (void)handleTap:(UIGestureRecognizer*)recognizer{
    [self becomeFirstResponder];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(kj_copyText)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}
// 复制时执行的方法
- (void)kj_copyText{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    if (objc_getAssociatedObject(self, @"expectedText")) {
        board.string = objc_getAssociatedObject(self, @"expectedText");
    }else{
        if (self.text) {
            board.string = self.text;
        } else {
            board.string = self.attributedText.string;
        }
    }
}
- (BOOL)canBecomeFirstResponder{
    return [objc_getAssociatedObject(self, @selector(copyable)) boolValue];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(kj_copyText));
}

@end
