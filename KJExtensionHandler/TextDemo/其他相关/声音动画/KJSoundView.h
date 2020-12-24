//
//  KJSoundView.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/12/22.
//  https://github.com/yangKJ/KJExtensionHandler
//  音量大小控件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJSoundView : UIView
/// 最大值，默认100
@property(nonatomic,assign)CGFloat maxValue;
/// 最小值，默认0
@property(nonatomic,assign)CGFloat minValue;
/// 当前进度
@property(nonatomic,assign)CGFloat value;
/// 声波颜色，默认绿色
@property(nonatomic,strong)UIColor *soundColor;
/// 声波背景颜色，默认白色
@property(nonatomic,strong)UIColor *soundBackColor;

@end

NS_ASSUME_NONNULL_END
