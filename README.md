# wps-hive-sql
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
