//
//  UIView+KJFrame.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/yangKJ/KJExtensionHandler
//  轻量级布局

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (KJFrame)
/// 使用Masonry布局之后得到尺寸
@property(nonatomic,assign)CGFloat masonry_x;
@property(nonatomic,assign)CGFloat masonry_y;
@property(nonatomic,assign)CGFloat masonry_width;
@property(nonatomic,assign)CGFloat masonry_height;

@property(nonatomic,assign)CGSize  size;// 大小
@property(nonatomic,assign)CGPoint origin;// 位置
@property(nonatomic,assign)CGFloat x;// x坐标
@property(nonatomic,assign)CGFloat y;// y坐标
@property(nonatomic,assign)CGFloat width;// 宽度
@property(nonatomic,assign)CGFloat height;// 高度
@property(nonatomic,assign)CGFloat centerX;// 中心点x
@property(nonatomic,assign)CGFloat centerY;// 中心点y
@property(nonatomic,assign)CGFloat left;// 左边距离
@property(nonatomic,assign)CGFloat right;// 右边距离
@property(nonatomic,assign)CGFloat top;// 顶部距离
@property(nonatomic,assign)CGFloat bottom;// 底部距离
@property(nonatomic,assign,readonly)CGFloat maxX;// x + width
@property(nonatomic,assign,readonly)CGFloat maxY;// y + height

/// 将视图中心置于其父视图，支持旋转方向后处理
- (void)kj_centerToSuperview;
/// 距父视图右边距离
- (void)kj_rightToSuperview:(CGFloat)right;
/// 距父视图下边距离
- (void)kj_bottomToSuperview:(CGFloat)bottom;
/// 获取子视图的最高Y
- (CGFloat)kj_subviewMaxY;
/// 获取子视图的最高X
- (CGFloat)kj_subviewMaxX;

/// 寻找子视图
- (UIView*)kj_FindSubviewRecursively:(BOOL(^)(UIView *subview, BOOL * stop))recurse;
/// 移除所有子视图
- (void)kj_removeAllSubviews;
/// 隐藏/显示所有子视图
- (void)kj_hideSubviews:(BOOL)hide operation:(BOOL(^)(UIView *subview))operation;
/// 子控件处理手势事件
- (UIView*)kj_childHitTest:(CGPoint)point withEvent:(UIEvent*)event;

/// Xib创建的View
+ (instancetype)kj_viewFromXib;
UIView * kViewFromXib(void);
/// Xib创建的View
+ (instancetype)kj_viewFromXibWithFrame:(CGRect)frame;
UIView * kViewXibWithFrame(CGRect frame);

/// 当前的控制器
- (UIViewController*)kj_currentViewController;
@property(nonatomic,strong,readonly)UIViewController *viewController;

/// 判断一个控件是否真正显示在主窗口
- (BOOL)kj_isShowingOnKeyWindow;
@property(nonatomic,assign,readonly) BOOL showKeyWindow;
/// 判断是否有子视图在滚动
- (BOOL)kj_anySubViewScrolling;
@property(nonatomic,assign,readonly) BOOL anySubViewScrolling;

@end

NS_ASSUME_NONNULL_END
