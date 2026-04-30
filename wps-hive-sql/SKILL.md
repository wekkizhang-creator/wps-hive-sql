---
name: wps-hive-sql
description: >-
  WPS 埋点 Hive SQL 编写助手。产出的 SQL 必须可直接在 **ScriptIs 平台 · 数据源 starrocks_k8s（StarRocks）** 上跑通，
  因此语法遵循 StarRocks（MySQL 兼容方言），而不是 Presto / 原生 Hive。
  表名三段式 `hive.{schema}.{table}`（StarRocks External Catalog "hive" 指向埋点宽表）、
  日期分区 `dt` 为单引号 ISO 字符串、Android/iOS 跨端 UNION ALL、
  UV 一律 `COUNT(DISTINCT _account_id/_device_id)`、`#` 做节标题 + `--` 分支注释、WHERE 等号对齐。
  触发词：写SQL、Hive SQL、埋点SQL、StarRocks、starrocks_k8s、ScriptIs、拍照扫描、处理页、edit_page、
  picture_edit_page、scan_click、page_show、
  button_click、func_result、scan_result、scan_show、click_uv、功能点击、功能展示、按钮点击、
  功能结果、扫描结果、扫描展示、dw_wps_android、dw_wps_ios、hive、KingSight 取数、
  查询 DAU / UV / PV、dt 分区、BETWEEN 日期、UNION ALL 安卓 iOS、export_album、export_popup、
  preview_page、edit_area、toolbar、_account_id、_device_id、跑个数、拉个数据、
  帮我写条 SQL、把这个 SQL 改一下、改成查 iOS、改成查上周。
  不编造埋点字段、防幻觉、字段依据、文档无据、候选确认。
  属性值中文、枚举中文对照、口径可读。
---

# WPS Hive SQL 编写规范

协助用户按团队惯例产出 WPS 埋点相关的 SQL，保证可直接粘贴到 **ScriptIs** 平台、选择数据源 **starrocks_k8s**（类型：**StarRocks**）执行。虽然表名里仍然带 `hive.` 前缀（这是 StarRocks External Catalog 的名字，指向底层 Hive 埋点宽表），但**实际执行引擎是 StarRocks**，所以语法要按 StarRocks / MySQL 方言写，不要混入 Presto 专有函数。

SQL 风格参考 [`references/reference.sql`](references/reference.sql)（真实样例：查询功能点击 / 功能展示）。

### 拍照扫描专题（优先查阅）

当需求涉及 **拍照扫描、处理页（`edit_page`）、编辑文字页（`picture_edit_page`）、文件导出/预览/保存/分享/打印（`share_page` / `export_preview_page` / `save_doc_page` 等）、`scan_click` / `scan_show` / `scan_stay` / `scan_load`** 等，在套用本文通用惯例之前，**必须先 Read** 专题入口 [`references/photo-scanning.md`](references/photo-scanning.md)，再按需下钻：

| 文件 | 用途 |
|------|------|
| [`references/photo-scanning.md`](references/photo-scanning.md) | 表名与事件速查、强制查阅顺序 |
| [`references/photo-scanning-events-spec.md`](references/photo-scanning-events-spec.md) | 《页面事件上报》埋点规范主文（处理页 / 编辑文字页 + 导出链索引） |
| [`references/photo-scanning-export-share.md`](references/photo-scanning-export-share.md) | 文件导出 / 分享 / 预览 / 保存 / 打印 **四级埋点专章**（全量属性与模块） |
| [`references/photo-scanning-plan.md`](references/photo-scanning-plan.md) | **Excel 整表转换**全量埋点方案（逐页 / 模块 / 元素 + 公共属性 + 证件试卷票据等专场；按需 Read，入口见 `photo-scanning.md`） |
| [`references/photo-scanning.sql`](references/photo-scanning.sql) | 拍照扫描典型 SQL 示例（可改 `dt` 与条件后执行） |

---

## 字段与表名来源 · 防幻觉（硬性兜底）

写 WHERE / SELECT 里用到的**埋点属性键名、枚举取值、`page_name`·`module_name`·`element_name` 组合、物理表名**，必须有据可查。**禁止**根据业务口语、常识或「听起来合理」自行发明字段或表。

**允许的依据（优先级从高到低）**：

1. 用户本次对话中**明确粘贴**的埋点说明 / PRD / 表结构 / 已有可跑 SQL；
2. 本 skill 内 **Read 过的** [`references/photo-scanning-plan.md`](references/photo-scanning-plan.md)、[`references/photo-scanning-events-spec.md`](references/photo-scanning-events-spec.md)、[`references/photo-scanning-export-share.md`](references/photo-scanning-export-share.md) 等专题正文；
3. **本文**与 [`references/reference.sql`](references/reference.sql) 中**已写明**的表名与常见字段子集（见下文章节 5）。

**做不到有据时的固定话术与动作**：

