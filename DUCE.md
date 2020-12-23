# KJExtensionHandler

#### 本库主要包含三大块：UIKit类、Foundation类、Language 多语言类
- UIButton：图文混排、点击事件封装、扩大点击域、时间间隔限制、倒计时、点击粒子效果等
- UIView：手势封装、圆角渐变、Xib属性（圆角边框阴影）
- UITextView：输入框扩展、限制字数、撤销处理、获取文本内部超链接
- UILabel：富文本，快捷显示文本位置
- UISlider：渐变色滑杆，滑杆点击值修改
- UIImage：截图和裁剪、图片压缩、蒙版处理，图片拼接、图片尺寸处理，滤镜渲染、泛洪算法等
- CALayer：投影，倒影，内发光，外发光，内阴影，外阴影等
- Language：多语言，支持Xib快捷设置
- Foundation：数组和字典防崩处理，数组算法处理，谓词相关等等

## 框架API & Property介绍
- **[NSArray](#NSArray)**
- **[更新日志](#更新日志)**

### <a id="UIColor"></a>UIColor
#### UIColor+KJExtension  颜色相关扩展
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 渐变颜色 | Class | zj_gradientColorWithColors:GradientType:Size: |
| 竖直渐变颜色 | Instance | kj_gradientVerticalToColor:Height: |
| 横向渐变颜色 | Instance | kj_gradientAcrossToColor:Width: |
| 生成附带边框的渐变色图片 | Class | kj_colorImageWithColors:locations: size:borderWidth:borderColor: |
| UIColor转16进制字符串 | Class | kj_hexStringFromColor: |
| 16进制字符串转UIColor | Class | kj_colorWithHexString: |
| 获取图片上指定点的颜色 | Class | kj_colorAtImage:Point: |
| 获取ImageView上指定点的图片颜色 | Class | kj_colorAtImageView:Point: |

#### UIColor+KJExtension2  颜色相关扩展
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
|  | Property | red |
|  | Property | green |
|  | Property | blue |
|  | Property | alpha |
| 色相 -π ~ π | Property | hue |
| 饱和度 0 ~ 1 | Property | saturation |
| 亮度 0 ~ 1 | Property | light |
| 获取颜色对应的RGBA | Instance | kj_colorGetRGBA |
| 获取颜色对应的色相饱和度和透明度 | Instance | kj_colorGetHSL |
| 获取颜色的均值 | Class | kj_averageColors: |

### <a id="UIButton"></a>UIButton
#### UIButton+KJBlock  点击事件ButtonBlock
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 添加点击事件，默认UIControlEventTouchUpInside | Instance | kj_addAction: |
| 添加事件，不支持多枚举形式 | Instance | kj_addAction:forControlEvents: |
| 接受点击事件的时间间隔 | Property | kj_AcceptEventTime |
| 接受点击事件执行处理之后的时间间隔 | Property | kj_AcceptDealTime |

#### UIButton+KJContentLayout  图文混排（支持XIB显示）
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 图文样式 | Property | layoutType |
| 图文间距，默认为0px | Property | padding |
| 图文边界的间距，默认为5px | Property | periphery |
| 图文样式 | Property | kj_ButtonContentLayoutType |
| 图文间距 | Property | kj_Padding |
| 图文边界的间距 | Property | kj_PaddingInset |

#### UIButton+KJCountDown  倒计时
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 倒计时结束的回调 | Property | kButtonCountDownStop |
| 设置倒计时的间隔和倒计时文案，默认为 @"%zd秒" | Instance | kj_startTime:CountDownFormat: |
| 取消倒计时 | Instance | kj_cancelTimer |

#### UIButton+KJCreate  按钮快速创建
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 创建图片按钮 | Class | kj_createButtonWithImageName: |
| 创建图片按钮 | Class | kj_createButtonWithImageName:SelectImageName: |
| 创建文本按钮 | Class | kj_createButtonWithFontSize:Title:TextColor: |
| 创建文本按钮 | Class | kj_createButtonWithFontSize:Title:TextColor:SelectTitle:SelectTextColor: |
| 创建图文按钮 | Class | kj_createButtonWithImageName:Title:FontSize:TextColor: |

#### UIButton+KJEmitter  按钮粒子效果
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 是否开启粒子效果 | Property | openEmitter |
| 粒子，备注 name 属性不要更改 | Property | emitterCell |
| 设置粒子效果 | Instance | kj_buttonSetEmitterImage:OpenEmitter: |

#### UIButton+KJEnlarge  改变UIButton的响应区域 - 扩大Button点击域
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 设置按钮额外热区 | Property | touchAreaInsets |
| 扩大点击域 | Instance | kj_EnlargeEdgeWithTop:right:bottom:left: |

#### UIButton+KJIndicator  指示器(系统自带菊花)
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 按钮是否正在提交中 | Property | submitting |
| 指示器和文字间隔，默认5px | Property | indicatorSpace |
| 指示器颜色，默认白色 | Property | indicatorType |
| 开始提交，指示器跟随文字 | Instance | kj_beginSubmitting: |
| 结束提交 | Instance | kj_endSubmitting |
| 显示指示器 | Instance | kj_showIndicator |
| 隐藏指示器 | Instance | kj_hideIndicator |

### <a id="UICollectionView"></a>UICollectionView
#### UICollectionView+KJTouch  获取touch事件处理
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 开启方法交换 | Property | kOpenExchange |
| Touch里面移动回调，需要开启方法交换才处理 | Property | moveblock |

### <a id="UIBezierPath"></a>UIBezierPath
#### UIBezierPath+KJPoints  获取贝塞尔曲线上面的点
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 获取所有点 | Property | points |
| 获取文字贝塞尔路径 | Class | kj_bezierPathWithText:Font: |

### <a id="NSObject"></a>NSObject
#### KJGeometry  几何方程式相关
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 已知A、B两点和C点到B点的长度，求垂直AB的C点 | Class | kj_perpendicularLineDotsWithA:B:Len:Positive: |
| 已知A、B两点和C点到B点的长度，求垂直AB的C点 | Class | kj_perpendicularLineDotsWithA:B:Length: |
| 已知A、B、C、D 4个点，求AB与CD交点  备注：重合和平行返回（0,0） | Class | kj_linellaeCrosspointWithA:B:C:D: |
| 求两点线段长度 | Class | kj_distanceBetweenPointsWithA:B: |
| 已知A、B、C三个点，求AB线对应C的平行线上的点  y = kx + b |  | kj_parallelLineDotsWithA:B:C: |
| 椭圆求点方程 | Class | kj_ovalPointWithRect:Angle: |

#### KJMathEquation  数学算法方程式
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 把弧度转换成角度 | Class | kj_degreeFromRadian: |
| 把角度转换成弧度 | Class | kj_radianFromDegree: |
| 正切函数的弧度值，tan | Class | kj_radianValueFromTanSideA:sideB: |
| 获取具有固定宽度的新size | Class | kj_resetFromSize:FixedWidth: |
| 获取具有固定高度的新size | Class | kj_resetFromSize:FixedHeight: |
| 一元一次线性方程，求k，b | Class | kj_mathOnceLinearEquationWithPointA:PointB: |
| 已知y，k，b 求 x | Class | kj_xValueWithY:LinearEquation: |
| 已知x，k，b 求 y | Class | kj_yValueWithX:LinearEquation: |

#### NSObject+KJKVO  键值监听封装，自动释放
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| kvo监听 | Instance | kj_observeKey:ObserveResultBlock: |

#### NSObject+KJRuntime  Runtime轻量级封装
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 获取该对象的所有属性，包含父类 | Property | propertyTemps |
| 获取该对象的所有实例变量 | Property | ivarTemps |
| 获取该对象的所有方法 | Property | methodTemps |

#### NSObject+KJSemaphore  轻量级解耦工具（信号）
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 发送消息处理 | Instance | kj_sendSemaphoreWithKey:Message:Parameter: |
| 接收消息处理 | Instance | kj_receivedSemaphoreBlock: |
| 代码执行时间处理，block当中执行代码 | Class | kj_executeTime: |

### <a id="NSArray"></a>NSArray
#### NSArray+KJPredicate  谓词工具
|   功能   |  C \ I \ P  |  API & Property  | 
|  ----  | :----: | ----  |
| 对比两个数组删除相同元素并合并 | Instance | kj_mergeArrayAndDelEqualObjWithOtherArray: |
| 过滤数组 | Instance | kj_filtrationDatasWithPredicateBlock: |
| 除去数组当中包含目标数组的数据 | Instance | kj_delEqualDatasWithTargetTemps: |
| 按照某一属性的升序降序排列 | Instance | kj_sortDescriptorWithKey:Ascending: |
| 按照某些属性的升序降序排列 | Instance | kj_sortDescriptorWithKeys:Ascendings: |
| 取出 key 中匹配 value 的元素 | Instance | kj_takeOutDatasWithKey:Value: |
| 字符串比较运算符 | Instance | kj_takeOutDatasWithOperator:Key:Value: |

#### NSArray+KJExtension  对数组里面元素的相关处理
|  功能   |  C \ I \ P  | API & Property |
|  ----  | :----: | ----  |
| 是否为空 | Property | isEmpty |
| 筛选数据 | Instance | kj_detectArray: |
| 多维数组筛选数据 | Instance | kj_detectManyDimensionArray: |
| 查找数据，返回-1表示未查询到 | Instance | kj_searchObject: |
| 映射 | Instance | kj_mapArray: |
| 数组计算交集 | Instance | kj_arrayIntersectionWithOtherArray: |
| 数组计算差集 | Instance | kj_arrayMinusWithOtherArray: |
| 随机打乱数组 | Instance | kj_disorganizeArray |
| 删除数组当中的相同元素 | Instance | kj_delArrayEquelObj |
| 生成一组不重复的随机数 | Instance | kj_noRepeatRandomArrayWithMinNum:maxNum:count: |
| 二分查找 | Instance | kj_binarySearchTarget: |
| 冒泡排序 | Instance | kj_bubbleSort |
| 插入排序 | Instance | kj_insertSort |
| 选择排序 | Instance | kj_selectionSort |

###  <a id="NSDictionary"></a>NSDictionary
#### NSDictionary+KJExtension  
|  功能   |  C \ I \ P  | API & Property |
|  ----  | :----: | ----  |
| 是否为空 | Property | isEmpty |
| 转换为Josn字符串 | Property | jsonString |

###  <a id="NSString"></a>NSString
#### NSString+KJExtension  字符串扩展属性
|  功能   |  C \ I \ P | API & Property |
|  ----  | :----: | ----  |
| 是否为空 | Property | isEmpty |
| 转换为URL | Property | URL |
| 获取图片 | Property | image |
| 取出HTML | Property | HTMLString |
| Josn字符串转字典 | Property | jsonDict |
| 生成竖直文字 | Property | verticalText |
| 获取文本宽度 | Instance | kj_maxWidthWithFont:Height:Alignment:LinebreakMode:LineSpace: |
| 获取文本高度 | Instance | kj_maxHeightWithFont:Width:Alignment:LinebreakMode:LineSpace: |
| 文字转图片 | Instance | kj_textBecomeImageWithSize:BackgroundColor:TextAttributes: |

#### NSString+KJChinese  汉字相关处理
|  功能   |  C \ I \ P  | API & Property |
|  ----  | :----: | ----  |
| 汉字转拼音 | Property | pinYin |
| 随机汉字 | Class | kj_randomCreateChinese: |

#### NSString+KJPredicate  谓词工具
|  功能   |  C \ I \ P | API & Property |
|  ----  | :----: | ----  |
| 过滤空格 | Instance | kj_filterSpace |
| 验证数字 | Instance | kj_validateNumber |
| 验证字符串中是否有特殊字符 | Instance | kj_validateHaveSpecialCharacter |
| 验证手机号码 | Instance | kj_validateMobileNumber |
| 验证邮箱格式 | Instance | kj_validateEmail |
| 验证身份证 | Instance | kj_validateIDCardNumber |
| 验证银行卡 | Instance | kj_validateBankCardNumber |

###  <a id="NSTimer"></a>NSTimer
#### NSTimer+KJExtension
|  功能   |  C \ I \ P | API & Property |
|  ----  | :----: | ----  |
| 开启一个当前线程内可重复执行的NSTimer对象 | Class | kj_scheduledTimerWithTimeInterval:Repeats:Block: |
| 开启一个当前线程内可重复执行的NSTimer对象 | Class | kj_scheduledTimerWithTimeInterval:Repeats:Block:RunLoopMode: |
| 开启一个需添加到线程的可重复执行的NSTimer对象 | Class | kj_timerWithTimeInterval:Repeats:Block: |
| 立刻执行 | Instance | kj_immediatelyTimer |
| 暂停 | Instance | kj_pauseTimer |
| 重启计时器 | Instance | kj_resumeTimer |
| 延时执行 | Instance | kj_resumeTimerAfterTimeInterval: |
| 释放计时器 | Class | kj_invalidateTimer: |


#### <a id="更新日志"></a>更新日志
```
####版本更新日志:
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
<p align="left">
<img src="https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590984664032&di=f75bbfdf1c76e20749fd40be9c784738&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20181208%2F2e9d5c7277094ace8e7385e018ccc2d4.jpeg" width="666" hspace="1px">
</p>
