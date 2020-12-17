//
//  KJCallNotifyView.h
//  Melinked
//
//  Created by 杨科军 on 2020/12/15.
//  Copyright © 2020 Melinked. All rights reserved.
//  来电提醒界面

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class KJCallNotifyInfo;
@interface KJCallNotifyView : UIView
/// 最大显示个数，默认3个
@property(nonatomic,assign)NSInteger maxCount;
/// 自动消失时间，默认5s
@property(nonatomic,assign)CGFloat vanishTime;
/// 是否允许重复显示，默认NO
@property(nonatomic,assign)BOOL repetition;
/// 点击控件是否消失，默认NO
@property(nonatomic,assign)BOOL tapVanish;
/// 创建单例
+ (instancetype)kj_shareInstance;
/// 添加来电消息
- (void)kj_addCallNotify:(void(^)(KJCallNotifyInfo *info))block;
/// 点击事件
- (void)kj_tapBlock:(void(^)(KJCallNotifyInfo *info))block;
@end
@interface KJCallNotifyInfo : NSObject
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *userid;
@end
NS_ASSUME_NONNULL_END
