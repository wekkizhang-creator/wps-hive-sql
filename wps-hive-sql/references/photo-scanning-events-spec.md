# 埋点规范 · WPS 拍照扫描 · 页面事件上报（含 2025.12 新增 · 2026.04 导出链并入）

> **范围**：处理页（`edit_page`）、编辑文字页（`picture_edit_page`），以及 **文件导出 / 导出预览 / 保存文档 / 分享弹窗 / 打印** 链路的四级埋点 —— 页面 → 模块 → 元素 → 事件。其中导出链路的**全量属性表与模块清单**维护在专章 [`photo-scanning-export-share.md`](photo-scanning-export-share.md)；本文件保留与处理页一致的叙述风格，并给出 `page_name` 速查与附录字段扩展。
> **版本标记**：属性/备注中出现的「（XX 新增/修改）」为历史变更说明。

## 0. 全局上报约定

处理页内各功能入口统一上报 `page_name = edit_page`，通过 `module_name` 区分具体链路。**文件导出 / 分享 / 预览 / 保存 / 打印** 使用独立 `page_name`（见 **§3** 与 [`photo-scanning-export-share.md`](photo-scanning-export-share.md)）：

| 功能入口 | `module_name` | 说明 |
|---|---|---|
| 扫描 / 扫描证件 / 扫描书籍 / 转 Excel | `edit_choose_area` | 默认进入编辑类型选择区 |
| 转 Word | `cropping_area` | 直接进入裁切区 |
| 提取文字 | `extract_area` | x.23 版起由编辑选择区切为图片预览区 |
| 图片翻译 | `imagetranslation_area` | — |
| 扫描票据 | `scan_receipt` | 12 月新增链路 |
| 公式识别 | `scan_formula` | 25.9 新增 |

**通用事件类型**：

| 事件名 | 含义 |
|---|---|
| `scan_show` | 页面/弹窗/模块展示曝光 |
| `scan_click` | 按钮/元素点击 |
| `scan_stay` | 页面停留（上报 `duration` ms） |
| `scan_load` | 页面加载完成（上报 `duration` ms） |
| `docer_scan_click` | 稻壳体系点击（部分导出/分享按钮与 `scan_click` **双上报**；落表字段以数仓为准） |

---

## 1. 页面：处理页　（`page_name = edit_page`）

### 1.1 页面级事件

#### ▸ （模块级 · 无具体元素）
- 类型 `page`　·　事件 `scan_show`　·　触发：页面展示时
- **上报属性**：
  - `page_type` — 页面类型
    - 取值枚举：
      - general | 通用型
      - card | 证件
      - testpaper｜试卷（12月新增）
      - receipt | 票据（12月新增）
      - ocr_paragraph | 提取文字_按段提取
      - ocr_words | 提取文字_按字提取
    - 备注：2025年12月新增
  - `recognize_result` — 分类识别结果
    - 取值枚举：
      - 通用证件 | universal_card
      - 身份证 | identification_card
      - 户口本 | household_registration_booklet
      - 银行卡 | bank_card
      - 护照 |  passport
      - 营业执照 | business_license
      - 驾驶证 | driver_license
      - 试卷｜testpaper
      - 票据｜receipt（12月新增）
      - 其它|other
    - 备注：仅iOS，安卓是在load时；通用证件 | universal_card；身份证 | id_card；户口本 | household_registration_book；银行卡 | bank_card；护照 |  passport；营业执照 | business_license；驾驶证 | driving_license ；试卷｜handwritten_test_paper；票据｜receipt；其它|others；社保卡|social_security_card
  - `default_filter` — 默认滤镜
    - 取值枚举：
      - source：原图
      - optimization：优化
      - intelligent：智能
      - sharpen：锐化
      - enhance：增强
      - blackwhite：黑白
      - grayscale：灰度
      - inksaving：省墨
    - 备注：25年1月新增
  - `model` — 模型版本
    - 取值枚举：
      - yolo：四边形检测新模型
      - old：旧模型