- 在已检索的文档里 **找不到** 用户要的字段名或取值：直接说明 **「当前可读资料中未收录 `xxx`（字段或取值）」**，**不要**用近义词捏造一个列名写进 SQL。
- 可列出文档里 **语义最接近** 的 1～3 个候选（写出**准确字段名** + 一句差异说明），请用户确认是否其一；若用户确认仍无依据，保持 SQL 中不写该条件，或改为 `/* 待业务确认字段名后再补 */` 类注释占位（交付时须说明占位原因）。
- **宽表物理列**未在 skill 出现、用户也未提供 DDL：写明 **「该列未在本 skill 中校验，请在 ScriptIs / 元数据中确认列存在后再用」**，不得写「宽表一般都有」式推断。
- **`hive.{schema}.{table}`**：仅使用本 skill 已列 schema（如 `dw_wps_android` / `dw_wps_ios` 等）及已说明事件表名，或用户明确给出的合规三段式；**禁止**发明新的 catalog / 库 / 表路径。

**拍照扫描类需求**：涉及 `edit_page`、导出链、扫描四表等时，**必须先 Read** [`photo-scanning.md`](references/photo-scanning.md) 并按其中顺序下钻到 plan / events-spec / export-share，再落笔属性条件；不得仅凭记忆拼 `element_name`。

---

## 产出 SQL 必须遵守的 10 条硬性惯例

下面每一条都是硬性的，不允许为了"可读性"或"简洁"私自省略。

### 0. 运行环境：ScriptIs 平台 + starrocks_k8s 数据源（StarRocks 方言）

所有产出的 SQL 都要能**原封不动**贴进 ScriptIs 脚本执行器、选择数据源 `starrocks_k8s`（类型 `starrocks`）后一把跑通。这条约束决定了方言选择：

| 属性 | 值 |
|------|----|
| 平台 | ScriptIs |
| 数据源名称 | `starrocks_k8s` |
| 数据源类型 | StarRocks |
| SQL 方言 | **StarRocks**（MySQL 兼容），**不是** Presto，也不是原生 Hive |

关键后果（写 SQL 时最容易踩的方言差异）：

- ✅ **能用**：`DATE_SUB(current_date, INTERVAL 1 DAY)`、`DATE_ADD(current_date, INTERVAL -7 DAY)`、`DATEDIFF(d1, d2)`、`date_format(now(), '%Y-%m-%d')`、`CURRENT_DATE`、`NOW()`、`IFNULL(...)`、`SUBSTRING_INDEX(...)`、MySQL 风格的 `LIMIT n OFFSET m`
- ❌ **禁用**（Presto 专有，贴过去直接报错）：
  - `date_add('day', -1, current_date)` / `date_diff('day', d1, d2)`（Presto 三参数签名）
  - `current_date - interval '1' day`（Presto 字符串单位的 `INTERVAL` 写法）
  - `date_format(current_date, '%Y-%m-%d')` 里的 `%Y-%m-%d` 本身两边都支持，但 Presto 的 `format_datetime(ts, 'yyyy-MM-dd')` 在 StarRocks 不存在
  - `try_cast(...)`、`try(...)`、`approx_distinct(...)`、`array_agg(... ORDER BY ...)` 这些 Presto 方言
- ❌ **禁用**（原生 Hive 专有）：
  - `LATERAL VIEW explode(...)` → StarRocks 用 `UNNEST`
  - `DISTRIBUTE BY` / `SORT BY` / `CLUSTER BY`
  - `DOUBLE` 之外的 Hive 类型别名如 `STRING`（StarRocks 的 `STRING` 可用，但跑脚本默认按 `VARCHAR` 理解）
  - Hive 注释 `-- xxx` 在 StarRocks 中要确保**单行注释以 `-- ` 开头后必须有空格**（或用 `#`），否则 StarRocks 解析器偶发报错；本 skill 所有 `--` 注释都带空格，直接照抄即可
- `LIMIT` 分页用 MySQL 写法：`LIMIT 100 OFFSET 200` 或 `LIMIT 200, 100`；**不要**写成 Presto 的 `OFFSET 200 LIMIT 100`

动态日期示例（StarRocks 写法，下文第 2 条的"昨天"就按这个来）：

```sql
-- 昨天
WHERE dt = date_format(DATE_SUB(current_date, INTERVAL 1 DAY), '%Y-%m-%d')

-- 最近 7 天（含今天）
WHERE dt >= date_format(DATE_SUB(current_date, INTERVAL 6 DAY), '%Y-%m-%d')
  AND dt <= date_format(current_date, '%Y-%m-%d')
```

> 仍然**默认**先给写死字面量的版本（如 `dt BETWEEN '2026-01-01' AND '2026-01-31'`），用户明确要"每天自动跑"时才切换到上面的动态写法。

### 1. 表名三段式，永远带 `hive.` 前缀

所有 FROM / JOIN 的表必须写成：

```
hive.{schema}.{table}
```

> 这里的 `hive` 是 **StarRocks External Catalog 的名字**（挂载到底层 Hive 埋点宽表），不是数据库名。StarRocks 通过这个 Catalog 读到 Hive Metastore 里的表，所以三段式里的 `hive.` 前缀必须保留，不要擅自简写成 `dw_wps_android.scan_click`，否则 StarRocks 会去默认 Catalog 找这张表，直接报 "Unknown table"。

常用 schema：

| schema | 用途 |
|--------|------|
| `dw_wps_android` | Android 端埋点 |
| `dw_wps_ios`     | iOS 端埋点 |
| `dw_wps_pc`      | PC 端埋点（如出现） |
| `dw_wps_web`     | Web 端埋点（如出现） |

