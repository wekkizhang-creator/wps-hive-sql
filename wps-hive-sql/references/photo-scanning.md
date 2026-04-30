# 拍照扫描 · 取数入口（wps-hive-sql）

本页是 **拍照扫描**（含处理页、编辑文字页、**文件导出/分享/预览/保存/打印**）相关 Hive 宽表取数的**第一查阅入口**。编写或修改此类 SQL 时，请先阅读本页并按链接下钻到规范与示例，再套用 `SKILL.md` 中的 StarRocks 方言与格式惯例。**`page_name` / `module_name` / `element_name` 及业务属性键名须与 plan / events-spec / export-share 或用户提供的材料一致，不得臆造**；硬性兜底流程见上级 [`../SKILL.md`](../SKILL.md) 章节「字段与表名来源 · 防幻觉」。

---

## 查阅顺序（强制）

1. **本文件**（`photo-scanning.md`）：表名、事件类型、页面范围速查。
2. **埋点规范全文**：[`photo-scanning-events-spec.md`](photo-scanning-events-spec.md)（《页面事件上报》同步稿，含 `page_name` / `module_name` / `element_name` / 属性枚举）。
3. **文件导出 / 分享 / 预览 / 保存 / 打印（四级全量）**：[`photo-scanning-export-share.md`](photo-scanning-export-share.md) — 涉及 `share_page`、`export_preview_page`、`save_doc_page`、`share_popup_page`、`print_page` 或 `export_type` / `share_type` / `page_source`（导出链归因）时 **必读**。
4. **SQL 示例**：[`photo-scanning.sql`](photo-scanning.sql)（可直接改日期与条件后粘贴 ScriptIs）。
5. **通用风格与方言**：上级 [`../SKILL.md`](../SKILL.md) + [`reference.sql`](reference.sql)（跨端 UNION、`dt` 分区、反引号等）。

**全量 Excel 转换稿（按需下钻）**：[`photo-scanning-plan.md`](photo-scanning-plan.md) 为业务侧整表导出 Markdown，**逐页面 / 模块 / 元素** 列事件与属性；篇幅大，**写常规取数 SQL 仍以 1～5 步为主**，需要核对单点元素、公共属性全量枚举或规范专章未收录的新增 Sheet 时再 Read。详见下文「全量埋点方案」。

---

## 全量埋点方案（Excel 转换稿）

- **文件**：[`photo-scanning-plan.md`](photo-scanning-plan.md)（与 Excel 埋点方案同步维护；由 `拍照扫描埋点方案.md` 归档入 skill）。
- **适用**：核对 `page_name` / `module_name` / `element_name` / `element_type` / 事件类型（`scan_show` / `scan_click` / `scan_load` / `scan_stay` / `scan_result` 等）与**触发时机、专属属性**；查 **`entry_position` / `entry_main` / `entry_scene` / `second_entry_scene` / `action_id` / `track_id` / `klm`** 等公共属性取值说明。
- **数仓映射补充**：方案中 **HarmonyOS（ohos）** 对应 `hive.dw_wps_ohos_mobile.*`（与 Android / iOS 同表名时，按需增加第三端 `UNION ALL` 分支）；常规双端 SQL 仍以 `hive.dw_wps_android` / `hive.dw_wps_ios` 为主。

**正文大章节速览**（便于在超长文档内检索）：

| 章节（`photo-scanning-plan.md` 内 `##`） | 内容概要 |
|------------------------------------------|----------|
| 一、基本信息 | 终端、业务标识、**Wps_Android / Wps_iOS / Wps_ohos_mobile** 与数仓 schema 对应 |
| 二、行为埋点公共属性 | `entry_position`、`entry_main`、`entry_scene`、`second_entry_scene`、`action_id`、`track_id`、`klm`、`pre_klm`、`cloud_sync_status` 等 |
| 三、页面/模块埋点详情 | 总入口；下含各业务 `##` 分块 |
| 拍摄页 | `scan_page` 及子模块（拍照设置、场景切换、创建区、新手引导、二维码识别等） |
| 首页 | `homepage`、`search_page`、`function_page` 等 |
| 扫描后的图片处理页 | **`edit_page`** 及 `picture_edit_page` 相关表格（与 events-spec 互补） |
| 扫描后的图片处理页 (2) | 处理页续表 |
| 全部文档管理 | 文档列表与管理链路 |
| 新归档页埋点（25.12上线） | 归档页专项 |
| 文件导出分享 | 与 [`photo-scanning-export-share.md`](photo-scanning-export-share.md) 对照使用 |
| 设置页面 / 打印面板 | 设置、打印 |
| 证件场景特有 / 试卷场景特有 / 票据场景特有 | 场景化专项元素与属性 |
| 我的错题本特有 / 拍照生成特有 / 开学季活动特有 | 业务专场 |
| 四、其他场景埋点 | 汇总入口 |
| 性能埋点方案 / 小程序埋点 | 性能、小程序 |