#### ▸ （模块级 · 无具体元素）
- 事件 `scan_stay`　·　触发：页面停留
- **上报属性**：
  - `duration` — 停留时长/ms
  - `page_type` — 页面类型
    - 取值枚举：
      - card | 证件
      - testpaper｜试卷（12月新增）
      - receipt | 票据（12月新增）

#### ▸ （模块级 · 无具体元素）
- 事件 `scan_load`　·　触发：页面加载
- **上报属性**：
  - `duration` — 加载时长/ms
  - `recognize_result`
    - 取值枚举：
      - 通用证件 | universal_card
      - 身份证 | identification_card
      - 户口本 | household_registration_booklet
      - 银行卡 | bank_card
      - 护照 |  passport
      - 营业执照 | business_license
      - 驾驶证 | driver_license
      - 试卷｜testpaper
      - 票据｜receipt（12月新增）
      - 其它|other
      - general | 通用型
      - card | 证件
      - testpaper｜试卷（12月新增）
      - receipt | 票据（12月新增）
    - 备注：仅安卓， iOS是在show时

### 1.2 模块：顶部导航条　（`module_name = nav_bar`）

#### ▸ **关闭按钮**　`element_name = close`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **图片管理**　`element_name = image_manage`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **问题反馈**　`element_name = feedback`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.3 模块：模式切换　（`module_name = mode_switching`）

#### ▸ （模块级 · 无具体元素）
- 类型 `module`　·　事件 `scan_show`　·　触发：页面展示时
- **上报属性**：
  - `current_model` — 当前属性

#### ▸ **进入**　`element_name = entry`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `current_model` — 当前属性

#### ▸ **切换**　`element_name = switch`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `current_model` — 当前属性
  - `target_model` — 目标属性

#### ▸ **关闭**　`element_name = close`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.4 模块：编辑类型选择区域　（`module_name = edit_choose_area`）

#### ▸ **完成按钮**　`element_name = finish_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `is_filter` — 是否切换过滤镜
    - 取值枚举：
      - true:是
      - false:否
    - 备注：25年1月修改；统计是否点击切换过滤镜
  - `mode_switch` — 模式切换
    - 取值枚举：
      - 上报格式：“进入时模式；点击完成时的模式”（用分号隔开）
      - 上报示例：“universal_scanning；cert”
      - 通用：universal_scanning
      - 证件：cert
      - 试卷：paper
      - 票据：receipt
    - 备注：25年1月新增
  - `filter` — 使用的滤镜名称
    - 取值枚举：
      - source：原图
      - optimization：优化
      - intelligent：智能
      - sharpen：锐化
      - enhance：增强
      - blackwhite：黑白
      - grayscale：灰度
      - inksaving：省墨
    - 备注：25年1月新增
  - `is_cropping` — 是否主动使用过裁切旋转
    - 取值枚举：
      - true:是
      - false:否
  - `copy_type` — 是否有使用过提取文字
    - 取值枚举：
      - true:是
      - false:否
  - `mark_type` — 是否有使用过标注
    - 取值枚举：
      - true:是
      - false:否
  - `is_watermark` — 是否有添加水印
    - 取值枚举：
      - true:是
      - false:否
  - `is_remove_handwriting` — 是否应用去除笔迹
    - 取值枚举：
      - true:是
      - false:否
    - 备注：10月新增
  - `is_removewatermar` — 是否应用AI去水印
    - 取值枚举：
      - true:是
      - false:否
    - 备注：AI去水印（12月新增
  - `is_extracted` — 是否提取识别
    - 取值枚举：
      - true:是
      - false:否
    - 备注：扫描票据（12月新增
  - `is_remove_headblock` — 是否应用AI去遮挡
    - 取值枚举：
      - true:是
      - false:否
    - 备注：2026.01新增
  - `picture_count` — 选择的上传的图片数量
  - `is_change_filter` — 是否改变默认滤镜
    - 取值枚举：
      - true：是
      - false：否
    - 备注：25年1月新增；统计默认滤镜是否进行更改
  - `is_reedit` — 是否二次编辑
    - 取值枚举：
      - true：是
      - false：否
  - `import_way` — 导入方式
    - 取值枚举：
      - Android：
      - photograph | 拍摄
      - photo | 相册导入
      - file | 文件导入
      - iOS：
      - home_photo | 首页相册
      - home_file | 首页文件
      - home_wechat | 首页微信
      - scan_page_photo | 拍摄页相册
      - scan_page_file | 拍摄页文件
    - 备注：25年12月新增
  - `model` — 模型版本
    - 取值枚举：
      - yolo：四边形检测新模型
      - old：旧模型
  - `format_type` — 证件布局类型
    - 取值枚举：
      - single : 单张
      - left_right : 左右
      - top_bottom : 上下
      - fit : 适应纸张
    - 备注：26年2&3月新增