**数据来源与表名速查**（`dw_wps_ios` / `dw_wps_android` 下表名一一对应，仅 schema 区分端；**一律写三段式** `hive.{schema}.{table}`）：

| 数据用途（查什么） | 表名 | iOS 完整表名 | Android 完整表名 |
|-------------------|------|--------------|------------------|
| 查询按钮点击 | `button_click` | `hive.dw_wps_ios.button_click` | `hive.dw_wps_android.button_click` |
| 查询功能结果 | `func_result` | `hive.dw_wps_ios.func_result` | `hive.dw_wps_android.func_result` |
| 查询页面展示 | `page_show` | `hive.dw_wps_ios.page_show` | `hive.dw_wps_android.page_show` |
| 查询扫描功能点击 | `scan_click` | `hive.dw_wps_ios.scan_click` | `hive.dw_wps_android.scan_click` |
| 查询扫描功能结果 | `scan_result` | `hive.dw_wps_ios.scan_result` | `hive.dw_wps_android.scan_result` |
| 查询扫描功能展示 | `scan_show` | `hive.dw_wps_ios.scan_show` | `hive.dw_wps_android.scan_show` |

选表规则：

- 用户只说「iOS / 苹果」→ `hive.dw_wps_ios.{上表 table 列}`
- 用户只说「Android / 安卓」→ `hive.dw_wps_android.{上表 table 列}`
- 用户要「全端 / 双端合计」→ 对同一 `table` 名在 iOS 与 Android 各 `SELECT` 所需列后 `UNION ALL`，外层再聚合（与第 4 条跨端骨架一致）
- 口语「按钮点击」→ `button_click`；「页面 / 模块展示」→ `page_show`；「扫描点击」→ `scan_click`；「扫描展示」→ `scan_show`；「扫描结果 / 功能结果」→ `scan_result` / `func_result`（按业务语义二选一，拿不准时追问用户要「功能链路结果」还是「扫描链路结果」）

> 反面例子 ❌：`FROM scan_click` / `FROM dw_wps_android.scan_click` / `FROM page_show`
> 正确 ✅：`FROM hive.dw_wps_android.scan_click`、`FROM hive.dw_wps_ios.page_show`

### 2. 日期字段永远是 `dt`，值永远是单引号 ISO 字符串

- 分区字段固定叫 `dt`
- 字面量永远写成 `'YYYY-MM-DD'`，用单引号，不用双引号，不加时分秒
- 区间查询优先用 `BETWEEN '起' AND '止'`（含两端），天级增量用 `dt >= 'YYYY-MM-DD'`
- 不允许出现 `date()`, `to_date()`, `CAST ... AS DATE` 之类把 `dt` 转成别的类型的写法——它就是字符串分区
- 相对日期（"昨天""上周"）如需动态，用 StarRocks 写法 `date_format(DATE_SUB(current_date, INTERVAL 1 DAY), '%Y-%m-%d')`（详见第 0 条）；**默认**先给用户写死字面量版本，只有在用户明确要求"每天自动跑"时才换成动态

```sql
WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
```

```sql
WHERE dt >= '2026-03-13'
```

### 3. 用户维度字段带下划线前缀

| 字段 | 含义 | 典型用途 |
|------|------|----------|
| `_account_id` | 登录账号 ID | 登录态 UV / 付费分析 |
| `_device_id`  | 设备 ID     | 全量 UV（含未登录） |

- **UV 一律 `COUNT(DISTINCT _account_id)` 或 `COUNT(DISTINCT _device_id)`**，不要用 `COUNT(*)` 冒充 UV
- 需求含糊时默认用 `_device_id`（更能代表真实用户触达），并在注释里点出"如需登录 UV 改成 `_account_id`"
- 别名统一用业务语义，如 `click_uv` / `show_uv` / `export_account_id_cnt`

### 4. 跨 Android / iOS：UNION ALL + 外层子查询再聚合

同一功能在两端分别有事件时，**不要**写两段 SQL 让用户自己加和，也**不要**用 `UNION`（会去重影响性能）。标准骨架：

```sql
SELECT
    COUNT(DISTINCT _account_id) AS export_account_id_cnt
FROM (
    -- Android：{业务语义}
    SELECT _account_id
    FROM hive.dw_wps_android.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND page_name    = 'preview_page'
      AND module_name  = 'edit_area'
      AND element_name = 'export_popup'

    UNION ALL
    -- iOS：{业务语义}
    SELECT _account_id
    FROM hive.dw_wps_ios.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND page_name    = 'preview_page'
      AND module_name  = 'edit_area'
      AND element_name = 'export_popup'
) t;
```

- 外层子查询一律起别名 `t`
- 每个 UNION 分支前用 `-- 平台：业务语义` 注释说明
- 子查询内部**只 SELECT 聚合需要的列**（一般就是 `_account_id` / `_device_id`），不要 `SELECT *`
- 同一个口径在 Android / iOS 上埋点 key 可能不一样（例如相册：Android `export_album` vs iOS `save_album`），要分支里分别写，注释里点明差异

### 5. 常见事件属性字段清单（点击 / 展示通用）

出现在 WHERE 中的属性字段基本来自以下集合，写条件时从这里挑，不要自造字段：

