//
//  UIImage+KJGIF.h
//  KJExtensionHandler
//
//  Created by 杨科军 on 2020/11/4.
//  来源作者：https://github.com/mayoff/uiimage-from-animated-gif
//  播放动态图

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJGIF)
/// 是否为动态图
@property(nonatomic,assign,readonly) BOOL isGif;
/// 本地动态图播放
+ (UIImage*)kj_gifLocalityImageWithName:(NSString*)name;
/// 本地动图
+ (UIImage*)kj_gifImageWithData:(NSData*)data;
/// 网络动图
+ (UIImage*)kj_gifImageWithURL:(NSURL*)URL;

/// 图片播放，动态图
+ (UIImage*)kj_playImageWithData:(NSData*)data;

/// 子线程处理动态图
void kPlayGifImageData(void(^xxblock)(bool isgif, UIImage * image), NSData *data);

@end

NS_ASSUME_NONNULL_END
