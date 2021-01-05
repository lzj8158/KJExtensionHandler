//
//  KJFPSHandler.m
//  KJExtensionHandler
//
//  Created by 杨科军 on 2019/1/9.
//  https://github.com/yangKJ/KJExtensionHandler

#import "KJFPSHandler.h"

@implementation KJFPSHandler{
    CADisplayLink *_link;
    NSTimeInterval _lastTime;
    float _fps;
    void(^_callback)(float fps);
    NSUInteger _count;
}
+ (instancetype)shareInstance {
    static KJFPSHandler *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

/// fps回调 1秒回调一次
- (void)startMonitor:(void(^)(float fps))callback{
    [self startMonitoring];
    _callback = callback;
}

#pragma mark - monitor fps
- (void)startMonitoring {
    if (_link) {
        [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [_link invalidate];
        _link = nil;
    }
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsDisplayLinkAction:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)fpsDisplayLinkAction:(CADisplayLink*)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    _fps = _count / delta;
    _count = 0;
    if (_callback) _callback(_fps);
}


@end