| 字段 | 含义 | 典型取值举例 |
|------|------|--------------|
| `page_name`    | 页面名            | `preview_page`, `export_preview_page`, `scanedit` |
| `module_name`  | 页面内模块        | `edit_area`, `toolbar` |
| `element_name` | 具体元素 / 按钮   | `export_popup`, `save_export`, `excel_export` |
| `element_type` | 元素类型          | `button` |
| `position`     | 位置              | `toolbar` |
| `comp`         | 组件 / 端内业务线 | `pdf`, `writer`, `excel` |
| `func_name`    | 功能名            | `scanedit` |
| `export_type`  | 导出去向          | `export_album`(Android), `save_album`(iOS) |
| `file_format`  | 文件格式          | `pdf`, `writer`（Word）, `excel`/空（表格） |
| `entry_scene`  | 入口场景          | `universal_scanning` |

> 上表是**高频子集**，不是全量枚举；未出现的属性键必须从专题文档（`photo-scanning-plan` / `events-spec` / `export-share`）或用户提供的材料中核对后再写入，**不得脑补列名或取值**。详见上文「字段与表名来源 · 防幻觉」。

> 用户如果只说"导出 Word"，SQL 里要加 `file_format = 'writer'`（不是 `'word'`）；说"导出表格"常见做法是用 `element_name = 'excel_export'` 兜底而不是 `file_format = 'excel'`，因为历史埋点上表格这层 file_format 不稳定。拿不准时先按参考文件里的写法照抄。

### 6. 注释与分节

| 场景 | 写法 |
|------|------|
| 一个文件里多条独立查询 | `#查询功能点击` / `#查询功能展示` 作为节标题，单独一行 |
| 同一查询内部的 UNION 分支 | `-- Android：保存到相册` / `-- iOS：导出 PDF` |
| 某段条件需要解释业务背景 | 条件上方一行 `-- xxx` |
| 枚举 / 属性取值旁标注中文 | 同一行或上一行注释，如 `-- entry_scene=universal_scanning 万能扫描`；或 `WHERE ... AND entry_scene = 'universal_scanning' /* 万能扫描 */`（以 StarRocks 接受为准，优先用上一行 `--`） |

注释必须说明**业务含义**，不要写"-- Android 端点击表"这种复述字段名的废话。

### 7. 格式化：关键字大写、WHERE 等号对齐、AND 下沉两格

```sql
SELECT _account_id
FROM hive.dw_wps_android.scan_click
WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
  AND page_name    = 'preview_page'
  AND module_name  = 'edit_area'
  AND element_name = 'export_popup'
  AND export_type  = 'export_album'
  AND entry_scene  = 'universal_scanning'
```

- `SELECT / FROM / WHERE / AND / UNION ALL / GROUP BY / ORDER BY / AS` 一律大写
- `SELECT` 字段和 `FROM` / `WHERE` / `GROUP BY` 顶格（子查询内缩进 4 空格）
- `AND` 相对 `WHERE` 缩进 2 空格，形成"WHERE 条件块"
- 同一 WHERE 块里的等号 `=` 尽量纵向对齐（字段名右侧补空格到同一列），提升可读性
- 每个 SQL 末尾加分号 `;`

### 8. 按天出数默认带 `dt` 到 SELECT 和 GROUP BY

当用户要"每天的 UV / PV"时，默认模板：

```sql
SELECT dt,
       COUNT(DISTINCT _device_id) AS click_uv
FROM hive.dw_wps_ios.page_show
WHERE dt >= '2026-03-13'
  AND comp      = 'pdf'
  AND func_name = 'scanedit'
  AND page_name = 'scanedit'
  AND position  = 'toolbar'
GROUP BY dt
ORDER BY dt;
```

- `dt` 永远是 SELECT 的第一列
- `GROUP BY dt` 写字段名而不是 `GROUP BY 1`（读起来更明确）
- 出趋势图时最后带 `ORDER BY dt`

### 9. 别自作主张加这些

- ❌ `LIMIT 1000` —— 除非用户明确说"抽样看一下"
- ❌ `SELECT *` —— 点击宽表列非常多，必须列出需要的字段
- ❌ `JOIN` 猜字段 —— 两张埋点表做 JOIN 前必须先问清关联键（`_account_id` / `_device_id` / `dt`）
- ❌ 把 `dt` 当作日期计算（如 `dt + interval '1' day`）—— 它是字符串，先 `date_format(...)` 转成日期再算，或者直接跟字面量比较
- ❌ 把 SQL 当 Presto 写 —— 这里跑的是 **StarRocks**，`date_add('day', -1, current_date)` / `date_diff('day', ...)` / `current_date - interval '1' day` 这些 Presto 三参数/字符串单位签名都会报错，必须用 MySQL 风格的 `DATE_SUB(current_date, INTERVAL 1 DAY)` / `DATEDIFF(d1, d2)`（见第 0 条）
- ❌ 把 SQL 当原生 Hive 写 —— `LATERAL VIEW explode(...)` / `DISTRIBUTE BY` / `SORT BY` 在 StarRocks 上不支持，炸数组用 `UNNEST`
- ❌ **编造埋点字段或表** —— 无文档依据的属性 / `page_name` 组合 / 表名一律不写；走「防幻觉」章节的澄清或候选列举流程