---

## 埋点表（Hive External Catalog）

| 用途 | 表名 | Android | iOS |
|------|------|-----------|-----|
| 扫描点击 | `scan_click` | `hive.dw_wps_android.scan_click` | `hive.dw_wps_ios.scan_click` |
| 扫描展示 | `scan_show` | `hive.dw_wps_android.scan_show` | `hive.dw_wps_ios.scan_show` |
| 扫描停留 | `scan_stay` | `hive.dw_wps_android.scan_stay` | `hive.dw_wps_ios.scan_stay`（表是否存在以元数据为准） |
| 扫描加载 | `scan_load` | `hive.dw_wps_android.scan_load` | `hive.dw_wps_ios.scan_load`（表是否存在以元数据为准） |
| 扫描结果 | `scan_result` | `hive.dw_wps_android.scan_result` | `hive.dw_wps_ios.scan_result` |

全端统计：对同一逻辑在 Android / iOS 各 `SELECT` 所需列后 **`UNION ALL`**，外层子查询别名 **`t`**，再对 `_device_id` 或 `_account_id` 做 `COUNT(DISTINCT ...)`（StarRocks 中以下划线开头的列名需反引号保护，见 `SKILL.md`）。

---

## 页面与事件速查

| 业务页 | `page_name` | 说明 |
|--------|----------------|------|
| 处理页 | `edit_page` | 主编辑流程；`module_name` 区分扫描 / 转 Word / 提取文字等链路 |
| 编辑文字页 | `picture_edit_page` | 悬浮菜单、改字、加载等 |
| 文件导出页 | `share_page` | 导出 / 打印 / 分享入口；常见 `module_name`：`export_share`、`nav_bar`（详见导出专章） |
| 导出预览页 | `export_preview_page` | 底部 `edit_area`（`save_export`、`excel_export` 等）、水印与会员条等 |
| 保存文档页 | `save_doc_page` | 路径与保存结果 `save_result` |
| 分享弹窗 | `share_popup_page` | `module_name = show_popup`；`page_source` / `page_from` 归因 |
| 打印页 | `print_page` | 打印面板曝光与来源 `page_source` |

| 事件名 | 含义 |
|--------|------|
| `scan_show` | 展示曝光 |
| `scan_click` | 点击 |
| `scan_stay` | 停留（`duration` ms） |
| `scan_load` | 加载完成（`duration` ms） |

更多模块级 `module_name`、`element_name`、上报属性见 **规范全文**。

---

## 维护说明

- **更新规范**：用业务方最新《页面事件上报》替换 `photo-scanning-events-spec.md` 正文（保留本 skill 内「同步说明」块或在其下方追加修订记录）。
- **更新全量方案**：业务方 Excel 导出或合并后的 `拍照扫描埋点方案.md`，**整文件替换** `photo-scanning-plan.md`（保持 UTF-8；可顺带刷新本节「大章节速览」表是否与正文 `##` 标题一致）。
- **更新示例**：把可复用的典型查询追加进 `photo-scanning.sql`，避免把大段 SQL 粘进规范 Markdown 正文。
- **触发词**：拍照扫描、处理页、`edit_page`、`picture_edit_page`、`share_page`、`export_preview_page`、`save_doc_page`、`share_popup_page`、`print_page`、`scan_click`、`scan_show`、`export_type`、`page_source`、`试卷`、`testpaper`、`证件`、`票据` 等 —— 模型应 **Read** 本文件后再写 SQL；导出链细节再 **Read** [`photo-scanning-export-share.md`](photo-scanning-export-share.md)；单点核对、公共属性枚举再 **Read** [`photo-scanning-plan.md`](photo-scanning-plan.md)。