#### ▸ **编辑类型选择**　`element_name = edit_type`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `edit_type` — 编辑类型
    - 取值枚举：
      - filter:滤镜
      - cropping_area:裁剪
      - extract:提取文字
      - mark:页面标注
      - erase：涂抹消除
      - remove_handwriting：去除笔迹
      - watermart：水印
      - convert_word：转word（2025.04新增）
      - ai_answers：AI解题
      - convert_excel：转Excel（2025.07新增）
      - convert_ppt：转PPT（2025.11新增）
      - remove_headblock：AI去遮挡（2026.01新增）

#### ▸ **对比**　`element_name = compare`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **重新拍照**　`element_name = reset_photograph`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.5 模块：滤镜编辑区　（`module_name = filter_area`）

#### ▸ **滤镜选择**　`element_name = filter_choose`
- 类型 `button`　·　事件 `scan_click`　·　触发：点击滤镜时
- **上报属性**：
  - `filter` — 滤镜名称
    - 取值枚举：
      - 原图：source
      - 优化：optimization
      - 智能：intelligent
      - 锐化：sharpen
      - 增强：enhance
      - 黑白：blackwhite
      - 灰度：grayscale
      - 省墨：inksaving
    - 备注：25年1月新增

### 1.6 模块：裁剪编辑区　（`module_name = cropping_area`）

#### ▸ **完成按钮**　`element_name = finish_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `is_croping` — 是否裁切旋转
    - 取值枚举：
      - true:是
      - false:否
    - 备注：转word
  - `model` — 模型版本
    - 取值枚举：
      - yolo：四边形检测新模型
      - old：旧模型

#### ▸ **返回按钮**　`element_name = back`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.7 模块：提取文字区域　（`module_name = extract_area`）

#### ▸ **复制按钮**　`element_name = copy_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `copy_type` — 复制类型
    - 取值枚举：
      - copy_words：复制文字(用于按字选择的复制按钮)
      - copy：复制内容（用于按段选择的复制按钮）copy_currentpage：复制当页（.29.0新增）
  - `image_text_comparison` — 原图对照
    - 取值枚举：
      - on：开启
      - off：关闭
    - 备注：10月新增
  - `extract_type` — 提取类型
    - 取值枚举：
      - paragraph：按段提取
      - words：按字提取
      - extract_deep:深度提取（2025年12月新增）
    - 备注：.29.0新增
  - `extract_mode` — 提取模式
    - 取值枚举：
      - extract_deep:深度提取
      - extract_fast：快速提取
    - 备注：2025.12新增

#### ▸ **提取类型**　`element_name = extract_type`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `extract_type` — 提取类型
    - 取值枚举：
      - paragraph：按段提取
      - words：按字提取

#### ▸ **全选当页**　`element_name = select_all`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **返回按钮**　`element_name = back`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **提取结果**　`element_name = extract_result`
- 类型 `page`　·　事件 `scan_show`　·　触发：进入页面时
- **上报属性**：
  - `extract_type` — 提取类型
    - 取值枚举：
      - paragraph：按段提取
      - words：按字提取
      - extract_deep:深度提取
    - 备注：2025.12新增