---

## 工作流：接到需求后怎么做

### Step 1 — 先对齐口径（缺一样就追问一次）

开工前必须确认清楚下面 5 件事，任何一项模糊就**先问用户一次**（一次性问全，不要来回），然后再下笔：

1. **事件类型**：点击（`scan_click` / 对应宽表）还是展示（`page_show`）？还是其他？
2. **平台范围**：Android、iOS、全端？（全端 → UNION ALL）
3. **时间范围**：具体的 `dt` 区间，例如 `2026-01-01` 到 `2026-01-31` / 最近 7 天 / 某天起至今
4. **聚合维度**：总 UV？分天？分版本？分渠道？
5. **用户口径**：登录 `_account_id` 还是设备 `_device_id`？默认后者并在注释中标注
6. **字段与表是否有据**（与「防幻觉」联动）：用户描述里提到的筛选项，能否在已 Read 的埋点方案 / skill 参考中对应到**确切字段名与取值**？不能则一次性问清或列出候选请用户确认，**不要先写进 SQL 再猜**

如果用户提供了**已有 SQL / 埋点文档 / PRD 截图**作为上下文，优先从里面提取，不够的再问。对已有 SQL 中的非常见字段，仍应核对是否与当前口径文档一致，不一致处标出并请用户确认。

### Step 2 — 产出 SQL

按上面 9 条硬性惯例写，并确保：

- 用代码块（```sql）包裹，方便用户一键复制
- 超过一条独立查询时，用 `#xxx` 做节标题隔开
- SQL 前用 1-2 句中文说明口径（查的是什么、时间范围、UV/PV 定义）
- 对**非 obvious** 的 `WHERE` 条件（非常见三件套以外的属性），用一句话点明依据出处（例如「条件来自 `photo-scanning-plan` 中 xxx 模块」或「来自用户粘贴的 SQL」）；无依据则不下该条件
- **属性值尽量带中文可读名**：埋点方案里常见「中文名｜英文枚举」写法；交付时**至少一处**体现英文取值对应的中文——任选或组合：**（1）** SQL 内 `WHERE` / `JOIN` 条件旁 `-- 中文说明`；**（2）** `GROUP BY` 维度出数时增加 `CASE ... END AS xxx_label`（或子查询映射列）输出中文标签列；**（3）** SQL 前的口径说明或 SQL 后的「枚举对照」小表列出本查询涉及的 `字段=英文值 → 中文名`。若文档无中文名则写「文档未给中文名，仅英文值 `xxx`」，不要杜撰。
- SQL 后补一段"调整提示"：如果用户想换时间、换平台、换成登录 UV，应该改哪几行

### Step 3 — 自检清单（产出后自己过一遍）

在返回给用户之前，逐条核对。**这套清单是"风格合规（10 条惯例）"+"通用检查（6 项正确性）"的合集，写新 SQL 也要过完整版**：

风格合规（对应 10 条惯例）：

- [ ] 所有表都带 `hive.` 前缀（External Catalog 名）
- [ ] 所有日期都是 `'YYYY-MM-DD'` 单引号字符串
- [ ] UV 用的是 `COUNT(DISTINCT _account_id/_device_id)` 而不是 `COUNT(*)`
- [ ] 跨端需求用了 `UNION ALL` + 外层 `t` 子查询
- [ ] WHERE 等号对齐、`AND` 缩进 2 格
- [ ] 关键字全大写
- [ ] 结尾有分号
- [ ] 没有 `SELECT *`、没有意外的 `LIMIT`
- [ ] 注释写的是业务语义不是字段复述
- [ ] **防幻觉**：每条非通用维度的埋点属性 / 枚举 / 表名，在交付说明或注释中可追溯到文档或用户材料；不存在「文档无据却写入 SQL」的字段
- [ ] **属性值可读**：查询里写到的主要枚举 / 属性取值，已在 SQL 注释、`CASE` 标签列或文外对照中之一体现**有据的中文名**（文档未载则已注明无中文名）

通用正确性（对应下文"通用检查清单"6 项，写新 SQL 和修 SQL 都要过）：

- [ ] **方言合规**：没有 Presto 专有写法（`date_add('day', ...)`、`current_date - interval '1' day`、`try_cast`、`approx_distinct`、`format_datetime` 等）和 Hive 专有写法（`LATERAL VIEW`、`collect_set`、`get_json_object` 等）
- [ ] **语法干净**：没有占位符残留（`{{...}}` / `:var` / `$var`）、没有括号失配、中文节标题用 `/* */` 不用 `#`
- [ ] **库表三段式**：外部表 `hive.xxx.yyy`，内部表 `default_catalog.xxx.yyy`
- [ ] **反引号保护**：下划线开头字段（`` `_device_id` ``、`` `_account_id` ``）和保留字字段（`` `from` `` / `` `type` `` 等）都加了反引号
- [ ] **分区裁剪**：`dt` 过滤必须在；跨月 / 跨年场景用半开区间 `dt >= '起' AND dt < '止'`
- [ ] **性能底线**：没有大表 `CROSS JOIN`，高基数 `COUNT(DISTINCT)` 已评估是否改 `APPROX_COUNT_DISTINCT`，跨度 > 3 个月的查询已提示拆批

