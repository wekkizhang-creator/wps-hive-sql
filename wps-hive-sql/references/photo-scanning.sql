/* ============================================================
 * 拍照扫描（处理页 / 编辑文字页）· SQL 示例库
 * 方言：StarRocks（ScriptIs · starrocks_k8s）
 * 规范：仍以上级 SKILL.md 的 10 条惯例 + 通用检查清单为准；
 *       埋点 key / 属性枚举以 photo-scanning-events-spec.md 为准。
 * ============================================================ */

/* 示例 1：处理页 edit_page · 试卷类型 testpaper · 编辑区完成按钮 · 全端设备 UV */
SELECT COUNT(DISTINCT `_device_id`) AS finish_click_uv
FROM (
    /* Android：完成出编辑选择区 */
    SELECT `_device_id`
    FROM hive.dw_wps_android.scan_click
    WHERE dt >= '2026-01-01' AND dt < '2026-02-01'
      AND page_name    = 'edit_page'
      AND `page_type`  = 'testpaper'
      AND module_name  = 'edit_choose_area'
      AND element_name = 'finish_btn'

    UNION ALL

    /* iOS：完成出编辑选择区 */
    SELECT `_device_id`
    FROM hive.dw_wps_ios.scan_click
    WHERE dt >= '2026-01-01' AND dt < '2026-02-01'
      AND page_name    = 'edit_page'
      AND `page_type`  = 'testpaper'
      AND module_name  = 'edit_choose_area'
      AND element_name = 'finish_btn'
) t;

/* 示例 2：处理页 · 页面级展示 scan_show（试卷）· 按天设备 UV · 单端 iOS */
SELECT dt,
       COUNT(DISTINCT `_device_id`) AS show_uv
FROM hive.dw_wps_ios.scan_show
WHERE dt >= '2026-01-01' AND dt < '2026-02-01'
  AND page_name   = 'edit_page'
  AND `page_type` = 'testpaper'
GROUP BY dt
ORDER BY dt;

/* 示例 3：点击「去除笔迹」编辑类型入口 · 全端设备 UV */
SELECT COUNT(DISTINCT `_device_id`) AS remove_hw_click_uv
FROM (
    SELECT `_device_id`
    FROM hive.dw_wps_android.scan_click
    WHERE dt >= '2026-01-01' AND dt < '2026-02-01'
      AND page_name    = 'edit_page'
      AND module_name  = 'edit_choose_area'
      AND element_name = 'edit_type'
      AND edit_type    = 'remove_handwriting'

    UNION ALL

    SELECT `_device_id`
    FROM hive.dw_wps_ios.scan_click
    WHERE dt >= '2026-01-01' AND dt < '2026-02-01'
      AND page_name    = 'edit_page'
      AND module_name  = 'edit_choose_area'
      AND element_name = 'edit_type'
      AND edit_type    = 'remove_handwriting'
) t;