#### ▸ **导出文档**　`element_name = export_file`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `extract_type` — 提取类型
    - 取值枚举：
      - （x.17.0新增）
      - paragraph：按段提取
      - words：按字提取
      - extract_deep:深度提取（2025年12月新增）
  - `image_text_comparison` — 原图对照
    - 取值枚举：
      - on：开启
      - off：关闭
  - `extract_mode` — 提取模式
    - 取值枚举：
      - extract_deep:深度提取
      - extract_fast：快速提取
    - 备注：2026.2&3新增
  - `picture_count` — 确认导出的图片数量
    - 备注：2026.04新增

#### ▸ **原图校对**　`element_name = image_contrast`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `is_on` — 是否开启原图校对
    - 取值枚举：
      - on:开启原图校对
      - off:关闭原图校对
      - （.29.0新增）

#### ▸ **深度提取**　`element_name = extract_deep`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **备注**：
  - 2025.12新增

#### ▸ **选择方式**　`element_name = select_type`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `select_type` — 选择方式
    - 取值枚举：
      - paragraph：按段提取
      - words：按字提取
    - 备注：2025.12新增

### 1.8 模块：提取模式弹窗　（`module_name = extract_popup`）

#### ▸ （模块级 · 无具体元素）
- 类型 `module`　·　事件 `scan_show`　·　触发：弹窗展示时
- **备注**：
  - 2025.12新增

#### ▸ **深度提取**　`element_name = extract_deep`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **快速提取**　`element_name = extract_fast`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **关闭**　`element_name = close`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.9 模块：页面标注区域　（`module_name = mark_area`）

#### ▸ **完成按钮**　`element_name = finish_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `mark_type` — 标注类型，多个标注类型用英文逗号分割
    - 取值枚举：
      - letter：文字
      - pen：画笔
      - watermark：水印
      - mosaic：马赛克

#### ▸ **继续添加**　`element_name = add_letter`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **返回按钮**　`element_name = back`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.10 模块：涂抹消除区域　（`module_name = erase_area`）

#### ▸ **确认（完成）按钮**　`element_name = finish_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **取消按钮**　`element_name = cancel`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **消除按钮**　`element_name = erase`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.11 模块：图片翻译　（`module_name = imagetranslation_area`）

#### ▸ **完成按钮(导出为Word)**　`element_name = finish_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `mark_type` — 导出为图片类型
    - 取值枚举：
      - 原图：original
      - 译图：translate
  - `picture_count` — 确认导出的图片数量
    - 备注：2026.04新增

#### ▸ **复制按钮**　`element_name = copy_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `copy_type` — 复制类型
    - 取值枚举：
      - 全部复制：copy_all
      - 局部复制：copy_part

#### ▸ **保存图片**　`element_name = save_picture`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **保存图片-二级保存**　`element_name = save_topicture`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `picture_type` — 保存为图片类型
    - 取值枚举：
      - 仅译图：translate
      - 原图+译图：original_translate

#### ▸ **返回按钮**　`element_name = back`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.12 模块：扫描票据（25年3月更新）　（`module_name = scan_receipt`）

#### ▸ **提取识别**　`element_name = structured_extract`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **备注**：
  - 扫描票据（25年3月更新

#### ▸ **复制全部**　`element_name = copy_all`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ **复制单行**　`element_name = copy_part`
- 类型 `button`　·　事件 `scan_click`　·　触发：长按字段时

#### ▸ **双击编辑**　`element_name = edit_receipt`
- 类型 `button`　·　事件 `scan_click`　·　触发：字段双击时
- **上报属性**：
  - `edit_type` — 编辑的字段类型
    - 取值枚举：
      - 字段type：中文名称
      - 票据编辑信息识别字段
  - `is_cloud_popup` — 是否弹出上云提示
    - 取值枚举：
      - true：是
      - false：否