任何一项不过，原地改完再交付。

---

## 典型模板速查

### 模板 A：单端单事件 · 总 UV

```sql
SELECT COUNT(DISTINCT _device_id) AS click_uv
FROM hive.dw_wps_ios.scan_click
WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
  AND page_name    = 'xxx'
  AND element_name = 'xxx';
```

### 模板 B：跨端 · 总 UV（UNION ALL）

```sql
SELECT COUNT(DISTINCT _account_id) AS uv
FROM (
    -- Android
    SELECT _account_id
    FROM hive.dw_wps_android.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND page_name    = 'xxx'
      AND element_name = 'xxx'

    UNION ALL
    -- iOS
    SELECT _account_id
    FROM hive.dw_wps_ios.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND page_name    = 'xxx'
      AND element_name = 'xxx'
) t;
```

### 模板 C：按天趋势 · 展示 UV

```sql
SELECT dt,
       COUNT(DISTINCT _device_id) AS show_uv
FROM hive.dw_wps_ios.page_show
WHERE dt >= '2026-03-13'
  AND page_name = 'xxx'
  AND position  = 'toolbar'
GROUP BY dt
ORDER BY dt;
```

### 模板 D：多分支并查（多种导出方式合计）

骨架参考 [`references/reference.sql`](references/reference.sql) —— 8 个 UNION ALL 分支（Android/iOS × 相册/PDF/Word/表格）拼出一个"导出行为总 UV"。新增分支就复制一段改 `page_name` / `element_name` / `file_format` / `export_type`。

---

## 常见改写请求快速应对

| 用户说 | 怎么改 |
|--------|--------|
| "改成上周" | 把 `BETWEEN` 两端换成上周一 / 周日字面量 |
| "改成只看 iOS" | 删掉 Android 分支，外层 `FROM (...) t` 可以退化成直接 `FROM hive.dw_wps_ios.xxx` |
| "改成登录用户" | `_device_id` → `_account_id`，别名同步改 |
| "加上版本维度" | SELECT 和 GROUP BY 都加上 `app_version`（如果埋点有），并在注释说"需要确认该字段在两端是否同名" |
| "要 PV 不是 UV" | `COUNT(DISTINCT ...)` → `COUNT(1)`，别名改成 `xxx_pv` |
| "要去掉内部员工" | 默认不过滤，追问一次："是否有内部员工账号白名单表可用？" 有就 `LEFT JOIN ... WHERE t2._account_id IS NULL` |
| "改成每天自动跑 / 动态日期" | 字面量 `dt` 换成 StarRocks 写法，如 `dt = date_format(DATE_SUB(current_date, INTERVAL 1 DAY), '%Y-%m-%d')`；**不要**写成 Presto 的 `date_add('day', -1, current_date)` |

---

## 通用检查清单（写新 SQL 和修已有 SQL 都必须过）

下面这六大核心检查项，**无论你是在写一条全新 SQL，还是在修用户丢过来的问题 SQL，都要逐项过一遍**——这是 SQL 能在 ScriptIs · starrocks_k8s 上一把跑通的最低门槛。写新 SQL 时，是"下笔前先把六项装在脑子里、下完笔再核对一遍"；修已有 SQL 时，是"拿到 SQL 先挨个对照排查"。

本节和前面"10 条硬性惯例"的关系：

- **10 条惯例** = 团队风格 / 可读性约束（怎么写才像 WPS 团队的 SQL）
- **本节 6 项检查** = 方言正确性 / 性能底线（不过就跑不动或跑出错）

两套规则都要满足。极少数情况下写法冲突时（比如注释格式、分区区间），**以本节的防御性写法为准**。

### 一、六大核心检查项

逐项过一遍；写新 SQL 是"下笔即合规"，修 SQL 是"发现一项就就地改掉"。

**与「防幻觉」交叉检查（不单独编号，但必须执行）**：WHERE / SELECT 中出现的**业务埋点属性键名**（除 `dt`、`_device_id`、`_account_id`、`page_name`、`module_name`、`element_name` 等已在本 skill 或专题中定义者外）须能指回 **Read 过的** plan / events-spec / export-share 或用户粘贴材料；否则不得写入，应先走「字段与表名来源 · 防幻觉」的澄清路径。

#### 1. 语法错误校验

- **关键字拼写**：`SLECT` / `FORM` / `WHRER` / `GRUOP BY` 这类手滑错字，StarRocks 解析器会报 `Unexpected input 'xxx'`
- **括号匹配**：多一个或少一个 `)` / `]`；嵌套子查询 + CTE 时尤其常见
- **占位符未替换**：`{{event_table}}` / `:start_date` / `$dt` 这种文档模板残留，必须替换成实际值
- **注释格式**：**StarRocks 解析器对中文 + `--` 组合偶发不友好**，尤其当 `--` 后面紧跟中文没有空格时会报 `Unexpected input '查询'`。**修 SQL 时一律把 `#` 开头的节标题和 `-- 中文xxx` 换成 `/* 中文xxx */`**，最稳妥
- **CTE / GROUPING SETS 特殊语法**：`WITH t AS (...)` 后面只能跟 `SELECT` 不能直接跟 `INSERT`；`GROUPING SETS ((a), (b), ())` 的括号层级别搞错

