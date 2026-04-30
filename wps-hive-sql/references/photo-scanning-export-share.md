# 拍照扫描 · 文件导出 / 分享 / 保存 / 打印（四级埋点专章）

> **纳入位置**：本文件为 [`wps-hive-sql`](../SKILL.md) skill 下《页面事件上报》拍照扫描规范的**补充专章**；处理页（`edit_page`）与编辑文字页（`picture_edit_page`）主规范见 [`photo-scanning-events-spec.md`](photo-scanning-events-spec.md)。取数默认仍使用 `hive.dw_wps_{android|ios}.scan_click` / `scan_show` / `scan_stay` / `scan_load`；`docer_scan_click` 与 `scan_click` 双上报时是否在独立表或同表不同 `event_id`，以数仓元数据为准。
>
> 正文从 Excel 埋点表转换而来，按「页面 → 模块 → 元素 → 事件 → 属性」四层结构组织，便于大模型/研发/产品快速检索与对齐。

## 📋 目录

1. [文件导出页 (`share_page`)](#1-share-page)
2. [导出预览页 (`export_preview_page`)](#2-export-preview-page)
3. [保存文档页 (`save_doc_page`)](#3-save-doc-page)
4. [分享页面 (`share_popup_page`)](#4-share-popup-page)
5. [打印页面 (`print_page`)](#5-print-page)

---

## 📖 全局字典

### 列字段含义

| 字段 | 英文标识 | 说明 |
|------|---------|------|
| 页面中文 / 页面标识 | `page_name` | 页面级标识，用于区分 H5/Native 页面 |
| 模块中文 / 模块标识 | `module_name` | 页面内的功能模块（如导航条、底部编辑区） |
| 元素中文 / 元素标识 | `element_name` | 模块内最小交互单元（按钮/输入框/面板） |
| 元素位置 | `element_position` | 元素在页面中的位置（如 `D28` 设计稿坐标） |
| 元素类型 | `element_type` | `page` / `button` / `input_box` |
| 事件 | `event_id` | 触发事件名（见下表） |
| 触发时机 | — | 业务语义上的触发条件 |
| 属性名 / 属性显示名 / 属性值 | — | 事件上报的自定义属性（key / 中文名 / 枚举值） |

### 事件类型字典

| 事件 ID | 含义 | 典型用途 |
|---------|------|---------|
| `scan_show` | 曝光事件 | 页面/元素首次可见时上报，用于计算 CTR 分母、漏斗曝光量 |
| `scan_click` | 点击事件 | 用户主动点击时上报，用于计算 CTR、功能渗透率 |
| `scan_stay` | 停留时长 | 离开页面时上报 `duration`，用于衡量页面吸引力 |
| `scan_load` | 加载耗时 | 页面加载完成时上报 `duration`，用于衡量性能体验 |
| `docer_scan_click` | 稻壳点击 | 稻壳体系点击事件（与 `scan_click` 双上报） |

### 高频公共属性

| 属性名 | 显示名 | 说明 |
|--------|--------|------|
| `integritycheckvalue` | 文档唯一 ID | 本地生成，跨端一致 |
| `cloud_file_id` | 云文档 ID | 云端存储后生成 |
| `preview_file_id` | 预览链接 ID | 仅 Excel/转表格场景上报 |
| `duration` | 时长/ms | 用于 `scan_stay` / `scan_load` |
| `page_source` | 页面来源 | 标识用户从哪个入口进入（关键的归因字段） |

### `page_source` 枚举汇总（跨多个事件复用）

| 枚举值 | 含义 | 上线版本 |
|--------|------|---------|
| `share_page` | 导出页面 | — |
| `preview_page` | 预览页面 | — |
| `convert_to_word_process_page` | 转 Word 处理页 | — |
| `convert_to_excel_process_page` | 转 Excel 处理页 | — |
| `convert_to_pdf_process_page` | 转 PDF 处理页 | 2026.04 新增 |
| `multiple_page` | 多选页 | — |
| `edit_page` | 处理页 | 2025.04 新增 |
| `preview_page_switch` | 预览页快速切换 | 2025.10 新增 |
| `half_panel` | 预览页半屏面板 | 2025.11 新增 |

---

## 1. 文件导出页 (`share_page`)
> ℹ️ **页面标识备注**：（导出和分享点击时：iOS研发埋的是export_share）

### 1.1 $页面级事件

#### 1.1.1 （页面级）  `element_name=—` · `element_type=page`

- **事件 `scan_show`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |

- **事件 `scan_stay`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `duration` | 停留时长/ms | — | — |
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |

- **事件 `scan_load`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `duration` | 加载时长/ms | — | — |
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |

### 1.2 导出和分享 (`export_share`)

#### 1.2.1 导出  `element_name=export` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `export_type` | 导出类型 | 导出为pdf：export_pdf<br>导出为word：export_word<br>导出为execl：export_execl<br>导出为ppt：export_ppt<br>保存到相册：save_album | — |
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |
  | `picture_quality` | 画质 | UHD：超清<br>HD：高清imageLevelStr<br>SD：省流<br>如导入的图片无画质上报“0“占位 <br>如多图有多画质时，用“,”区分 | — |

#### 1.2.2 打印  `element_name=print` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |

#### 1.2.3 分享  `element_name=share` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `share_type` | 分享类型 | 扫描分享：scan_share | — |

- **事件 `docer_scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |

### 1.3 导航条 (`nav_bar`)

#### 1.3.1 首页按钮  `element_name=homepage` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |

#### 1.3.2 返回按钮  `element_name=back` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |

#### 1.3.3 重命名按钮  `element_name=rename_btn` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一id | — | — |
  | `cloud_file_id` | 云文档id | — | — |

#### 1.3.4 查看文档按钮  `element_name=view_btn` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一id | — | — |

- **事件 `docer_scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `cloud_file_id` | 云文档id | — | — |

---

## 2. 导出预览页 (`export_preview_page`)

### 2.1 $页面级事件

#### 2.1.1 （页面级）  `element_name=—` · `element_type=page`

- **事件 `scan_show`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `page_source` | share_page:导出页面<br>preview_page:预览页面<br>convert_to_word_process_page：转word处理页convert_to_excel_process_page：转excel处理页<br>multiple_page：多选页<br>edit_page：处理页（2025.04新增）<br>preview_page_switch：预览页快速切换（2025.10新增）<br>half_panel：预览页半屏面板（2025.11新增）<br>convert_to_pdf_process_page：转PDF处理页（2026.04新增） | — | — |
  | `page_type` | excel:转表格预览页<br>extractdata：提取数据录表预览页 | 仅excel场景上报 | — |
  | `photo_sum` | 上报图片数量 | 仅excel场景上报 | — |
  | `export_type` | 导出为pdf：export_pdf<br>导出为word：export_word<br>导出为execl：export_excel | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `preview_file_id` | 预览链接ID | — | — |
  | `model` | 模型版本 | yolo：四边形检测新模型<br>old：旧模型 | — |

- **事件 `scan_stay`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `duration` | 停留时长/ms | — | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

- **事件 `scan_load`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `duration` | 加载时长/ms | — | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 2.2 顶部导航条 (`nav_bar`)

#### 2.2.1 返回  `element_name=back` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 2.3 去水印提示条 (`membership_bar`)

#### 2.3.1 pdf-开通会员  `element_name=membership_btn` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

- **事件 `scan_show`** — 触发时机：提示条曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 2.4 WPS水印 (`wps_watermark`)

#### 2.4.1 关闭  `element_name=close` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

- **事件 `scan_show`** — 触发时机：水印曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 2.5 去水印半屏面板
(2025.05新增) (`watermark_popup`)

#### 2.5.1 （页面级）  `element_name=—` · `element_type=page`

- **事件 `scan_show`** — 触发时机：半屏面板曝光时
  （无额外属性）

#### 2.5.2 导出无二维码水印文件  `element_name=no_watermark` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时
  （无额外属性）

#### 2.5.3 继续导出  `element_name=keep` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时
  （无额外属性）

#### 2.5.4 关闭按钮  `element_name=close` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时
  （无额外属性）

### 2.6 提示条运营位 (`activity_tips`)

#### 2.6.1 运营位  `element_name=tips` · `element_type=button`

- **事件 `scan_show`** — 触发时机：功能曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `function_name` | 功能名 | scan_pic2pdf：转pdf<br>scan_pic2word：转word<br>scan_pic2et：转表格<br>scan_extractdata：录表<br>scan_pic2txt：提取文字 | 2025年9月版本 |
  | `activity_name` | 活动名 | 读天策活动的活动名称 | 2025年9月版本 |

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `function_name` | 功能名 | scan_pic2pdf：转pdf<br>scan_pic2word：转word<br>scan_pic2et：转表格<br>scan_extractdata：录表<br>scan_pic2txt：提取文字 | 2025年9月版本 |
  | `activity_name` | 活动名 | 读天策活动的活动名称 | 2025年9月版本 |

#### 2.6.2 关闭按钮  `element_name=close` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `function_name` | 功能名 | scan_pic2pdf：转pdf<br>scan_pic2word：转word<br>scan_pic2et：转表格<br>scan_extractdata：录表<br>scan_pic2txt：提取文字 | 2025年9月版本 |
  | `activity_name` | 活动名 | 读天策活动的活动名称 | 2025年9月版本 |

### 2.7 底部编辑区 (`edit_area`)

#### 2.7.1 pdf-编辑tab  `element_name=edit` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.7.2 pdf-版式tab  `element_name=format_btn` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `format_type` | 版式类型 | native:原尺寸版式<br>joint:拼接版式<br>11size:1*1版式<br>21size:2*1版式<br>22size:2*2版式<br>32size:3*2版式<br>33size:3*3版式 | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

- **事件 `scan_show`** — 触发时机：按钮曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.7.3 pdf-水印tab  `element_name=watermark_btn` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

- **事件 `scan_show`** — 触发时机：按钮曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.7.4 pdf-更换tab  `element_name=change` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

- **事件 `scan_show`** — 触发时机：按钮曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.7.5 pdf-模式tab  `element_name=export_mode` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | （2026.5月新增） |
  | `cloud_file_id` | 云文档唯一ID | — | （2026.5月新增） |

- **事件 `scan_show`** — 触发时机：按钮曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | （2026.5月新增） |
  | `cloud_file_id` | 云文档唯一ID | — | （2026.5月新增） |

#### 2.7.6 pdf_画质选项tab  `element_name=quality_btn` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `picture_quality` | 画质类型 | SD:原图<br>HD:AI高清<br>UHD:AI超清 | （2026.4月新增） |
  | `integritycheckvalue` | 文档唯一ID | — | （2026.4月新增） |
  | `cloud_file_id` | 云文档唯一ID | — | （2026.4月新增） |

- **事件 `scan_show`** — 触发时机：按钮曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | （2026.4月新增） |
  | `cloud_file_id` | 云文档唯一ID | — | （2026.4月新增） |

#### 2.7.7 pdf_画质处理停止按钮  `element_name=cancel_btn` · `element_type=button`

- **事件 `scan_show`** — 触发时机：按钮曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | （2026.4月新增） |
  | `cloud_file_id` | 云文档唯一ID | — | （2026.4月新增） |

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `picture_quality` | 画质类型 | HD:AI高清<br>UHD:AI超清 | （2026.4月新增） |
  | `duration` | 加载等待时长/ms | — | （2026.4月新增） |
  | `integritycheckvalue` | 文档唯一ID | — | （2026.4月新增） |
  | `cloud_file_id` | 云文档唯一ID | — | （2026.4月新增） |

#### 2.7.8 excel-转表格  `element_name=change_excel` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `preview_file_id` | 预览链接ID | 仅excel场景上报 | — |

- **事件 `scan_show`** — 触发时机：按钮曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `preview_file_id` | 预览链接ID | 仅excel场景上报 | — |

#### 2.7.9 excel-提取数据录表  `element_name=extractdata` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `preview_file_id` | 预览链接ID | 仅excel场景上报 | — |

- **事件 `scan_show`** — 触发时机：按钮曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `preview_file_id` | 预览链接ID | 仅excel场景上报 | — |

#### 2.7.10 pdf/word/excel-保存导出按钮  `element_name=save_export` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `page_source` | 页面来源 | share_page:导出页面<br>preview_page:预览页面<br>convert_to_word_process_page：转word处理页convert_to_excel_process_page：转excel处理页<br>convert_to_pdf_process_page：转PDF处理页<br>multiple_page：多选页<br>edit_page（2025.04新增）preview_page_switch：预览页快速切换（2025.10新增）<br>half_panel：预览页半屏面板（2025.11新增）<br>convert_to_pdf_process_page：转PDF处理页（2026.04新增） | .17版本新增 |
  | `file_format` | 文档的格式 | et：表格<br>pdf: PDF<br>writer:文字<br>ppt::演示 | — |
  | `picture_count` | 确认导出的图片数量 | — | （2026.2&3月新增） |
  | `picture_quality<br>（仅PDF保存按钮上报该属性）` | 画质类型 | SD:原图<br>HD:AI高清<br>UHD:AI超清 | （2026.4月新增） |
  | `export_mode` | 导出模式 | searchable_pdf：双层pdf<br>Image_pdf：纯图pdf | （2026.5月新增） |

#### 2.7.11 excel-导出表格  `element_name=excel_export` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `preview_file_id` | 预览链接ID | — | — |
  | `page_source` | 页面来源 | preview_page_switch：预览页快速切换（2025.10新增）<br>half_panel：预览页半屏面板（2025.11新增） | — |

#### 2.7.12 extractdata-录入表格  `element_name=extractdata_export` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `preview_file_id` | 预览链接ID | — | — |
  | `page_source` | 页面来源 | preview_page_switch：预览页快速切换（2025.10新增）<br>half_panel：预览页半屏面板（2025.11新增） | — |
  | `picture_count` | 确认导出的图片数量 | — | （2026.2&3月新增） |

#### 2.7.13 excel-导出方式弹窗  `element_name=excel_exporttype` · `element_type=—`

- **事件 `scan_show`** — 触发时机：页面曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | 仅在转表格-导出预览页上报 | — |
  | `cloud_file_id` | 云文档唯一ID | 仅在转表格-导出预览页上报 | — |
  | `preview_file_id` | 预览链接ID | 仅在转表格-导出预览页上报 | — |

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | 仅在转表格-导出预览页上报 | — |
  | `cloud_file_id` | 云文档唯一ID | 仅在转表格-导出预览页上报 | — |
  | `preview_file_id` | 预览链接ID | 仅在转表格-导出预览页上报 | — |
  | `export_type` | multi_sheet:导出为多个sheet<br>single_sheet：导出为单个sheet | 仅在转表格-导出预览页上报 | — |

#### 2.7.14 extractdata-录表方式弹窗  `element_name=extractdata_exporttype` · `element_type=page`

- **事件 `scan_show`** — 触发时机：页面曝光时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | 仅在提取数据录表导出预览页上报 | — |
  | `cloud_file_id` | 云文档唯一ID | 仅在提取数据录表导出预览页上报 | — |
  | `preview_file_id` | 预览链接ID | 仅在提取数据录表导出预览页上报 | — |

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | 仅在提取数据录表导出预览页上报 | — |
  | `cloud_file_id` | 云文档唯一ID | 仅在提取数据录表导出预览页上报 | — |
  | `preview_file_id` | 预览链接ID | 仅在提取数据录表导出预览页上报 | — |
  | `export_type` | input_newsheet ：录入新表<br>input_oldsheet：录入已有表 | 仅在提取数据录表导出预览页上报 | — |

### 2.8 pdf-编辑页 (`edit_page`)

#### 2.8.1 返回  `element_name=back` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.8.2 保存  `element_name=save` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.8.3 图片调整  `element_name=picture_adjust` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `adjust_btn_type` | 图片调整功能类型 | clear:一键清晰<br>cut：裁剪<br>filter：滤镜 | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `model` | 模型版本 | yolo：四边形检测新模型<br>old：旧模型 | — |

#### 2.8.4 图片标注  `element_name=picture_mark` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `mark_btn_type` | 图片标准功能类型 | mosiac:马赛克<br>brush:画笔<br>word:添加文字<br>watermark：添加水印 | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.8.5 去污修复  `element_name=picture_restore` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `restore_btn_type` | 去污修复功能类型 | quality_fix:画质修复<br>eraser：消除笔<br>no_noise:去屏纹<br>no_shadow:去阴影 | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 2.9 pdf-水印页 (`watermark_page`)

#### 2.9.1 返回  `element_name=back` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.9.2 完成  `element_name=finish` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `watermark_type` | 是否添加水印 | add_watermark:加水印<br>no_watermark:不加水印 | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 2.10 pdf-更换图片页 (`change_page`)

#### 2.10.1 返回  `element_name=back` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.10.2 添加图片  `element_name=add` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.10.3 更换图片  `element_name=change` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 2.10.4 删除图片  `element_name=delete` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 2.11 pdf-模式页 (`export_mode_page`)

#### 2.11.1 双层pdf  `element_name=searchable_pdf` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | （2026.5月新增） |
  | `cloud_file_id` | 云文档唯一ID | — | （2026.5月新增） |

#### 2.11.2 纯图pdf  `element_name=Image_pdf` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | （2026.5月新增） |
  | `cloud_file_id` | 云文档唯一ID | — | （2026.5月新增） |

---

## 3. 保存文档页 (`save_doc_page`)

### 3.1 $页面级事件

#### 3.1.1 （页面级）  `element_name=—` · `element_type=page`

- **事件 `scan_show`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

- **事件 `scan_stay`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `duration` | 停留时长/ms | — | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

- **事件 `scan_load`**

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `duration` | 加载时长/ms | — | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 3.2 顶部导航栏 (`nav_bar`)

#### 3.2.1 返回  `element_name=back` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 3.3 路径选择区 (`path_area`)

#### 3.3.1 新建文件夹  `element_name=new_folder` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 3.3.2 选择保存路径（仅安卓）  `element_name=save_path` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

### 3.4 底部编辑区 (`edit_area`)

#### 3.4.1 重命名  `element_name=rename` · `element_type=input_box`

- **事件 `scan_click`** — 触发时机：输入框点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 3.4.2 文件类型  `element_name=doc_format` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

#### 3.4.3 保存按钮  `element_name=save` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `save_result` | 是否保存成功 | saved:保存成功<br>save_fail:保存失败 | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

---

## 4. 分享页面 (`share_popup_page`)

### 4.1 分享弹窗 (`show_popup`)

#### 4.1.1 （页面级）  `element_name=—` · `element_type=page`

- **事件 `scan_show`** — 触发时机：分享面板展示时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `page_source` | 弹窗所在的页面来源 | multiple_page: 文件选择页面<br>share_page：导出页面<br>preview_page：预览页面 | — |
  | `page_from` | 页面类型 | 从处理页进入：editpage<br>从首页/全部文档列表进入：list | .17版本增加，预览页外其他页面场景没有此值，则不上报字段 |

#### 4.1.2 关闭按钮  `element_name=close` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `page_source` | 弹窗所在的页面来源 | multiple_page: 文件选择页面<br>share_page：导出页面<br>preview_page：预览页面 | — |
  | `page_from` | 页面类型 | 从处理页进入：editpage<br>从首页/全部文档列表进入：list | .17版本增加，预览页外其他页面场景没有此值，则不上报字段 |

#### 4.1.3 分享方式选择  `element_name=share` · `element_type=button`

- **事件 `scan_click`** — 触发时机：按钮点击时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `share_type` | 分享方式 | 以图片发送：<br>picture_share<br>以纯图PDF发送：<br>pdf_share | — |
  | `page_source` | 弹窗所在的页面来源 | multiple_page: 文件选择页面<br>share_page：导出页面<br>preview_page：预览页面 | .17版本增加 |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |
  | `page_from` | 页面类型 | 从处理页进入：editpage<br>从首页/全部文档列表进入：list | .17版本增加，预览页外其他页面场景没有此值，则不上报字段 |

---

## 5. 打印页面 (`print_page`)

### 5.1 $页面级事件

#### 5.1.1 （页面级）  `element_name=—` · `element_type=page`

- **事件 `scan_show`** — 触发时机：打印面板展示时

  | 属性名 | 显示名 | 属性值/枚举 | 备注 |
  |--------|--------|-------------|------|
  | `page_source` | 弹窗所在的页面来源 | share_page：导出页面<br>preview_page：预览页面 | — |
  | `integritycheckvalue` | 文档唯一ID | — | — |
  | `cloud_file_id` | 云文档唯一ID | — | — |

---

## 📊 文档统计

- 页面数：**5**
- 模块数：**20**
- 元素数：**56**
- 事件数：**77**