#### ▸ **完成按钮**　`element_name = finish_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `edit_type` — 编辑的字段类型
    - 取值枚举：
      - 字段type：中文名称
      - 票据编辑信息识别字段
    - 备注：此处的“完成”按钮实际为提取识别编辑栏的“确认”按钮，实际触发时机为点击“确定”时

#### ▸ **问题反馈**　`element_name = feedback`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.13 模块：扫描证件（26年2月新增）　（`module_name = scan_credentials`）

#### ▸ **布局**　`element_name = format`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

#### ▸ （模块级 · 无具体元素）
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `format_type` — 布局类型
    - 取值枚举：
      - single | 单张
      - left_right | 左右
      - top_bottom | 上下
      - fit | 适应纸张

### 1.14 模块：公式识别（2025年9月新增）

#### ▸ （模块级 · 无具体元素）
- 类型 `page`　·　事件 `scan_show`　·　触发：页面展示时
- **上报属性**：
  - `page_type` — 页面类型
    - 取值：general | 通用型
    - 备注：公式识别（2025年9月新增
  - `default_filter` — 默认滤镜
    - 取值：source：原图
  - `page_source` — 页面来源
    - 取值枚举：
      - scan_page | 拍摄页面
      - testpaper_edit_page | 试卷处理页

#### ▸ （模块级 · 无具体元素）
- 事件 `scan_load`　·　触发：页面加载
- **上报属性**：
  - `duration` — 加载时长/ms

#### ▸ （模块级 · 无具体元素）
- 事件 `scan_stay`　·　触发：页面停留
- **上报属性**：
  - `duration` — 停留时长/ms

### 1.15 模块：公式识别（2025年9月新增）　（`module_name = scan_formula`）

#### ▸ **导出文档**　`element_name = export_file`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `formula_num` — 公式数量
    - 取值：导出的公式总量

#### ▸ **插入到文字组件**　`element_name = insert_mobile`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `formula_num` — 公式数量
    - 取值：导出的公式总量

#### ▸ **发送到PC**　`element_name = insert_pc`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `formula_num` — 公式数量
    - 取值：导出的公式总量

#### ▸ **识别结果提示**　`element_name = result_tips`
- 类型 `module`　·　事件 `scan_show`　·　触发：弹窗展示时
- **上报属性**：
  - `result` — 识别结果
    - 取值枚举：
      - failed | 导出失败
      - no_result | 未识别到公式
      - exit | 退出挽留弹窗
      - all_no_result | 所有图片未识别到公式

#### ▸ （模块级 · 无具体元素）
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `action` — 取消
    - 取值：cancel
  - 退出
    - 取值：exit
  - 重新拍摄
    - 取值：re_photograph
  - 确定
    - 取值：confirm

#### ▸ **问题反馈**　`element_name = feedback`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 1.16 模块：进度条加载区域（25年1月新增）　（`module_name = progress_load_area`）

#### ▸ **取消按钮**　`element_name = cancel_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时
- **上报属性**：
  - `present_scene` — 当前场景
    - 取值枚举：
      - 通用：universal_scanning
      - 试卷：scan_testpaper
      - 票据：scan_receipt
      - 转Word： convert_word
      - 转Excel：convert_excel
      - 转PPT：convert_ppt（属性名显示为edit_type）
      - 书籍：scan_books
      - 提取文字：text_recognition
  - `total_count` — 需加载的图片总数
    - 备注：转Word、转Excel、转PPT、提取文字场景无需记录
  - `load_count` — 已加载的图片数量
    - 备注：转Word、转Excel、转PPT、提取文字场景无需记录
  - `duration` — 加载等待时长/ms

### 1.17 模块：图片异常提示（2025.03新增）　（`module_name = warning`）

#### ▸ **异常提示**　`element_name = warning_btn`
- 类型 `button`　·　事件 `scan_click`　·　触发：点击二次确认弹窗的“清除”时
- **上报属性**：
  - `clear` — 图片异常重拍
    - 取值枚举：
      - 1：异常图片只有一张
      - 2：异常图片多张
    - 备注：2025.03新增