修复动作（对应上面四点）：

```sql
/* #查询功能点击  --> 改成  */
/* 查询功能点击 */

-- Android：导出相册  --> 改成
/* Android：导出相册 */

FROM {{event_table}}  --> 替换成
FROM hive.edw_vas.dwd_ocr_event_i_d
```

#### 2. 库表引用规范

- **外部表三段式**：StarRocks 上的 Hive 埋点表必须 `hive.{database}.{table}`
- **内部表三段式**：StarRocks 原生表走 `default_catalog.{database}.{table}`（或者至少 `{database}.{table}` 并确保当前 session 在默认 catalog）
- **自动补全规则**：库名前缀以 `dw_` / `edw_` / `ods_` 开头的，默认补 `hive` catalog——这是 WPS 团队埋点宽表惯例
- **表名校验**：如果用户提供的表报 `table metadata not found`，**不要擅自改表名**，反问用户确认（有可能是权限、有可能是拼写、有可能是表已下线）

| 现状 | 修复 |
|------|------|
| `FROM scan_click` | `FROM hive.dw_wps_android.scan_click` |
| `FROM dw_wps_android.scan_click` | `FROM hive.dw_wps_android.scan_click` |
| `FROM edw_vas.dwd_ocr_event_i_d` | `FROM hive.edw_vas.dwd_ocr_event_i_d` |
| `FROM my_result_table`（StarRocks 内部表） | `FROM default_catalog.ads.my_result_table` |

#### 3. 字段名规范（反引号保护）

StarRocks 对以**下划线开头**的字段、以及跟**保留字**撞名的字段（`from`、`order`、`group`、`desc`、`type` 等）解析时偶发当成非法标识符。修 SQL 时默认加反引号保护：

```sql
/* 反引号保护以下划线开头的字段和保留字 */
SELECT COUNT(DISTINCT `_device_id`) AS click_uv,
       `from`,
       `type`
FROM hive.dw_wps_android.scan_click
WHERE dt >= '2026-01-01' AND dt < '2027-01-01'
  AND `_account_id` IS NOT NULL;
```

> 规则统一：写新 SQL 和修 SQL **都要**给以下两类字段加反引号——(a) 以下划线开头的 `_device_id` / `_account_id` 等；(b) 与 SQL 保留字同名的 `from` / `order` / `type` / `group` / `desc` 等。这会稍微牺牲一点视觉洁净度，但能一劳永逸避开 StarRocks 解析器的边界 case。前面第 7 条风格示例如果没写反引号，**以本节为准**进行更新后再交付。

#### 4. 分区裁剪（最容易忘的性能雷）

- 涉及时间范围的查询**必须**用 `dt` 过滤，否则全表扫描直接超时
- 区间写法的推荐优先级（写新 SQL 和修 SQL 都适用）：
  1. **跨月 / 跨年范围** → 优先用半开区间 `dt >= '起' AND dt < '止'`（如 `dt >= '2026-01-01' AND dt < '2027-01-01'`），语义最清晰，边界不会踩错
  2. **同月内的明确区间**（如"1 月 1 日到 1 月 31 日"） → 可以用 `BETWEEN '2026-01-01' AND '2026-01-31'`，两端都含，符合直觉
  3. **单日 / 多天递增** → `dt = 'YYYY-MM-DD'` 或 `dt >= 'YYYY-MM-DD'`
- 如果拿到的 SQL 完全没 `dt` 过滤，**先补最小必要分区范围**再谈其他优化
- 前面第 2 条惯例默认推荐 `BETWEEN`，在跨月 / 跨年场景下**以本项为准**换成半开区间

```sql
/* 改前：没有 dt 过滤（全表扫描） */
WHERE page_name = 'preview_page';

/* 改后：补分区裁剪 */
WHERE dt >= '2026-01-01' AND dt < '2027-01-01'
  AND page_name = 'preview_page';
```

#### 5. 性能隐患

| 问题 | 识别 | 修复 |
|------|------|------|
| 大表 `CROSS JOIN` | 两张埋点表直接 `,` 逗号连接或 `CROSS JOIN` | 追问关联键，改成 `INNER JOIN ON ...`；不行就拆查询 |
| `UNNEST` 炸数组超内存 | 宽表里对 `array` 字段 UNNEST 后再聚合 | 先用 `WHERE` 收窄到小时间范围再 UNNEST |
| `COUNT(DISTINCT)` 高基数 | 对 `_device_id` 跨 30 天 COUNT DISTINCT，亿级用户 | 精度能让步的场景换成 `APPROX_COUNT_DISTINCT(`_device_id`)`，性能数量级提升 |
| 跨年 / 跨多月的单次查询 | `dt` 跨度超过 3 个月且没分桶 | 拆成按月批次多次跑，再 `UNION ALL` 汇总；或用调度平台分片 |

#### 6. 平台兼容性（StarRocks 不支持的函数清单）

修 SQL 时遇到以下任何一个，**直接替换**，不要保留：

