# 更新日志

### **[API文档介绍](https://github.com/yangKJ/KJExtensionHandler/wiki/API文档)**

### 本库主要包含几大板块：UIKit类、Foundation类、Language 多语言类、Opencv图片处理类
- UIButton：图文混排、点击事件封装、扩大点击域、时间间隔限制、倒计时、点击粒子效果等
- UIView：手势封装、圆角渐变、Xib属性，基础动画封装等
- UITextView：输入框扩展、限制字数、撤销处理、获取文本内部超链接
- UITextField：占位颜色，线条，图文处理等
- UILabel：富文本，快捷显示文本位置
- UISlider：渐变色滑杆，滑杆点击值修改
- UIImage：截图和裁剪、图片压缩、蒙版处理，图片拼接、图片尺寸处理，滤镜渲染、泛洪算法等
- UIImage：二维码、条形码生成，动态图播放，水印处理等等
- CALayer：投影，倒影，内发光，外发光，内阴影，外阴影等
- UIColor：渐变色，rgba，色相，饱和度等
- Runtime：列表，方法交换，动态继承等
- UIDevice：系统相关属性，
- Language：多语言，支持Xib快捷设置
- Foundation：数组和字典防崩处理，数组算法处理，谓词相关，加密解密等等
- Opencv：图片处理封装，霍夫矫正，特征提取，形态学处理，滤镜处理等等

> 备注：快捷打开浏览器命令，command + shift + 鼠标左键

