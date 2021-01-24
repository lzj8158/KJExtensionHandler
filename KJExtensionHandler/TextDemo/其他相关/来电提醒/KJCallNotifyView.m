//
//  KJCallNotifyView.m
//  Melinked
//
//  Created by 杨科军 on 2020/12/15.
//  Copyright © 2020 Melinked. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler

#import "KJCallNotifyView.h"
#import "NSTimer+KJExtension.h"
@interface KJCallView : UIView
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *tvImageView;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)KJCallNotifyInfo *info;
- (instancetype)kj_initWithFrame:(CGRect)frame Name:(NSString*)name;
@end
@interface KJCallNotifyView ()
@property(nonatomic,strong)NSMutableArray<KJCallNotifyInfo*>*temps;
@property(nonatomic,copy,readwrite)void (^tapblock)(KJCallNotifyInfo *info);
@property(nonatomic,assign)NSInteger displayCount;
@property(nonatomic,strong)NSMutableArray<KJCallView*>*viewTemps;
@end
@implementation KJCallNotifyView
static KJCallNotifyView *_instance = nil;
+ (instancetype)kj_shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[KJCallNotifyView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
            [kKeyWindow addSubview:_instance];
            
        }
    });
    return _instance;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.maxCount = 3;
        self.vanishTime = 5.;
    }
    return self;
}
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event{
    UIView *view = [self kj_childHitTest:point withEvent:event];
    if (view) return view;
    return nil;
}
/// 点击事件
- (void)kj_tapBlock:(void(^)(KJCallNotifyInfo *info))block{
    self.tapblock = block;
}
/// 添加来电消息，重复条件默认根据 userid 判断
- (void)kj_addCallNotify:(void(^)(KJCallNotifyInfo *))block RepetitionCondition:(bool(^_Nullable)(KJCallNotifyInfo *))condition{
    KJCallNotifyInfo *info = [KJCallNotifyInfo new];
    if (block) block(info);
    if (self.repetition == NO) {
        __block bool skip = false;
        if (condition) {
            for (KJCallNotifyInfo *_info in self.temps) {
                skip = condition(_info);
                if (skip) break;
            }
        }else{
            [self.temps enumerateObjectsUsingBlock:^(KJCallNotifyInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([info.userid isEqualToString:obj.userid]) {
                    skip = true;*stop = YES;
                }
            }];
        }
        if (skip) return;
        [self.temps addObject:info];
    }
    @synchronized (@(self.displayCount)) {
        self.displayCount++;
        KJCallView *view = [self kj_viewIndex:self.displayCount Info:info];
        [self.viewTemps addObject:view];
        [self addSubview:view];
        if (self.displayCount > self.maxCount) {
            KJCallView *fristView = self.viewTemps.firstObject;
            [self kj_autoVanish:fristView];
            [self kj_displayEnd:fristView];
        }
    }
}
/// 显示结束
- (void)kj_displayEnd:(KJCallView*)view{
    [NSTimer kj_invalidateTimer:view.timer];
    [self.viewTemps removeObject:view];
    if (self.repetition == NO) {
        [self.temps removeObject:view.info];
    }
    @synchronized (@(self.displayCount)) {
        self.displayCount--;
    }
}
- (KJCallView*)kj_viewIndex:(NSInteger)index Info:(KJCallNotifyInfo*)info{
    CGFloat y = kAutoH(17) + (index-1) * kAutoH(58) + kSTATUSBAR_HEIGHT - 20;
    __block KJCallView *view = [[KJCallView alloc]kj_initWithFrame:CGRectMake(0, y, kAutoW(170), kAutoH(48)) Name:info.name];
    view.tag = 520 + index - 1;
    view.info = info;
    view.imageView.image = [UIImage imageNamed:info.imageUrl];
    _weakself;
    void (^kRemove)(bool tapX) = ^(bool tapX){
        if (tapX) {
            [weakself kj_vanish:view];
        }else{
            [weakself kj_autoVanish:view];
        }
        [weakself kj_displayEnd:view];
    };
    [view kj_AddTapGestureRecognizerBlock:^(UIView * _Nonnull __view, UIGestureRecognizer * _Nonnull gesture) {
        if (weakself.tapblock) {
            weakself.tapblock(view.info);
            if (weakself.tapVanish) {
                [__view removeGestureRecognizer:gesture];
                [weakself kj_vanish:view];
                [weakself kj_displayEnd:view];
            }
        }
    }];
    [view.button kj_addAction:^(UIButton * _Nonnull kButton) {
        kRemove(true);
    }];
    view.timer = [NSTimer kj_scheduledTimerWithTimeInterval:self.vanishTime Repeats:NO Block:^(NSTimer * _Nonnull timer) {
        kRemove(false);
    }];
    [[NSRunLoop mainRunLoop] addTimer:view.timer forMode:NSRunLoopCommonModes];
    return view;
}
/// 自动消失动画
- (void)kj_autoVanish:(KJCallView*)view{
    [UIView animateWithDuration:.5 animations:^{
        [self kj_changeIndex:0 Y:-view.height];
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}
/// 点叉消失动画
- (void)kj_vanish:(KJCallView*)view{
    [UIView animateWithDuration:.5 animations:^{
        view.hidden = 0;
        if (view.tag == 520) {
            [self kj_changeIndex:0 Y:-kAutoH(48)];
        }else{
            [self kj_changeIndex:view.tag-520 Y:view.y];
        }
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}
- (void)kj_changeIndex:(NSInteger)index Y:(CGFloat)y{
    KJCallView *view = self.viewTemps[index];
    view.tag = 520 + index - 1;
    CGFloat xy = view.y;view.y = y;
    if (index+1<self.viewTemps.count) [self kj_changeIndex:index+1 Y:xy];
}
#pragma mark - lazy
- (NSMutableArray<KJCallNotifyInfo *> *)temps{
    if (!_temps) {
        _temps = [NSMutableArray array];
    }
    return _temps;
}
- (NSMutableArray<KJCallView *> *)viewTemps{
    if (!_viewTemps) {
        _viewTemps = [NSMutableArray array];
    }
    return _viewTemps;
}

@end
@implementation KJCallNotifyInfo
@end
@implementation KJCallView
- (instancetype)kj_initWithFrame:(CGRect)frame Name:(NSString*)name{
    if (self==[super initWithFrame:frame]) {
        self.centerX = kScreenW/2;
        self.backgroundColor = UIColor.whiteColor;
        self.cornerRadius = kAutoH(48)/2;
        self.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.16];
        self.shadowOffset = CGSizeMake(0,3);
        self.shadowRadius = 6;
        self.shadowOpacity = 1;
        CGFloat height = self.height;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, height-10, height-10)];
        self.imageView.cornerRadius = (height-10)/2;
        [self addSubview:self.imageView];
        self.button = [UIButton kj_createButton:^(id<KJQuickCreateHandle>  _Nonnull handle) {
            handle.kj_frame(self.width-18-8, 0, 18, 18).kj_add(self);
            handle.kj_image([UIImage imageNamed:@"xxx"]).kj_font([UIFont systemFontOfSize:14]).kj_textColor(UIColor.blackColor);
        }];
        self.button.centerY = self.height/2;
        self.label = [UILabel kj_createLabel:^(id<KJQuickCreateHandle>  _Nonnull handle) {
            handle.kj_add(self);
            handle.kj_text(name).kj_font([UIFont fontWithName:@"PingFang SC" size:14]);
            handle.kj_textColor([UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]);
        }];
        CGFloat width = [self.label kj_calculateWidth];
        CGFloat maxw = self.button.x - self.imageView.maxX - 10 - 23 - 10;
        if (width>=maxw) width = maxw;
        self.label.frame = CGRectMake(self.imageView.maxX+10, 0, width, self.height);
        self.tvImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.label.maxX+2.5, 0, 23, 22)];
        self.tvImageView.image = kGetImage(@"wode_nor");
        self.tvImageView.centerY = self.height/2;
        [self addSubview:self.tvImageView];
    }
    return self;
}

@end