### 1.18 模块：长按文字区域　（`module_name = word_area`）

#### ▸ **长按**　`element_name = long_press`
- 类型 `button`　·　事件 `scan_click`　·　触发：手指点击长按时

---

## 2. 页面：编辑文字页面　（`page_name = picture_edit_page`）

### 2.1 模块：处理加载　（`module_name = optimize_loading`）

#### ▸ **时间**　`element_name = time`
- 类型 `page`　·　事件 `scan_load`　·　触发：页面加载时
- **上报属性**：
  - `duration` — 加载时长/ms
  - `status` — 加载结果
    - 取值枚举：
      - success
      - fail

#### ▸ **取消**　`element_name = cancel`
- 类型 `button`　·　事件 `scan_click`　·　触发：点击取消时

### 2.2 模块：悬浮菜单栏　（`module_name = floating_menu_bar`）

#### ▸ **面板**　`element_name = panel`
- 类型 `page`　·　事件 `scan_show`　·　触发：编辑面板出现时

#### ▸ **修改/删除/复制/**　`element_name = revise/copy/delete`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 2.3 模块：修改文字面板　（`module_name = edit_word_panel`）

#### ▸ **确定/取消**　`element_name = confirm/cancel`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 2.4 模块：修改加载　（`module_name = edit-loading`）

#### ▸ **时间**　`element_name = time`
- 类型 `page`　·　事件 `scan_load`　·　触发：修改/删除后的加载
- **上报属性**：
  - `duration` — 加载时长/ms
  - `status` — 加载结果
    - 取值枚举：
      - success
      - fail

### 2.5 模块：全局菜单栏　（`module_name = global_bar`）

#### ▸ **确定/取消**　`element_name = confirm/cancel`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 2.6 模块：提醒弹窗　（`module_name = reminder_popup`）

#### ▸ **弹窗**　`element_name = popup`
- 类型 `page`　·　事件 `scan_show`　·　触发：弹窗出现时

#### ▸ **确定/取消**　`element_name = confirm/cancel`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 2.7 模块：异常弹窗　（`module_name = exception_popup`）

#### ▸ **弹窗**　`element_name = popup`
- 类型 `page`　·　事件 `scan_show`　·　触发：弹窗出现时

#### ▸ **重试**　`element_name = retry`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

### 2.8 模块：多页切换　（`module_name = multipage_switching`）

#### ▸ **上一个/下一个**　`element_name = last/next`
- 类型 `button`　·　事件 `scan_click`　·　触发：按钮点击时

---

## 3. 文件导出 / 预览 / 保存 / 分享 / 打印（`page_name` 速查）

> **完整四级埋点**（各 `module_name` / `element_name` / 属性枚举 / 触发时机）：必读 [`photo-scanning-export-share.md`](photo-scanning-export-share.md)。

| 业务页 | `page_name` | 典型 `module_name`（节选） | 说明 |
|--------|-------------|---------------------------|------|
| 文件导出页 | `share_page` | `export_share`、`nav_bar` | 导出类型 `export_type`、分享 `share_type`、`picture_quality` 等 |
| 导出预览页 | `export_preview_page` | `nav_bar`、`edit_area`、`membership_bar`、`wps_watermark`、`watermark_popup`、`activity_tips` | `page_source` 归因、`save_export` / `excel_export`、画质与导出模式等 |
| 保存文档页 | `save_doc_page` | `nav_bar`、`path_area`、`edit_area` | `save_result`（saved / save_fail） |
| 分享弹窗 | `share_popup_page` | `show_popup` | `share_type`（picture_share / pdf_share）、`page_from` |
| 打印页 | `print_page` | （页面级） | `page_source`（share_page / preview_page） |

**与处理页联合分析**：`page_source` 枚举含 `edit_page`、`preview_page`、`share_page`、`convert_to_*_process_page`、`half_panel` 等，可与 `edit_page` 完成按钮漏斗衔接；详见导出专章中的 **`page_source` 枚举汇总**。