```
####版本更新日志:
#### Add 1.1.1
1. 新增GCD封装 NSObject+KJGCDBox
2. 新增异步拼接
3. 新增时间分类 NSDate+KJExtension
4. 重写快速创建UI模块
5. 新增Opencv板块 pod 'KJExtensionHandler/opencv'

#### Add 1.1.0
1. 合并分类，解决潜在内存溢出崩溃
2. 新增 UINavigationBar 导航栏管理
3. NSObject+KJRuntime 完善补充
4. NSObject+KJDoraemonBox 新增路由和信号方式解耦

#### Add 1.0.17
1. 删除 CALayer+KJExtension 分类
2. 新增快速创建UI控件，_KJQuickCreateHandle
3. NSObject+KJRuntime 新增协议列表和归档解档方法

#### Add 1.0.15
1. 新增 KJRouterHandler 简单的路由工具(基于URL实现控制器转场的框架)
2. 移除 KJFPSHandler 和 KJShadowLayer，需要去Demo下载
3. NSString 新增字母排序和过滤特殊字符

#### Add 1.0.14
1. UITextField+KJExtension 新增回调 kTextEditingChangedBolck 文本编辑
2. 移除 UIImage+KJReflection 简单的倒影处理

#### Add 1.0.13
1. 新增 NSString+KJSecurity 加密解密工具

#### Add 1.0.12
1. UIDevice+KJSystem 新增启动图相关属性方法
2. UIView+KJFrame 新增子控件处理事件和常用方法
3. 细节优化

#### Add 1.0.11
1. 修改 UITextView 占位符和限制字符，同时支持Xib快捷设置
2. 修改 UITextField 支持Xib设置 bottomLineColor、placeholderColor、maxLength属性 
3. 新增 UILabel+KJCopy 移除拷贝长按手势 kj_removeCopyLongPressGestureRecognizer
4. 修改 UIButton+KJBlocktap 点击时间间隔 timeInterval，支持Xib设置
5. 新增 UIImage+KJMask 椭圆形图片 kj_ellipseImage

#### Add 1.0.10
1. NSArray+KJExtension 新增 kj_insertObject 插入数据到目的位置

#### Add 1.0.9
1. Language 解决循环引入
2. 新增 UIView+KJAnimation 简单动画效果链式封装
3. 新增 KJSoundView 声音大小控件

#### Add 1.0.7
1. 新增 UIImage+KJQRCode 二维码/条形码生成
2. 新增 UIView+KJAnimation 简单动画效果链式封装
3. 新增 UILabel+KJCopy UILabel添加长按复制功能
4. 移除 UIView+Toast

#### Add 1.0.6
1. 重新整理 KJMathEquation 数学方程式类
2. 新增 NSTimer+KJExtension 计时器简单封装
3. 礼物控件提示 KJCallNotifyView

#### Add 1.0.3
1. 新增 NSObject+KJRuntime Runtime轻量级封装
2. 新增 UIImageView+KJBlur 简单的模糊效果

#### Add 1.0.1
1. 新增 UITextField+KJExtension 输入框扩展，快速设置账号密码框
2. 删除不必要代码，简练操作

#### Add 1.0.0
1. 完善 UIButton+KJBlock 去除多枚举和超出九种情况
2. 新增 UIDevice+KJSystem 系统相关方法属性
3. 分离 Exception 异常处理，请使用 pod 'KJExceptionDemo'
4. 新增 Language 模块 pod 'KJExtensionHandler/Language' # 多语言模块

#### Add 0.0.10
1. UIImage+KJGIF 新增播放本地动态图 kj_gifLocalityImageWithName:
2. 提出 KJNodeQueue 栈操作工具
3. 新增 NSObject+KJSemaphore 轻量级解耦工具
4. 完善 UIButton+KJBlock 点击事件封装

#### Add 0.0.9
1. UIImage+KJCompress 新增多种缩放方案
2. UIImage+KJJoint 新增多种图片拼接
3. UIButton+KJButtonContentLayout 修改三个属性layoutType、padding、periphery

#### Add 0.0.8
1. UIImage+KJCapture 截图方法修改，提升截图质量
2. 新增 UIImageView+KJLetters 头像浏览和文字头像
3. 新增 UIScrollView+KJEmptyDataSet 空数据展示
4. 新增 NSObject+KJExtension 动态属性添加

#### Add 0.0.7
1. 重写 UIView+KJGestureBlock 解决手势共存问题
2. UIView+KJRectCorner 完善处理
3. 新增 CALayer+KJExtension 增加标签属性

#### Add 0.0.6
1. 新增 UITabBar+KJBadge 小红点处理
2. 新增 _KJGCD 处理线程相关
3. 重写指示器按钮 UIButton+KJIndicator 
4. 重写点赞粒子效果 kj_buttonSetEmitterImage:OpenEmitter:
5. 重写 UINavigationItem+KJExtension 采用链式处理
6. 新增 UITextView+KJBackout 撤销输入
7. UILabel+KJExtension 新增文本显示位置属性 kTextAlignmentType

#### Add 0.0.5
1. UIView+KJXib 新增判断是否有子视图在滚动 anySubViewScrolling
2. UIView+KJFrame 新增移除所有子视图 kj_removeAllSubviews
3. 新增 NSString+KJChinese 汉字相关操作
4. UIView+KJRectCorner 修改局部边框处理
5. UIView+KJXib 新增设置图片属性 viewImage
6. 新增 UIImage+KJGIF 动态图显示gif
7. 新增 UIImage+KJJoint 拼接图片相关操作

#### Add 0.0.4
1. 新增 UIView+Toast 快捷显示
2. 新增 UIResponder+KJChain 响应链处理
3. 新增 NSObject+KJKVO 键值监听简单封装

#### Add 0.0.3
1. 新增 UIResponder+KJAdapt 简单的比例适配
2. 新增 NSArray+KJPredicate 谓词数组处理
3. 新增 NSString+KJPredicate 谓词字符串处理

#### Add 0.0.2
1. 新增Exception异常处理
2. UITextView 增加是否开启方法交换委托处理

#### Add 0.0.1
1. 从原先的KJEmitterView库中分离出来

备注：部分资料来源于网络～ 就不一一指出道谢，整理起来方便自己和大家使用
```
---

#### <a id="打赏作者"></a>打赏作者
* 如果你觉得有帮助，还请为我Star
* 如果在使用过程中遇到什么问题，希望你能Issues，我会及时修复
* 大家有什么需要添加的功能，也可以给我留言，有空我将补充完善
* 谢谢大家的支持 - -！

[![谢谢老板](https://upload-images.jianshu.io/upload_images/1933747-879572df848f758a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)](https://github.com/yangKJ/KJPlayerDemo)

#### 救救孩子吧，谢谢各位老板～～～～

