-- ============================================================
-- WPS Hive SQL 风格参考样例
-- 说明：展示团队惯例，供 wps-hive-sql skill 在产出 SQL 时对齐风格
-- 关键点：
--   1) 表名三段式 hive.{schema}.{table}
--   2) dt 分区，值为 'YYYY-MM-DD' 单引号字符串
--   3) 跨端用 UNION ALL，外层子查询别名 t
--   4) UV 用 COUNT(DISTINCT _account_id / _device_id)
--   5) #xxx 作节标题，-- xxx 作分支业务注释
--   6) WHERE 等号对齐、AND 缩进 2 空格
-- ============================================================

#查询功能点击
SELECT
    COUNT(DISTINCT _account_id) AS export_account_id_cnt
FROM (
    -- Android：保存到相册
    SELECT _account_id
    FROM hive.dw_wps_android.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND page_name    = 'preview_page'
      AND module_name  = 'edit_area'
      AND element_name = 'export_popup'
      AND export_type  = 'export_album'
      AND entry_scene  = 'universal_scanning'

    UNION ALL
    -- iOS：保存到相册
    SELECT _account_id
    FROM hive.dw_wps_ios.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND page_name    = 'preview_page'
      AND module_name  = 'edit_area'
      AND element_name = 'export_popup'
      AND export_type  = 'save_album'
      AND entry_scene  = 'universal_scanning'

    UNION ALL
    -- Android：导出 PDF
    SELECT _account_id
    FROM hive.dw_wps_android.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND element_type = 'button'
      AND module_name  = 'edit_area'
      AND element_name = 'save_export'
      AND page_name    = 'export_preview_page'
      AND file_format  = 'pdf'
      AND entry_scene  = 'universal_scanning'

    UNION ALL
    -- iOS：导出 PDF
    SELECT _account_id
    FROM hive.dw_wps_ios.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND element_type = 'button'
      AND module_name  = 'edit_area'
      AND element_name = 'save_export'
      AND page_name    = 'export_preview_page'
      AND file_format  = 'pdf'
      AND entry_scene  = 'universal_scanning'

    UNION ALL
    -- Android：导出 Word
    SELECT _account_id
    FROM hive.dw_wps_android.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND element_type = 'button'
      AND module_name  = 'edit_area'
      AND element_name = 'save_export'
      AND page_name    = 'export_preview_page'
      AND file_format  = 'writer'
      AND entry_scene  = 'universal_scanning'

    UNION ALL
    -- iOS：导出 Word
    SELECT _account_id
    FROM hive.dw_wps_ios.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND element_type = 'button'
      AND module_name  = 'edit_area'
      AND element_name = 'save_export'
      AND page_name    = 'export_preview_page'
      AND file_format  = 'writer'
      AND entry_scene  = 'universal_scanning'

    UNION ALL
    -- Android：导出表格
    SELECT _account_id
    FROM hive.dw_wps_android.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND element_type = 'button'
      AND module_name  = 'edit_area'
      AND element_name = 'excel_export'
      AND page_name    = 'export_preview_page'
      AND entry_scene  = 'universal_scanning'

    UNION ALL
    -- iOS：导出表格
    SELECT _account_id
    FROM hive.dw_wps_ios.scan_click
    WHERE dt BETWEEN '2026-01-01' AND '2026-01-31'
      AND element_type = 'button'
      AND module_name  = 'edit_area'
      AND element_name = 'excel_export'
      AND page_name    = 'export_preview_page'
      AND entry_scene  = 'universal_scanning'
) t;


#查询功能展示
-- 工具栏-扫描件编辑展示
SELECT dt,
       COUNT(DISTINCT _device_id) AS click_uv
FROM hive.dw_wps_ios.page_show
WHERE dt >= '2026-03-13'
  AND comp      = 'pdf'
  AND func_name = 'scanedit'
  AND page_name = 'scanedit'
  AND position  = 'toolbar'
GROUP BY dt;