| 不支持 / 易踩 | 替换为 |
|---------------|--------|
| `SUBSTR(s, start, len)` 语义歧义 | `SUBSTRING(s, start, len)` 或更清晰的 `SPLIT_PART(s, '|', 1)` |
| `regexp_extract_all(...)`（Hive 签名） | `regexp_extract(s, pattern, group_idx)`（StarRocks 签名） |
| `LATERAL VIEW explode(arr)` | `CROSS JOIN UNNEST(arr) AS t(x)` |
| `collect_set(x)` | `array_agg(DISTINCT x)` |
| `get_json_object(json, '$.a.b')` | `json_query(parse_json(json), '$.a.b')` 或 `json_extract` |
| `from_unixtime(ts)` Hive 毫秒默认 | StarRocks 默认秒，毫秒要先 `/ 1000` |

---

## 修 SQL 场景的专属流程

以下内容只在"用户拿一段已有 SQL 来让你修 / 调试 / 排报错"时启用。写新 SQL 时跳过本节，但"通用检查清单"仍然要过。

修 SQL 时同样遵守上文「字段与表名来源 · 防幻觉」：原 SQL 中的属性若无法在文档或用户材料中核对，**不得**在「修复」中顺带改成另一个臆测字段名；应在诊断中标出 **无据字段** 并让用户确认或删条件。

### 一、修复示例（完整前后对比）

**问题 SQL**（综合了注释格式、占位符、分区不规范、字段名冲突四类问题）：

```sql
#查询 OCR 编辑事件
SELECT `from`, COUNT(DISTINCT _device_id) AS uv
FROM {{event_table}}
WHERE dt BETWEEN '2026-01-01' AND '2026-12-31'
  AND func_name = 'scanedit'
GROUP BY `from`;
```

**修复后**：

```sql
/* 查询 OCR 编辑事件 · 2026 全年 · 按入口分组 */
SELECT `from`,
       COUNT(DISTINCT `_device_id`) AS uv
FROM hive.edw_vas.dwd_ocr_event_i_d   /* 替换占位符：三段式 External Catalog 表名 */
WHERE dt >= '2026-01-01' AND dt < '2027-01-01'   /* 半开区间，明确不含 2027 第一天 */
  AND func_name = 'scanedit'
GROUP BY `from`;
```

修复点清单：
1. `#` 节标题 → `/* */`
2. `{{event_table}}` → 实际三段式表名 `hive.edw_vas.dwd_ocr_event_i_d`
3. `_device_id` → `` `_device_id` ``（下划线开头加反引号保护）
4. `from` 本就是保留字，保持 `` `from` `` 反引号
5. `BETWEEN '2026-01-01' AND '2026-12-31'` → `dt >= '2026-01-01' AND dt < '2027-01-01'`（修 SQL 偏好半开区间，且原写法漏了 12-31 整天？不，`BETWEEN` 含右端，但半开区间更稳）

### 二、修 SQL 的执行流程

遇到修 SQL 请求，按顺序跑完下面 4 步：

1. **语法解析先行**：通读一遍 SQL，把上面 6 类问题过一遍；如果用户贴了报错信息，优先根据报错定位行号
   - 常见报错速查：
     - `Unexpected input '查询'` / `Unexpected input 'xxx'` → 99% 是中文 `--` 注释问题，换 `/* */`
     - `Unknown table 'xxx.yyy'` → 表名缺 `hive.` 前缀，或表确实不存在
     - `Column 'xxx' is ambiguous` → JOIN 时字段没加表别名前缀
     - `OOM` / `Memory exceed limit` → 命中性能隐患，走第 5 项
2. **元数据校验**：如果有 MCP 工具可以查表结构的，调用工具确认表是否存在、分区字段是否为 `dt`、字段名拼写；确认不了就反问用户
3. **规范修正**：补 catalog、修字段引用反引号、换注释格式、补分区裁剪——**一次改完**，不要挤牙膏式每轮改一点
4. **性能兜底**：改完后估算下查询复杂度（`dt` 跨度 × 宽表体量），超标就主动提示"建议拆月跑"并给出拆分示例

### 三、修 SQL 的交付格式

回复结构固定为 3 段：

1. **诊断**：列出检测到的问题（编号 + 所在行为的引用 + 问题类型），3-6 条以内；若存在 **无法在埋点方案或用户材料中核对的字段/取值**，须单独成条标注为「无据」，不得假装已验证
2. **修复后 SQL**：一段完整可执行的 ```sql 代码块
3. **修复点逐条说明**：对应诊断编号，一句话讲明白"为什么这么改"

> 如果用户只贴了报错没贴 SQL，或者 SQL 里信息量太少判断不出业务口径，**先反问一次**再下笔。不要靠猜。

---

## 回复语言与风格

- 回复一律用中文
- SQL 里的**注释也用中文**（参考样例里就是中文注释）
- 不要在 SQL 正文里塞 emoji
- 解释口径时先说"查什么"再说"怎么查"，一段话讲清，不要凑字数
- **诚实兜底**：当前资料里不存在的埋点字段或枚举，直接说 **未收录 / 无法核对**；可给 1～3 个**文档中有据**的相近候选请用户确认，**禁止**用「可能有」「一般叫」等措辞编造列名
- **中英对照**：结果或条件里出现的英文枚举值，尽量同步给出**埋点方案中的中文名称**（见 Step 2「属性值尽量带中文可读名」）；修 SQL 时若原查询缺对照，在修复说明中补上
