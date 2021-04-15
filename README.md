# KJExtensionHandler 常用工具类
- **这个库主要就是积累平时开发经常使用到的工具，日积月累方便以后开发**

### **[API文档介绍](https://github.com/yangKJ/KJExtensionHandler/wiki/API文档)**

---

## 功能介绍

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

#### Foundation我还整理封装异常处理Crash防护 [KJExceptionDemo](https://github.com/yangKJ/KJExceptionDemo)
### <a id="效果图"></a>
<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-5cccc7ddb754fef5.gif?imageMogr2/auto-orient/strip" width="200" hspace="1px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-ee290038a762cac4.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="30px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-eb62f6e462505d69.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-b5c171bee7c7bae5.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f1a37cede69d462aab85ff1486aa5fd4~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="30px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-a2dc9062541cf24c.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-ec3102711073b390.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-4a4811a1bf4a09d2.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="30px">
<img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2cc5f05dd18740bdad9170d962ba6404~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-eaca7b4e368efb93.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-f75249465cc14d81.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="30px">
<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ab1490fb049346d4a4a690a689916e11~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/be86b64dac0b4bb4ae393f2b17d732a6~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="1px">
<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0d0e31ce4c324bfebc12500608335c2c~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="30px">
<img src="https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/de85289ad3574a0cb101446249d800e4~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="1px">
</p>

### <a id="Cocoapods安装"></a>Cocoapods安装
```
pod 'KJExtensionHandler'
pod 'KJExtensionHandler/Foundation'
pod 'KJExtensionHandler/Language' 
pod 'KJExtensionHandler/Opencv'
```

---

### <a id="打赏作者"></a>打赏作者
* 如果你觉得有帮助，还请为我Star
* 如果在使用过程中遇到什么问题，希望你能Issues，我会及时修复
* 大家有什么需要添加的功能，也可以给我留言，有空我将补充完善
* 谢谢大家的支持 - -！

[![谢谢老板](https://upload-images.jianshu.io/upload_images/1933747-879572df848f758a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)](https://github.com/yangKJ/KJPlayerDemo)

#### 救救孩子吧，谢谢各位老板～～～～

