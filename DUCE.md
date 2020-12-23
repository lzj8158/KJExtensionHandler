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
* [NSArray](#NSArray)

### <a id="NSArray"></a>NSArray
#### NSArray+KJPredicate  谓词工具
|  功能   | API & Property |
|  ----  | ----  |
| 对比两个数组删除相同元素并合并 | kj_mergeArrayAndDelEqualObjWithOtherArray: |
| 过滤数组 | kj_filtrationDatasWithPredicateBlock: |
| 除去数组当中包含目标数组的数据 | kj_delEqualDatasWithTargetTemps: |
| 按照某一属性的升序降序排列 | kj_sortDescriptorWithKey:Ascending: |
| 按照某些属性的升序降序排列 | kj_sortDescriptorWithKeys:Ascendings: |
| 取出 key 中匹配 value 的元素 | kj_takeOutDatasWithKey:Value: |
| 字符串比较运算符 | kj_takeOutDatasWithOperator:Key:Value: |

#### NSArray+KJExtension  对数组里面元素的相关处理
|  功能   | API & Property |
|  ----  | ----  |
| 是否为空 | isEmpty |
| 筛选数据 | kj_detectArray: |
| 多维数组筛选数据 | kj_detectManyDimensionArray: |
| 查找数据，返回-1表示未查询到 | kj_searchObject: |