**取数表**：与处理页相同，使用 `hive.dw_wps_android|ios.scan_click` / `scan_show` / `scan_stay` / `scan_load`，WHERE 中通过 `page_name`、`module_name`、`element_name` 及导出专章所列属性收窄。

---

## 附录：常用属性字段速查

| 字段 | 含义 | 取值 / 单位 |
|---|---|---|
| `page_type` | 页面类型 | `general`/`card`/`testpaper`/`receipt`/`ocr_paragraph`/`ocr_words` |
| `recognize_result` | 分类识别结果 | `universal_card`/`id_card`/`passport`/`receipt` 等（iOS 在 show 时上报，Android 在 load 时上报） |
| `default_filter` | 默认滤镜 | `source`/`optimization`/`intelligent`/`sharpen`/`enhance`/`blackwhite`/`grayscale`/`inksaving` |
| `model` | 四边形检测模型版本 | `yolo`（新）/ `old`（旧） |
| `duration` | 时长 | 毫秒 (ms) |
| `is_cropping` / `is_filter` / `is_watermark` … | 功能使用标记 | `true` / `false` |
| `picture_count` | 图片数量 | 整数 |
| `import_way` | 导入方式（25.12 新增） | Android: `photograph`/`photo`/`file`；iOS: `home_photo`/`home_file` 等 |
| `extract_type` / `extract_mode` | 提取类型 / 模式 | `paragraph`/`words`/`extract_deep`/`extract_fast` |
| `format_type` | 证件布局类型（26.2&3 新增） | `single`/`left_right`/`top_bottom`/`fit` |
| `present_scene` | 进度条当前场景 | `universal_scanning`/`scan_testpaper`/`scan_receipt`/`convert_word`/`convert_excel`/`convert_ppt` |

### 附录 B：文件导出链常用字段（与专章对照）

> 枚举全量、模块与元素级触发条件见 [`photo-scanning-export-share.md`](photo-scanning-export-share.md)「全局字典」与各节表格。

| 字段 | 含义 | 取值 / 备注 |
|---|---|---|
| `integritycheckvalue` | 文档唯一 ID | 本地生成，跨端一致 |
| `cloud_file_id` | 云文档 ID | 云端存储后生成 |
| `preview_file_id` | 预览链接 ID | Excel / 转表 / 录表预览等场景 |
| `page_source` | 页面来源（归因） | `share_page`/`preview_page`/`edit_page`/`convert_to_word_process_page`/`half_panel`/`convert_to_pdf_process_page` 等（全表见专章） |
| `page_from` | 分享弹窗场景 | `editpage` / `list`（无值则不上报） |
| `export_type` | 导出类型 | `export_pdf`/`export_word`/`export_execl`/`export_ppt`/`save_album`、表格 multi_sheet/single_sheet、录表 input_newsheet/input_oldsheet 等 |
| `share_type` | 分享类型 | `scan_share`（导出页分享按钮）；弹窗内 `picture_share`/`pdf_share` |
| `file_format` | 文档格式 | `pdf`/`writer`/`et`/`ppt`（与宽表取值对齐以专章为准） |
| `picture_quality` | 画质 | `UHD`/`HD`/`SD` 或 `0` 占位；多图逗号分隔（见专章） |
| `export_mode` | PDF 导出模式 | `searchable_pdf` / `Image_pdf` |
| `save_result` | 保存是否成功 | `saved` / `save_fail` |
| `function_name` / `activity_name` | 运营位功能 / 活动 | `scan_pic2pdf` 等（见专章） |

> **同步说明**：本文件由 `wps-hive-sql` skill 收录；处理页/编辑文字页对应《页面事件上报_12月新增》至原附录；**2026.04** 起并入文件导出/分享链路索引与附录 B，全量四级定义见 [`photo-scanning-export-share.md`](photo-scanning-export-share.md)。若本地源 `.md` 末尾误混入非规范 SQL，请勿合入本文件，SQL 示例请维护在 [`photo-scanning.sql`](photo-scanning.sql)。
