# WPS 拍照扫描埋点方案


> **文档说明**：本文档由 Excel 埋点方案转换而来，供大模型理解与分析使用。
>
> - **结构**：基本信息 → 公共属性 → 各页面/模块/元素事件清单 → 特殊场景（小程序、性能等）。
> - **关键字段**：`page_name`（页面标识）、`module_name`（模块标识）、`element_name`（元素标识）、`element_type`（元素类型，如 page/module/button/switch）、`事件`（如 `scan_show` 曝光 / `scan_click` 点击 / `scan_load` 加载 / `scan_stay` 停留）。
> - **路径表达**：`page_name.module_name.element_name` 唯一定位一个埋点；属性为该事件上报的附加 K-V。
> - **跳过的 Sheet**：`【历史总表】行为埋点方案`（已废弃）、`看图业务特有`（无内容）。


## 一、基本信息

| 分类层级 | 中文名称 | 英文标识 |
|---|---|---|
| 应用 | WPS应用 | WPS |
| 终端 | 移动端全端 | Android/iOS/ohos |
| 业务 | wps基础 | WPS |
| 业务过程 | 曝光 | show |
| 业务过程 | 点击 | click |
| 业务过程 | 加载 | load |
| 业务过程 | 停留 | stay |
| 功能 | 拍照扫描 | scan |
| 对应数仓应用 | Wps_Android | dw_wps_android |
| 对应数仓应用 | Wps_iOS | dw_wps_ios |
| 对应数仓应用 | Wps_ohos_mobile | dw_wps_ohos_mobile |
| 扫描相关AI埋点请看这里 | | |
| 📄拍照扫描AI埋点 | | |

## 二、行为埋点公共属性

> 所有拍照扫描相关事件可附带的公共属性（按需上报）。

| 属性名 | 显示名 | 取值/说明 |
|---|---|---|
| `entry_position` | 拍照扫描功能的入口 | homescan \| 首页扫一扫 / homenew \| 首页加号新建-拍照扫描  / apps_search \| 搜索 / servicetopic \| 服务应用-图片转文档应用 / service_camera \| 服务应用-拍照扫描（3月修改） / apps_recent_more \| 应用页最近列表 / apps_banner \| 应用页banner运营位置 / wpsapps \| WPS桌面图标进入 / widgets \| 小组件 / desktop_gadgets \| 桌面快捷方式 / system_albums \| 系统相册 / apps_search_history \| 搜索历史  / apps_search_ranklist \| 搜索排行  / desktop_longpress \| 桌面图标长按（9月新增） / component_word \| 文字组件内插入图片入口（10月新增） / component_word_quickbar \| 文字组件扫描-底部功能区（2025年6月新增） / component_word_insert \| 文字组件扫描-插入tab（2025年6月新增） / component_word_new \| 文字组件新建-扫描录入（2025年11月新增） / component_word_docer \| 文字组件-稻壳（2025年11月新增） / component_excel \| 表格组件内入口（10月新增） / component_excel_quickbar \| 表格组件扫描-底部功能区（2025年6月新增） / component_excel_insert \| 表格组件扫描-插入tab（2025年6月新增） / component_excel_editbar \| 表格组件扫描-编辑框入口（2025年6月新增） / component_ppt \| 演示组件内入口（10月新增） / component_PDF \| PDF组件新建入口（10月新增） / component_PD_scanfile\| 新建pdf-扫描文档转pdf（2025年6月新增） / picture \| 图片入口（10月新增） / serviceimage ｜ 图片处理插件（11月新增） / pc_pdf_scan \| PC_PDF组件新建入口（12月新增） / scan_idphoto \| 拍证件照（12月新增） / app_pull_up \| web回端（2025年5月新增） / wps_latest \| 首页最近列表（2025年5月新增） / wps_all \| 我的文档中的文件夹、文件（2025年5月新增） / wps_mark \| 首页星标列表（2025年5月新增） / cloud_tab \| 除最近/星标列表外的WPS入口（2025年5月新增） / pc_pull_up \| pc拉端（2025年9月新增） / component_word_formula \| 文字组件内插入公式入口（2025年9月新增） / scan_home_more \| 扫描功能落地页/更多页（2026年1月新增） / other \| 其他 （不在上述指定的入口都统一埋其他） |
| `entry_main` | 主入口名称，点击功能入口时上报 | homescan：扫一扫（9月新增） / home_photograph：首页拍摄按钮 / top_recommended_bits：首页顶部金刚区 / scan_search：扫描应用内搜索 / scan_add：拍摄处理页-添加 / preview_add：预览页-添加（9月新增） / H5：功能聚合页（25年2月新增） / preview_page：预览页（2025.08新增） / function_card：首页功能卡片（25年11月新增） / file_page：归档页（26年2&3月版本带出） |
| `entry_scene` | 一级进入场景名称，点击功能入口时上报（默认定位到功能入口也上报） | 如扫描证件 / 扫描证件 \| scan_credentials / 扫描书籍 \| scan_books / 万能扫描 \| universal_scanning / 转Word \| convert_word / 转Excel \| convert_excel / 提取文字 \| text_recognition / 图片翻译 \| image_translation / 扫一扫 \| scan（9月新增） / 转pdf \| convert_pdf （9月新增） / 转ppt \| convert_ppt （9月新增） / 扫描试卷｜scan_testpaper（11月新增） / 扫描票据 \| scan_receipt（12月新增） / 扫描证件照/拍证件照 \| scan_idphoto（12月新增） / erase \| 图片涂抹消除（11月新增） / removehandwriting \| 图片去除字迹（11月新增） / removeshadow \| 图片去阴影（11月新增） / removescreenlines \| 图片去屏纹（11月新增） / watermark \| 图片加水印（11月新增） / splice \| 图片拼接（11月新增） / picparting \| 图片分割（11月新增） / formula \| 公式识别（2025年9月新增） / ai_answers \| AI解题（2025年9月新增） / component_excel_scan \| 表格组件内扫码录入（2025年 11月新增） / scan_ppt \| 扫描PPT（2025年11月新增） / format_conversion \| 格式转换（2025年12月新增） / function_page \| 功能落地页（2025年12月新增） / data_extraction \| 取数录表（2025年12月新增） / collecting_mistakes \| 收集错题（2025年12月新增） / remove_handwriting \| 去除笔迹（2025年12月新增） / generate_pic \| 拍照生成（2026年4月新增） / other \| 其他 （不在上述指定的入口都统一埋其他） |
| `second_entry_scene` | 二级进入场景名称，点击功能入口时上报，同时entry_scene也需要上报（默认定位到功能入口也上报） | 如扫描身份证 / 通用证件 \| universal_card / 身份证 \| identification_card / 户口本 \| household_registration_booklet / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driver_license / 全部 \| all_card / 学生证 \| student_id_card / 证书 \| certificate / 毕业证 \| graduate_certificate（26年2月新增，其余见证件场景特有） / 拍证件照尺寸切换：具体tab名称 / 扫描试卷二级场景：具体tab名称（25年4月新增） / 图片转表 \| image_to_excel（25年10月新增） / 取数录表 \| data_extraction（25年10月新增） / 转pdf \| convert_pdf（25年12月新增） / 转word \| convert_word（25年12月新增） / 转excel \| convert_excel（25年12月新增） / mindmap \| 思维导图（2026年4月新增） / flowchart \| 流程图（2026年4月新增） / structural_diagram \| 结构图（2026年4月新增） |
| `action_id` | 拍照扫描场景id，点击首页或者扫描聚合页任一位置展示扫描拍摄页时生成，一直透传到导出保存成功落地页 | 32位的UUID，格式是xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx，保证全局唯一 |
| `track_id` | 拍照扫描主链路ID，点击拍照页拍照按钮时生成，多张拍摄点击返回再重点击拍摄则重新生成一次，一直透传到导出保存成功落地页 | 32位的UUID，格式是xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx，保证全局唯一 |
| `klm` | 触发埋点的位置信息，由多个字段拼接而成 | KLM拼接」func.page_name(page_position).module_name(module_position)-second_module_name(second_module_position).element_name[element_type](element_position) |
| `pre_klm` | 来源页面的点击的点位信息 | 同klm |
| `element_position` | 元素索引位置，若埋点方案中此列写了x，则需要把元素的位置索引上报，如1、2、3、4 |  |
| `cloud_sync_status` | 扫描云同步开关的开启状态 | 0:代表用户已关闭 / 1:代表用户已开启 |
| `产品验收` |  |  |
| `ii` |  |  |

## 三、页面/模块埋点详情


> 按页面（H3）→ 模块 → 元素 组织。每个模块以表格列出其下所有元素事件与属性。


## 拍摄页


### 扫描拍摄页面 `scan_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 判断当前四边形检测模型 | `cloud_sync_status` 云同步开启状态 = 0\|1 ；`model` 模型版本 = yolo：四边形检测新模型 / old：旧模型 |
| — |  | page | scan_stay |  | `duration` 停留时长/ms |
| — |  | page | scan_load |  | `duration` 加载时长/ms |

**模块：拍照设置区域** `photo_set`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 拍照页面设置 `number_set` |  | button | scan_click | 点击设置页数 | `number_type` 拍照页面类型 = single:单张 / multiple:多张 |
| 画质 `picture_quality` |  | button | scan_click | 清晰度点击时 | `picture_quality` 画质 = UHD：超清 / HD：高清 / SD：省流 |
| 闪光灯 `flash` |  | button | scan_click | 点击闪光灯时 | `status` 闪光灯开启状态 = open:闪光灯开启 / close:闪光灯关闭 / auto：闪光灯自动 / flashlight：闪光灯常亮 |
| 返回按钮 `back` |  | button | scan_click |  |  |
| 网格线 `grid` |  | button | scan_click | 点击网格线时 | `status` 闪光灯开启状态 = open:打开 / close:关闭 |
| 摄像头切换 `camera_switching` |  | button | scan_click | 点击切换摄像头 | `status` 摄像头状态 = front：前置摄像头 / rear：后置摄像头 |

**模块：扫描切换区域** `photo_scene`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 扫描类型 `scene` |  | button | scan_click | 场景点击时 | `scene` 扫描场景 = 行为埋点公共属性!C5 ；`source` 切换场景方式 = capture_button：从侧边拍摄按钮切换 |
| 扫描类型 `scene` |  | page | scan_show | 场景点击时 | `scene` 扫描场景 = 行为埋点公共属性!C5 |
| 扫描类型 `scene` |  | page | scan_show | 场景滑动切换时 | `scene` 扫描场景 = 行为埋点公共属性!C5 |
| 子扫描类型 `second_scene` |  | button | scan_click | 场景点击时 | `second_scene` 二级场景，如身份证、户口、驾驶证 = 行为埋点公共属性!C6 ；`isActiveClick` 区分主动点击和默认跳转 = 1:主动点击 / 0:默认跳转 |
| 自动识别切换 `change` |  | button | scan_click | 切换按钮点击时 | `scene` 识别到的场景 ；`second_scene` 识别到的子场景 ；`tip_text` 提示文案 |

**模块：创建区** `create_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 拍照按钮 `photograph` |  | button | scan_click | 点击拍照按钮时 | `number_type` 拍照页面类型 = single:单张 / multiple:多张 ；`scene` 扫描一级场景 = 行为埋点公共属性!C5 ；`second_scene` 二级场景，如身份证、户口、驾驶证 = 行为埋点公共属性!C6 ；`model` 模型版本 = yolo：四边形检测新模型 / old：旧模型 |
| 导入 `import` |  | page | scan_show | 导入方式面板展示 |  |
| 导入 `import` |  | button | scan_click | 按钮点击时 | `import_way` 导入方式 = file:文件导入 / photo:相册导入 / wpsalbum:WPS相册（11月新增） / wechat_pic：微信图片（2025.09新增） / wechat_file：微信文件（2025.09新增） |
| 多张拍照后下一步 `multiple_photograph` |  | button | scan_click | 点击下一步时； / 导入图片、文件进入处理页时 | `numbers` 用户拍照的张数 = 比如1，2，3 ；`scene` 扫描一级场景 = 行为埋点公共属性!C5 ；`second_scene` 二级场景，如身份证、户口、驾驶证 = 行为埋点公共属性!C6 ；`scan_type` 拍摄方式 = photograph：拍摄 / file:文件导入 / photo:图片导入 ；`model` = yolo：四边形检测新模型 / old：旧模型 |
| 多张拍照后返回 `back` |  | button | scan_click | 多张拍照后返回时 | `number_type` 拍照页面类型 = single:单张 / multiple:多张 ；`numbers` 用户拍照的张数 ；`scene` 扫描场景 = · ；`second_scene` 二级场景，如身份证、户口、驾驶证 = 行为埋点公共属性!C6 |

**模块：新手引导提示** `convert_excel_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 图片转表新手引导提示 `image_to_excel_tips` |  | module | scan_show | 提示条曝光时 |  |
| 取数录表新手引导提示 `data_extraction_tips` |  | module | scan_show | 提示条曝光时 |  |
| 立即拍摄 `shoot` |  | button | scan_click | 点击时 |  |

**模块：新手引导提示** `guide_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 图转PPT新手提示 `convert_ppt_tips` |  | module | scan_show | 提示曝光时 | `scene` 场景 = scan_ppt |
| 立即拍摄 `shoot` |  | button | scan_click | 按钮点击时 | `duration` 停留时长/ms |

**模块：新手引导提示** `credential_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 立即拍摄 `shoot` |  | button | scan_click | 按钮点击时 |  |
| 拍照按钮 `photograph` |  | button | scan_click | 按钮点击时 |  |

**模块：新手扫码引导提示** `scancode_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 拍照按钮 `photograph` |  | page | scan_show | 引导提示曝光时 |  |
| 拍照按钮 `photograph` |  | button | scan_click | 按钮点击时 | `button_name` 立即拍摄 = immediate_shoot |

**模块：二维码 / 条形码识别** `qr_barcode_recognition`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 轻提示 `light_tips` |  | module | scan_show | 轻提示曝光时 | `tip_type` 提示条类型 = login_desktop：登录桌面端  / screen_mirroring：投屏 / mobile_remote_control：手机遥控 / domain_jump：域名跳转 / barcode_light ：条形码或二维码 |
| 轻提示 `light_tips` |  | button | scan_click | 按钮点击时 | `button_name` 轻提示按钮名 = login/login_close：登录 / project/project_close：投影 remote_control/remote_control_close：遥控  / access/access_close：访问 / copy/copy_close：复制 |

## 首页


### 首页 `homepage`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show |  | `cloud_sync_status` 云同步开启状态 = 0\|1 |
| — |  | page | scan_stay |  | `duration` 停留时长/ms |
| — |  | page | scan_load |  | `duration` 加载时长/ms |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 搜索按钮 `search_bar` |  | button | scan_click | 按钮点击时 |  |
| 更多菜单按钮 `menu_btn` |  | button | scan_click | 按钮点击时 |  |
| 关闭按钮 `close` |  | button | scan_click | 按钮点击时 |  |

**模块：菜单面板** `menu_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 菜单功能按钮 `menu_sub_btn` |  | button | scan_click | 按钮点击时 | `function_name` 功能名称 = settings:功能设置 / feedback：反馈 / add_desktop:添加到桌面 |

**模块：添加到桌面** `add_desktop`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 弹窗展示时 | `page_source` 页面来源 = 主动点击：active / 被动下发：passive |
| 确认 `confirm` |  | button | scan_click | 按钮点击时 | `page_source` 页面来源 = 主动点击：active / 被动下发：passive |
| 取消 `cancel` |  | button | scan_click | 按钮点击时 | `page_source` 页面来源 = 主动点击：active / 被动下发：passive |

**模块：。** `scan_settings`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 设置界面 `settings` |  | page | scan_show |  |  |
| 设置界面 `settings` |  | page | scan_stay |  | `duration` 停留时长/ms |
| 设置界面 `settings` |  | page | scan_load |  | `duration` 加载时长/ms |
| 设置界面 `settings` |  | button | scan_click | 按钮点击时 | `function_name` = batch_export ；`batch_export` = export：导出 / cancel：取消 ；`batch_export_process` = cancel：取消 |
| 设置界面 `settings` |  | switch | scan_click | 按钮点击时 | `cloud_sync` = 0｜1，报用户执行后的结果，比如从开到关，就报0即可 ；`celluar_data` = 0｜1 ；`quailty_improvement` = 0｜1 |

**模块：功能卡片** `function_card`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 卡片按钮 `card_btn` | x | button | scan_click | 卡片点击时 | `card_name` 卡片名称 = 万能扫描 \| universal_scanning / 格式转换 \| format_conversion / 转Word \| convert_word / 转PDF \| convert_pdf / 提取文字 \| text_recognition / 扫描证件 \| scan_credentials |
| 卡片按钮 `card_btn` | x | button | scan_show | 卡片曝光时 | `card_name` 卡片名称 = 万能扫描 \| universal_scanning / 格式转换 \| format_conversion / 转Word \| convert_word / 转PDF \| convert_pdf / 提取文字 \| text_recognition / 扫描证件 \| scan_credentials |

**模块：功能区域** `function_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 功能按钮 `function_btn` | x | button | scan_show | 功能曝光时 | `function_name` 功能名称 = 扫描证件 \| scan_credentials / 扫描书籍 \| scan_books / 扫描 \| universal_scanning / 转Word \| convert_word / 转Execl \| convert_execl / 提取文字 \| text_recognition / 图片翻译 \| image_translation / 去除笔迹 \| remove_handwriting（10月新增） / 扫描试卷｜scan_testpaper（11月新增） / 扫描票据 \| scan_receipt（12月新增） / 拍证件照 \| scan_idphoto（12月新增） / more \| 更多（26年1月新增） |
| 功能按钮 `function_btn` | x | button | scan_click | 功能点击时 | `function_name` 功能名称 = 扫描证件 \| scan_credentials / 扫描书籍 \| scan_books / 扫描 \| universal_scanning / 转Word \| convert_word / 转Execl \| convert_execl / 提取文字 \| text_recognition / 图片翻译 \| image_translation / 去除笔迹 \| remove_handwriting（10月新增） / 扫描试卷｜scan_testpaper（11月新增） / 扫描票据 \| scan_receipt（12月新增） / 拍证件照 \| scan_idphoto（12月新增） / more \| 更多（26年1月新增） |
| 全部功能按钮 `all` | x | button | scan_click | 按钮点击时 |  |

**模块：导入区域** `import_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导入方式 `import` | x | button | scan_show | 导入按钮曝光时 | `import_way` 导入方式 = wechat:微信导入 / photo:相册导入 / file:文件导入 |
| 导入方式 `import` | x | button | scan_click | 导入按钮点击时 | `import_way` 导入方式 = wechat:微信导入 / photo:相册导入 / file:文件导入 |
| 导入方式 `import` | x | button | scan_result | 完成导入时 | `file_type` 导入类型 = pdf/word/ppt/excel：文件 / photo：图片 |

**模块：扫描文档列表** `file_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  | `file_count` 文档数量 |
| 文件 `file` | x | button | scan_show | 文件曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 文件 `file` | x | button | scan_click | 文件点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 选择按钮 `select` | x | button | scan_click | 按钮点击时 |  |
| 查看更多按钮 `more` | x | button | scan_click | 按钮点击时 |  |
| 全部文档按钮 `all` | x | button | scan_click | 按钮点击时 |  |

**模块：banner运营位** `banner`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 运营位 `banner` | x | button | scan_show | 功能曝光时 | `activity_name` 活动名 |
| 运营位 `banner` | x | button | scan_click | 功能点击时 | `activity_name` 活动名 |
| 关闭按钮 `close` | x | button | scan_click | 功能点击时 | `activity_name` 活动名 |

**模块：新手引导区域** `guide_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show | 区域展示时 |  |
| 进入 `entry` | x | button | scan_click | 按钮点击时 | `function_name` 功能 = 万能扫描 \| universal_scanning / 扫描试卷｜scan_testpaper / 扫描书籍 \| scan_books |

**模块：创建区** `create_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 拍照按钮 `photograph` | x | button | scan_click | 点击拍照按钮时 |  |
| 侧边拍照按钮（iPhone16以上） `capture_button` | x | button | scan_click | 从侧边拍照按钮进入拍摄时 |  |

**模块：扫描权益中心** `scan_user_center`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show | 功能曝光时 |  |
| 扫描权益中心入口 `user_center_entry` | x | button | scan_click | 功能点击时 |  |

**模块：提示条** `scan_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 会员临过期提示 `membership_expiration` | x | module | scan_show | 模块曝光时 |  |
| 立即续费 `renewal` | x | button | scan_click | 功能点击时 |  |
| 关闭按钮 `close` | x | button | scan_click | 功能点击时 |  |

**模块：首页底部工具栏** `homepage_toolbar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 首页tab `tab_homepage` | x | button | scan_click | 功能点击时 |  |
| 扫描件tab `tab_allfile` | x | button | scan_click | 功能点击时 |  |

### 搜索结果页 `search_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page |  |  |  |
| — | x | page | scan_show |  |  |
| — | x | page | scan_stay |  | `duration` 停留时长/ms |
| — | x | page | scan_load |  | `duration` 停留时长/ms |

**模块：搜索模块** `search`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 主动搜索 `active_search` | x | button | scan_click | 主动搜索时 | `keyword` 搜索词 |
| 历史搜索 `history_search` | x | button | scan_click | 历史搜索词点击时 | `keyword` 搜索词 |
| 取消 `cancel` | x | button | scan_click | 按钮点击时 |  |

**模块：搜索历史** `history`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 暂无搜索记录 `null_searchrecord` | x | module | scan_show |  |  |
| 清除历史 `clear` | x | button | scan_click | 按钮点击时 |  |

**模块：提示** `tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 网络不可用 `network_unavailable` | x | module | scan_show |  |  |
| 搜索异常 `anomaly` | x | module | scan_show |  |  |
| 搜索历史已清空 `history_clear` | x | module | scan_show |  |  |

**模块：分类筛选区域** `category_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 分类tab `cat` | x | button | scan_show | 分类tab曝光时 | `cat_name` 分类tab名称 = all:全部 / toolbox:工具箱 / file:扫描件 |
| 分类tab `cat` | x | button | scan_click | 分类tab点击时 | `cat_name` 分类tab名称 = all:全部 / toolbox:工具箱 / file:扫描件 |

**模块：搜索结果模块（有内容）** `search_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 文件 `file` | x | button | scan_show | 文件曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`keyword` 搜索词 ；`workboard` 所属分类 = all:全部 / toolbox:工具箱 / file:扫描件 |
| 文件 `file` | x | button | scan_click | 文件点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`keyword` 搜索词 ；`workboard` 所属分类 = all:全部 / toolbox:工具箱 / file:扫描件 |
| 功能 `function_btn` | x | button | scan_show | 功能曝光时 | `function_name` 功能名称 = 扫描证件 \| scan_credentials / 扫描书籍 \| scan_books / 扫描 \| universal_scanning / 转Word \| convert_word / 转Execl \| convert_execl / 提取文字 \| text_recognition / 图片翻译 \| image_translation / 扫描试卷｜scan_testpaper（11月新增） / 扫描票据 \| scan_receipt（12月新增） / 拍证件照 \| scan_idphoto（12月新增） ；`keyword` 搜索词 ；`workboard` 所属分类 = all:全部 / toolbox:工具箱 / file:扫描件 |
| 功能 `function_btn` | x | button | scan_click | 功能点击时 | `function_name` 功能名称 = 扫描证件 \| scan_credentials / 扫描书籍 \| scan_books / 扫描 \| universal_scanning / 转Word \| convert_word / 转Execl \| convert_execl / 提取文字 \| text_recognition / 图片翻译 \| image_translation / 扫描试卷｜scan_testpaper（11月新增） / 扫描票据 \| scan_receipt（12月新增） / 拍证件照 \| scan_idphoto（12月新增） ；`keyword` 搜索词 ；`workboard` 所属分类 = all:全部 / toolbox:工具箱 / file:扫描件 |
| 文件夹 `folder` | x | button | scan_show | 文件曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`keyword` 搜索词 ；`workboard` 所属分类 = all:全部 / toolbox:工具箱 / file:扫描件 |
| 文件夹 `folder` | x | button | scan_click | 文件点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`keyword` 搜索词 ；`workboard` 所属分类 = all:全部 / toolbox:工具箱 / file:扫描件 |

**模块：搜索无结果** `null_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  |  |

### 功能落地页 `function_page`


**模块：$ 页面级事件** `null_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show |  |  |
| — | x | page | scan_load |  | `duration` 停留时长/ms |
| — | x | page | scan_stay |  | `duration` 加载时长/ms |

**模块：功能卡片** `function_card`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 卡片按钮 `function_btn` | x | button | scan_show | 功能卡片曝光时 | `function_name` 卡片名称 = 万能扫描 \| universal_scanning / 转Word \| convert_word / 转Execl \| convert_execl / 提取文字 \| text_recognition / 扫描PPT \| scan_ppt / 取数录表 \| data_extraction / AI解题 \| ai_answers / 收集错题 \| collecting_mistakes / 转PDF \| convert_pdf / 扫描证件 \| scan_credentials / 扫描书籍 \| scan_books / 去除笔迹 \| remove_handwriting / 图片翻译 \| image_translation / 扫描试卷｜scan_testpaper / 扫描票据 \| scan_receipt / 拍证件照 \| scan_idphoto |
| 卡片按钮 `function_btn` | x | button | scan_click | 功能卡片点击时 | `function_name` 卡片名称 = 万能扫描 \| universal_scanning / 转Word \| convert_word / 转Execl \| convert_execl / 提取文字 \| text_recognition / 扫描PPT \| scan_ppt / 取数录表 \| data_extraction / AI解题 \| ai_answers / 收集错题 \| collecting_mistakes / 转PDF \| convert_pdf / 扫描证件 \| scan_credentials / 扫描书籍 \| scan_books / 去除笔迹 \| remove_handwriting / 图片翻译 \| image_translation / 扫描试卷｜scan_testpaper / 扫描票据 \| scan_receipt / 拍证件照 \| scan_idphoto |

**模块：用户故事区** `user_story_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 用户故事卡片 `story_card` | x | module | scan_show | 曝光时 |  |
| 用户故事卡片 `story_card` | x | module | scan_click | 点击时 |  |

**模块：banner运营位** `banner`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 运营位 `banner` | x | button | scan_show | 功能曝光时 | `activity_name` 活动名 |
| 运营位 `banner` | x | button | scan_click | 功能点击时 | `activity_name` 活动名 |
| 关闭按钮 `close` | x | button | scan_click | 功能点击时 | `activity_name` 活动名 |

## 扫描后的图片处理页

> **Sheet 说明**：全部功能扫描后的页面展示以及点击，统一上报page_name：edit_page / 不同页面点击模块不一致的情况下，通过module_name等后置属性区分： / 扫描、扫描证件、扫描书籍、转excel，module_name上报一致均为：edit_choose_area / 转word：直接进入裁切区，故module_name上报：cropping_area / 提取文字：module_name上报 extract_area / 图片翻译：module_name上报 imagetranslation_area / 扫描票据：module_name上报 scan_receipt / 公式识别：module_name上报 scan_formula


### 处理页 `edit_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 页面展示时 | `page_type` 页面类型 = general \| 通用型 ；`page_type` 页面类型 = card \| 证件 ；`page_type` 页面类型 = testpaper｜试卷（12月新增） ；`page_type` 页面类型 = receipt \| 票据（12月新增） ；`page_type` 页面类型 = ocr_paragraph \| 提取文字_按段提取 / ocr_words \| 提取文字_按字提取 ；`2025年12月新增` ；`recognize_result / （仅iOS，安卓是在load时）` 分类识别结果 = 通用证件 \| universal_card / 身份证 \| identification_card / 户口本 \| household_registration_booklet / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driver_license / 试卷｜testpaper / 票据｜receipt（12月新增） / 其它\|other ；`通用证件 \| universal_card / 身份证 \| id_card / 户口本 \| household_registration_book / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driving_license  / 试卷｜handwritten_test_paper / 票据｜receipt / 其它\|others / 社保卡\|social_security_card` ；`default_filter` 默认滤镜 = source：原图 / optimization：优化 / intelligent：智能 / sharpen：锐化 / enhance：增强 / blackwhite：黑白 / grayscale：灰度 / inksaving：省墨 ；`（25年1月新增）` ；`model` 模型版本 = yolo：四边形检测新模型 / old：旧模型 |
| — |  | page | scan_stay | 页面停留 | `duration` 停留时长/ms ；`page_type` 页面类型 ；`page_type` 页面类型 = card \| 证件 ；`page_type` 页面类型 = testpaper｜试卷（12月新增） ；`page_type` 页面类型 = receipt \| 票据（12月新增） |
| — |  | page | scan_load | 页面加载 | `duration` 加载时长/ms ；`duration` recognize_result / （仅安卓， iOS是在show时） = 通用证件 \| universal_card / 身份证 \| identification_card / 户口本 \| household_registration_booklet / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driver_license / 试卷｜testpaper / 票据｜receipt（12月新增） / 其它\|other ；`duration` = general \| 通用型 ；`duration` = card \| 证件 ；`duration` = testpaper｜试卷（12月新增） ；`duration` = receipt \| 票据（12月新增） |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 关闭按钮 `close` |  | button | scan_click | 按钮点击时 |  |
| 图片管理 `image_manage` |  | button | scan_click | 按钮点击时 |  |
| 问题反馈 `feedback` |  | button | scan_click | 按钮点击时 |  |

**模块：模式切换** `mode_switching`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 页面展示时 | `current_model` 当前属性 |
| 进入 `entry` |  | button | scan_click | 按钮点击时 | `current_model` 当前属性 |
| 切换 `switch` |  | button | scan_click | 按钮点击时 | `current_model` 当前属性 ；`target_model` 目标属性 |
| 关闭 `close` |  | button | scan_click | 按钮点击时 |  |

**模块：编辑类型选择区域** `edit_choose_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮 `finish_btn` |  | button | scan_click | 按钮点击时 | `is_filter` 是否切换过滤镜 = true:是 / false:否 ；`（25年1月修改）` ；`统计是否点击切换过滤镜` ；`mode_switch` 模式切换 = 上报格式：“进入时模式；点击完成时的模式”（用分号隔开） / 上报示例：“universal_scanning；cert” / 通用：universal_scanning / 证件：cert / 试卷：paper / 票据：receipt ；`（25年1月新增）` ；`filter` 使用的滤镜名称 = source：原图 / optimization：优化 / intelligent：智能 / sharpen：锐化 / enhance：增强 / blackwhite：黑白 / grayscale：灰度 / inksaving：省墨 ；`（25年1月新增）` ；`is_cropping` 是否主动使用过裁切旋转 = true:是 / false:否 ；`copy_type` 是否有使用过提取文字 = true:是 / false:否 ；`mark_type` 是否有使用过标注 = true:是 / false:否 ；`is_watermark` 是否有添加水印 = true:是 / false:否 ；`is_remove_handwriting` 是否应用去除笔迹 = true:是 / false:否 ；`（10月新增）` ；`is_removewatermar` 是否应用AI去水印 = true:是 / false:否 ；`AI去水印（12月新增）` ；`is_extracted` 是否提取识别 = true:是 / false:否 ；`扫描票据（12月新增）` ；`is_remove_headblock` 是否应用AI去遮挡 = true:是 / false:否 ；`2026.01新增` ；`picture_count` 选择的上传的图片数量 ；`is_change_filter` 是否改变默认滤镜 = true：是 / false：否 ；`（25年1月新增）` ；`统计默认滤镜是否进行更改` ；`is_reedit` 是否二次编辑 = true：是 / false：否 ；`import_way` 导入方式 = Android： / photograph \| 拍摄 / photo \| 相册导入 / file \| 文件导入 / iOS： / home_photo \| 首页相册 / home_file \| 首页文件 / home_wechat \| 首页微信 / scan_page_photo \| 拍摄页相册 / scan_page_file \| 拍摄页文件 / photograph \| 拍摄 ；`（25年12月新增）` ；`model` 模型版本 = yolo：四边形检测新模型 / old：旧模型 ；`format_type` 证件布局类型 = single : 单张 / left_right : 左右 / top_bottom : 上下 / fit : 适应纸张 ；`（26年2&3月新增）` |
| 对比 `compare` |  | button | scan_click | 按钮点击时 |  |
| 重新拍照 `reset_photograph` |  | button | scan_click | 按钮点击时 |  |

**模块：编辑类型选择区域** `edit_choose_area / （提取文字在x.23版本改为图片预览区，module_name=extract_area）`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 编辑类型选择 `edit_type` |  | button | scan_click | 按钮点击时 | `edit_type` 编辑类型 = filter:滤镜 / cropping_area:裁剪 / extract:提取文字 / mark:页面标注 / erase：涂抹消除 / remove_handwriting：去除笔迹 / watermart：水印 / convert_word：转word（2025.04新增） / ai_answers：AI解题 / convert_excel：转Excel（2025.07新增） / convert_ppt：转PPT（2025.11新增） / remove_headblock：AI去遮挡（2026.01新增） |

**模块：滤镜编辑区** `filter_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 滤镜选择 `filter_choose` |  | button | scan_click | 点击滤镜时 | `filter` 滤镜名称 = 原图：source / 优化：optimization / 智能：intelligent / 锐化：sharpen / 增强：enhance / 黑白：blackwhite / 灰度：grayscale / 省墨：inksaving ；`（25年1月新增）` |

**模块：裁剪编辑区** `cropping_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮 `finish_btn` |  | button | scan_click | 按钮点击时 | `is_croping` 是否裁切旋转 = true:是 / false:否 ；`转word` ；`model` 模型版本 = yolo：四边形检测新模型 / old：旧模型 |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |

**模块：提取文字区域** `extract_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 复制按钮 `copy_btn` |  | button | scan_click | 按钮点击时 | `copy_type` 复制类型 = copy_words：复制文字(用于按字选择的复制按钮) / copy：复制内容（用于按段选择的复制按钮）copy_currentpage：复制当页（.29.0新增） ；`原图对照` image_text_comparison(（10月新增） = on：开启 / off：关闭 ；`copy_type` 复制类型 = copy_words：复制文字(用于按字选择的复制按钮) / copy：复制内容（用于按段选择的复制按钮）copy_currentpage：复制当页（.29.0新增） ；`提取类型` extract_type = paragraph：按段提取 / words：按字提取 / extract_deep:深度提取（2025年12月新增） ；`（.29.0新增）` ；`copy_type` 复制类型 = copy_words：复制文字(用于按字选择的复制按钮) / copy：复制内容（用于按段选择的复制按钮）copy_currentpage：复制当页（.29.0新增） ；`提取模式` extract_mode = extract_deep:深度提取 / extract_fast：快速提取 ；`2025.12新增` |
| 提取类型 `extract_type` |  | button | scan_click | 按钮点击时 | `extract_type` 提取类型 = paragraph：按段提取 / words：按字提取 |
| 全选当页 `select_all` |  | button | scan_click | 按钮点击时 |  |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |
| 提取结果 `extract_result` |  | page | scan_show | 进入页面时 | `extract_type` 提取类型 = paragraph：按段提取 / words：按字提取 / extract_deep:深度提取 ；`2025.12新增` |
| 导出文档 `export_file` |  | button | scan_click | 按钮点击时 | `extract_type` 提取类型 = （x.17.0新增） / paragraph：按段提取 / words：按字提取 / extract_deep:深度提取（2025年12月新增） ；`原图对照` image_text_comparison = on：开启 / off：关闭 ；`extract_type` 提取类型 = （x.17.0新增） / paragraph：按段提取 / words：按字提取 / extract_deep:深度提取（2025年12月新增） ；`提取模式` extract_mode = extract_deep:深度提取 / extract_fast：快速提取 ；`2026.2&3新增` ；`extract_type` 提取类型 = （x.17.0新增） / paragraph：按段提取 / words：按字提取 / extract_deep:深度提取（2025年12月新增） ；`确认导出的图片数量` picture_count ；`2026.04新增` |
| 原图校对 `image_contrast` |  | button | scan_click | 按钮点击时 | `is_on` 是否开启原图校对 = on:开启原图校对 / off:关闭原图校对 / （.29.0新增） |
| 深度提取 `extract_deep` |  | button | scan_click | 按钮点击时 | `2025.12新增` |
| 选择方式 `select_type` |  | button | scan_click | 按钮点击时 | `select_type` 选择方式 = paragraph：按段提取 / words：按字提取 ；`2025.12新增` |

**模块：提取模式弹窗** `extract_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 弹窗展示时 | `2025.12新增` |
| 深度提取 `extract_deep` |  | button | scan_click | 按钮点击时 | `2025.12新增` |
| 快速提取 `extract_fast` |  | button | scan_click | 按钮点击时 | `2025.12新增` |
| 关闭 `close` |  | button | scan_click | 按钮点击时 | `2025.12新增` |

**模块：页面标注区域** `mark_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮 `finish_btn` |  | button | scan_click | 按钮点击时 | `mark_type` 标注类型，多个标注类型用英文逗号分割 = letter：文字 / pen：画笔 / watermark：水印 / mosaic：马赛克 |
| 继续添加 `add_letter` |  | button | scan_click | 按钮点击时 |  |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |

**模块：涂抹消除区域** `erase_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 确认（完成）按钮 `finish_btn` |  | button | scan_click | 按钮点击时 |  |
| 取消按钮 `cancel` |  | button | scan_click | 按钮点击时 |  |
| 消除按钮 `erase` |  | button | scan_click | 按钮点击时 |  |

**模块：图片翻译** `imagetranslation_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮(导出为Word) `finish_btn` |  | button | scan_click | 按钮点击时 | `mark_type` 导出为图片类型 = 原图：original  / 译图：translate ；`picture_count` 确认导出的图片数量 ；`（2026.04新增）` |
| 复制按钮 `copy_btn` |  | button | scan_click | 按钮点击时 | `copy_type` 复制类型 = 全部复制：copy_all / 局部复制：copy_part |
| 保存图片 `save_picture` |  | button | scan_click | 按钮点击时 |  |
| 保存图片-二级保存 `save_topicture` |  | button | scan_click | 按钮点击时 | `picture_type` 保存为图片类型 = 仅译图：translate / 原图+译图：original_translate |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |

**模块：扫描票据（25年3月更新）** `scan_receipt`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 提取识别 `structured_extract` |  | button | scan_click | 按钮点击时 | `扫描票据（25年3月更新）` |
| 复制全部 `copy_all` |  | button | scan_click | 按钮点击时 | `扫描票据（25年3月更新）` |
| 复制单行 `copy_part` |  | button | scan_click | 长按字段时 | `扫描票据（25年3月更新）` |
| 双击编辑 `edit_receipt` |  | button | scan_click | 字段双击时 | `edit_type` 编辑的字段类型 = 字段type：中文名称 / 📄票据编辑信息识别字段 ；`扫描票据（25年3月更新）` ；`is_cloud_popup` 是否弹出上云提示 = true：是 / false：否 ；`扫描票据（25年3月更新）` |
| 完成按钮 `finish_btn` |  | button | scan_click | 按钮点击时 | `edit_type` 编辑的字段类型 = 字段type：中文名称 / 📄票据编辑信息识别字段 ；`扫描票据（25年3月更新）` ；`此处的“完成”按钮实际为提取识别编辑栏的“确认”按钮，实际触发时机为点击“确定”时` |
| 问题反馈 `feedback` |  | button | scan_click | 按钮点击时 | `扫描票据（25年3月更新）` |

**模块：扫描证件（26年2月新增）** `scan_credentials`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 布局 `format` |  | button | scan_click | 按钮点击时 | `format_type` 布局类型 = single \| 单张 ；`format_type` 布局类型 = left_right \| 左右 ；`format_type` 布局类型 = top_bottom \| 上下 ；`format_type` 布局类型 = fit \| 适应纸张 |

**模块：公式识别（2025年9月新增）**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | -- | page | scan_show | 页面展示时 | `page_type` 页面类型 = general \| 通用型 ；`公式识别（2025年9月新增）` ；`default_filter` 默认滤镜 = source：原图 ；`公式识别（2025年9月新增）` ；`page_source` 页面来源 = scan_page \| 拍摄页面 / testpaper_edit_page \| 试卷处理页 ；`公式识别（2025年9月新增）` |
| — | -- | page | scan_load | 页面加载 | `duration` 加载时长/ms ；`公式识别（2025年9月新增）` |
| — | -- | page | scan_stay | 页面停留 | `duration` 停留时长/ms ；`公式识别（2025年9月新增）` |

**模块：公式识别（2025年9月新增）** `scan_formula`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导出文档 `export_file` | -- | button | scan_click | 按钮点击时 | `formula_num` 公式数量 = 导出的公式总量 ；`公式识别（2025年9月新增）` |
| 插入到文字组件 `insert_mobile` | -- | button | scan_click | 按钮点击时 | `formula_num` 公式数量 = 导出的公式总量 ；`公式识别（2025年9月新增）` |
| 发送到PC `insert_pc` | -- | button | scan_click | 按钮点击时 | `formula_num` 公式数量 = 导出的公式总量 ；`公式识别（2025年9月新增）` |
| 识别结果提示 `result_tips` | -- | module | scan_show | 弹窗展示时 | `result` 识别结果 = failed \| 导出失败 / no_result \| 未识别到公式 / exit \| 退出挽留弹窗 / all_no_result \| 所有图片未识别到公式 ；`公式识别（2025年9月新增）` |
| 识别结果提示 `result_tips` | -- | button | scan_click | 按钮点击时 | `action` 取消 = cancel ；`公式识别（2025年9月新增）` ；`action` 退出 = exit ；`公式识别（2025年9月新增）` ；`action` 重新拍摄 = re_photograph ；`公式识别（2025年9月新增）` ；`action` 确定 = confirm ；`公式识别（2025年9月新增）` |
| 问题反馈 `feedback` | -- | button | scan_click | 按钮点击时 | `公式识别（2025年9月新增）` |

**模块：进度条加载区域（25年1月新增）** `progress_load_area / （转PPT上报为convert_load_area）`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 取消按钮 `cancel_btn` | -- | button | scan_click | 按钮点击时 | `present_scene` 当前场景 = 通用：universal_scanning / 试卷：scan_testpaper / 票据：scan_receipt / 转Word： convert_word / 转Excel：convert_excel / 转PPT：convert_ppt（属性名显示为edit_type） / 书籍：scan_books / 提取文字：text_recognition ；`total_count` 需加载的图片总数 ；`转Word、转Excel、转PPT、提取文字场景无需记录` ；`load_count` 已加载的图片数量 ；`转Word、转Excel、转PPT、提取文字场景无需记录` ；`duration` 加载等待时长/ms |

**模块：图片异常提示（2025.03新增）** `warning`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 异常提示 `warning_btn` | -- | button | scan_click | 点击二次确认弹窗的“清除”时 | `clear` 图片异常重拍 = 1：异常图片只有一张 / 2：异常图片多张 ；`2025.03新增` |

**模块：长按文字区域** `word_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 长按 `long_press` | -- | button | scan_click | 手指点击长按时 |  |

### 编辑文字页面 `picture_edit_page`


**模块：处理加载** `optimize_loading`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 时间 `time` | -- | page | scan_load | 页面加载时 | `duration` 加载时长/ms ；`status` 加载结果 = success / fail |
| 取消 `cancel` | -- | button | scan_click | 点击取消时 |  |

**模块：悬浮菜单栏** `floating_menu_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 面板 `panel` | -- | page | scan_show | 编辑面板出现时 |  |
| 修改/删除/复制/ `revise/copy/delete` | -- | button | scan_click | 按钮点击时 |  |

**模块：修改文字面板** `edit_word_panel`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 确定/取消 `confirm/cancel` | -- | button | scan_click | 按钮点击时 |  |

**模块：修改加载** `edit-loading`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 时间 `time` | -- | page | scan_load | 修改/删除后的加载 | `duration` 加载时长/ms ；`status` 加载结果 = success / fail |

**模块：全局菜单栏** `global_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 确定/取消 `confirm/cancel` | -- | button | scan_click | 按钮点击时 |  |

**模块：提醒弹窗** `reminder_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 弹窗 `popup` | -- | page | scan_show | 弹窗出现时 |  |
| 确定/取消 `confirm/cancel` | -- | button | scan_click | 按钮点击时 |  |

**模块：异常弹窗** `exception_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 弹窗 `popup` | -- | page | scan_show | 弹窗出现时 |  |
| 重试 `retry` | -- | button | scan_click | 按钮点击时 |  |

**模块：多页切换** `multipage_switching`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 上一个/下一个 `last/next` | -- | button | scan_click | 按钮点击时 |  |

## 扫描后的图片处理页 (2)

> **Sheet 说明**：全部功能扫描后的页面展示以及点击，统一上报page_name：edit_page / 不同页面点击模块不一致的情况下，通过module_name等后置属性区分： / 扫描、扫描证件、扫描书籍、转excel，module_name上报一致均为：edit_choose_area / 转word：直接进入裁切区，故module_name上报：cropping_area / 提取文字：module_name上报 extract_area / 图片翻译：module_name上报 imagetranslation_area / 扫描票据：module_name上报 scan_receipt


### page-zf `edit_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| E15 `F17` |  | page | scan_show | 页面展示时 | `page_type` 页面类型 = general \| 通用型 ；`page_type` 页面类型 = card \| 证件 ；`page_type` 页面类型 = testpaper｜试卷（12月新增） ；`page_type` 页面类型 = receipt \| 票据（12月新增） ；`recognize_result / （仅iOS，安卓是在load时）` 分类识别结果 = 通用证件 \| universal_card / 身份证 \| identification_card / 户口本 \| household_registration_booklet / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driver_license / 试卷｜testpaper / 票据｜receipt（12月新增） / 其它\|other ；`通用证件 \| universal_card / 身份证 \| id_card / 户口本 \| household_registration_book / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driving_license  / 试卷｜handwritten_test_paper / 票据｜receipt / 其它\|others / 社保卡\|social_security_card` ；`default_filter` 默认滤镜 = source：原图 / optimization：优化 / intelligent：智能 / sharpen：锐化 / enhance：增强 / blackwhite：黑白 / grayscale：灰度 / inksaving：省墨 ；`（25年1月新增）` |
| E15 `F17` |  | page | scan_stay | 页面停留 | `duration` 停留时长/ms ；`page_type` 页面类型 ；`page_type` 页面类型 = card \| 证件 ；`page_type` 页面类型 = testpaper｜试卷（12月新增） ；`page_type` 页面类型 = receipt \| 票据（12月新增） |
| E15 `F17` |  | page | scan_load | 页面加载 | `duration` 加载时长/ms ；`duration` recognize_result / （仅安卓， iOS是在show时） = 通用证件 \| universal_card / 身份证 \| identification_card / 户口本 \| household_registration_booklet / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driver_license / 试卷｜testpaper / 票据｜receipt（12月新增） / 其它\|other ；`duration` = general \| 通用型 ；`duration` = card \| 证件 ；`duration` = testpaper｜试卷（12月新增） ；`duration` = receipt \| 票据（12月新增） |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 关闭按钮 `close` |  | button | scan_click | 按钮点击时 |  |
| 图片管理 `image_manage` |  | button | scan_click | 按钮点击时 |  |
| 问题反馈 `feedback` |  | button | scan_click | 按钮点击时 |  |

**模块：模式切换** `mode_switching`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 页面展示时 | `current_model` 当前属性 |
| 进入 `entry` |  | button | scan_click | 按钮点击时 | `current_model` 当前属性 |
| 切换 `switch` |  | button | scan_click | 按钮点击时 | `current_model` 当前属性 ；`target_model` 目标属性 |
| 关闭 `close` |  | button | scan_click | 按钮点击时 |  |

**模块：编辑类型选择区域** `edit_choose_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮 `finish_btn` |  | button | scan_click | 按钮点击时 | `is_filter` 是否切换过滤镜 = true:是 / false:否 ；`（25年1月修改）` ；`统计是否点击切换过滤镜` ；`mode_switch` 模式切换 = 上报格式：“进入时模式；点击完成时的模式”（用分号隔开） / 上报示例：“universal_scanning；cert” / 通用：universal_scanning / 证件：cert / 试卷：paper / 票据：receipt ；`（25年1月新增）` ；`filter` 使用的滤镜名称 = source：原图 / optimization：优化 / intelligent：智能 / sharpen：锐化 / enhance：增强 / blackwhite：黑白 / grayscale：灰度 / inksaving：省墨 ；`（25年1月新增）` ；`is_cropping` 是否主动使用过裁切旋转 = true:是 / false:否 ；`copy_type` 是否有使用过提取文字 = true:是 / false:否 ；`mark_type` 是否有使用过标注 = true:是 / false:否 ；`is_watermark` 是否有添加水印 = true:是 / false:否 ；`is_remove_handwriting` 是否应用去除笔迹 = true:是 / false:否 ；`（10月新增）` ；`is_extracted` 是否提取识别 = true:是 / false:否 ；`扫描票据（12月新增）` ；`picture_count` 选择的上传的图片数量 ；`is_change_filter` 是否改变默认滤镜 = true：是 / false：否 ；`（25年1月新增）` ；`统计默认滤镜是否进行更改` ；`is_reedit` 是否二次编辑 = true：是 / false：否 ；`（25年4月新增）` |
| 对比 `compare` |  | button | scan_click | 按钮点击时 |  |
| 重新拍照 `reset_photograph` |  | button | scan_click | 按钮点击时 |  |

**模块：编辑类型选择区域** `edit_choose_area / （提取文字在x.23版本改为图片预览区，module_name=extract_area）`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 编辑类型选择 `edit_type` |  | button | scan_click | 按钮点击时 | `edit_type` 编辑类型 = filter:滤镜 / cropping_area:裁剪 / extract:提取文字 / mark:页面标注 / erase：涂抹消除 / remove_handwriting：去除笔迹 / watermart：水印 / convert_word：转word（2025.04新增） / AI解题：ai_answers / convert_excel：转Excel（2025.07新增） |

**模块：滤镜编辑区** `filter_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 滤镜选择 `filter_choose` |  | button | scan_click | 点击滤镜时 | `filter` 滤镜名称 = 原图：source / 优化：optimization / 智能：intelligent / 锐化：sharpen / 增强：enhance / 黑白：blackwhite / 灰度：grayscale / 省墨：inksaving ；`（25年1月新增）` |

**模块：裁剪编辑区** `cropping_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮 `finish_btn` |  | button | scan_click | 按钮点击时 | `is_croping` 是否裁切旋转 = true:是 / false:否 ；`转word` |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |

**模块：提取文字区域** `extract_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 复制按钮 `copy_btn` |  | button | scan_click | 按钮点击时 | `copy_type` 复制类型 = copy_words：复制文字(用于按字选择的复制按钮) / copy：复制内容（用于按段选择的复制按钮） / copy_currentpage：复制当页（.29.0新增） ；`原图对照` image_text_comparison(（10月新增） = on：开启 / off：关闭 ；`extract_type` 提取类型 = paragraph：按段提取 / words：按字提取 |
| 提取类型 `extract_type` |  | button | scan_click | 按钮点击时 | `extract_type` 提取类型 = paragraph：按段提取 / words：按字提取 |
| 全选当页 `select_all` |  | button | scan_click | 按钮点击时 |  |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |
| 提取结果 `extra_result` |  | page | scan_show | 进入页面时 | x.17.0新增 |
| 导出文档 `export_file` |  | button | scan_click | 按钮点击时 | `extract_type` 提取类型 = （x.17.0新增） / paragraph：按段提取 / words：按字提取 ；`原图对照` image_text_comparison = on：开启 / off：关闭 ；`（10月新增）` |
| 原图校对 `image_contrast` |  | button | scan_click | 按钮点击时 | `is_on` 是否开启原图校对 = on:开启原图校对 / off:关闭原图校对 / （.29.0新增） |

**模块：页面标注区域** `mark_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮 `finish_btn` |  | button | scan_click | 按钮点击时 | `mark_type` 标注类型，多个标注类型用英文逗号分割 = letter：文字 / pen：画笔 / watermark：水印 / mosaic：马赛克 |
| 继续添加 `add_letter` |  | button | scan_click | 按钮点击时 |  |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |

**模块：涂抹消除区域** `erase_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 确认（完成）按钮 `finish_btn` |  | button | scan_click | 按钮点击时 |  |
| 取消按钮 `cancel` |  | button | scan_click | 按钮点击时 |  |
| 消除按钮 `erase` |  | button | scan_click | 按钮点击时 |  |

**模块：图片翻译** `imagetranslation_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮(导出为word) `finish_btn` |  | button | scan_click | 按钮点击时 | `mark_type` 导出为图片类型 = 原图：original  / 译图：translate ；`图片翻译` |
| 复制按钮 `copy_btn` |  | button | scan_click | 按钮点击时 | `copy_type` 复制类型 = 全部复制：copy_all / 局部复制：copy_part |
| 保存图片 `save_picture` |  | button | scan_click | 按钮点击时 |  |
| 保存图片-二级保存 `save_topicture` |  | button | scan_click | 按钮点击时 | `picture_type` 保存为图片类型 = 仅译图：translate / 原图+译图：original_translate |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |

**模块：扫描票据（25年3月更新）** `scan_receipt`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 提取识别 `structured_extract` |  | button | scan_click | 按钮点击时 | `扫描票据（25年3月更新）` |
| 复制全部 `copy_all` |  | button | scan_click | 按钮点击时 | `扫描票据（25年3月更新）` |
| 复制单行 `copy_part` |  | button | scan_click | 长按字段时 | `扫描票据（25年3月更新）` |
| 双击编辑 `edit_receipt` |  | button | scan_click | 字段双击时 | `edit_type` 编辑的字段类型 = 字段type：中文名称 / 📄票据编辑信息识别字段 ；`扫描票据（25年3月更新）` ；`is_cloud_popup` 是否弹出上云提示 = true：是 / false：否 ；`扫描票据（25年3月更新）` |
| 完成按钮 `finish_btn` |  | button | scan_click | 按钮点击时 | `edit_type` 编辑的字段类型 = 字段type：中文名称 / 📄票据编辑信息识别字段 ；`扫描票据（25年3月更新）` ；`此处的“完成”按钮实际为提取识别编辑栏的“确认”按钮，实际触发时机为点击“确定”时` |
| 问题反馈 `feedback` |  | button | scan_click | 按钮点击时 | `扫描票据（25年3月更新）` |

**模块：进度条加载区域（25年1月新增）** `progress_load_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 取消按钮 `cancel_btn` |  | button | scan_click | 按钮点击时 | `present_scene` 当前场景 = 通用：universal_scanning / 试卷：scan_testpaper / 票据：scan_receipt / 转Word： convert_word / 转Excel：convert_excel / 书籍：scan_books / 提取文字：text_recognition ；`total_count` 需加载的图片总数 ；`转Word、转Excel、提取文字场景无需记录` ；`load_count` 已加载的图片数量 ；`转Word、转Excel、提取文字场景无需记录` ；`duration` 加载等待时长/ms |

**模块：图片异常提示（2025.03新增）** `warning`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 异常提示 `warning_btn` |  | button | scan_click | 点击二次确认弹窗的“清除”时 | `clear` 图片异常重拍 = 1：异常图片只有一张 / 2：异常图片多张 ；`2025.03新增` |

**模块：异常时保存提示 / （2025.09新增）** `wpssc_save_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 异常时继续保存 `save_tips_sure` |  | button | scan_click | 按钮点击时 |  |
| 异常时取消保存 `save_tips_cancel` |  | button | scan_click | 按钮点击时 |  |

## 全部文档管理

> **Sheet 说明**：全部功能处理后的页面展示以及点击，统一上报page_name：preview_page / 不同页面点击模块不一致的情况下，通过module_name等后置属性区分： / 扫描票据：module_name上报 receipt_area /  / haoyuan: 底部编辑区module_name / edit_area->scan_receipt / 方便传递参数


### 全部文档页 / （38.0后需参照新归档页埋点） `file_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show |  |  |
| — |  | page | scan_stay |  | `duration` 停留时长/ms |
| — |  | page | scan_load |  | `duration` 加载时长/ms |

**模块：排序弹窗** `sort_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show |  |  |
| 排序方式 `sort` |  | button | scan_click |  | `sort_name` 排序类型 = 按照更新时间排序：update_time / 按照创建时间排序：ceate_time |

**模块：固定文件夹二级页面** `default_folder`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导出文件夹 `file` |  | button | scan_show | 导出文件夹曝光时 |  |
| 导出文件夹 `file` |  | button | scan_click | 导出的文件夹点击时 |  |

**模块：自定义文件夹二级页面** `custom_folder`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 文件夹 `file` |  | button | scan_click | 文件点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一id ；`folder_name` 文件夹名称 = 中文名称 |

**模块：扫描文档列表** `file_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 文件 `file` | x | button | scan_click | 文件预览点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 文件 `file_reextract` | x | button | scan_click | 点击“重新识别”时 |  |
| 文件夹 `folder` | x | button | scan_click | 文件夹点击时 | `folder_name` 文件夹名称 ；`folder_type` 文件夹类型 = 固定文件夹：fixed_folder / 用户创建的文件夹：ceate_folder |
| 自定义文件夹操作 `edit` | x | button | scan_click | 重命名或者删除时 | `folder_name` 文件夹名称 ；`edit_type` 操作类型 = 重命名：rename / 删除：delete |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 搜索按钮 `search_bar` | x | button | scan_click | 按钮点击时 |  |
| 返回按钮 `back` | x | button | scan_click | 按钮点击时 |  |
| 排序按钮 `sort` | x | button | scan_click | 按钮点击时 |  |
| 创建文件夹 `create_folder` | x | button | scan_click | 按钮点击时 |  |

### 多选页面 `multiple_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show |  |  |
| — | x | page | scan_stay |  | `duration` 停留时长/ms |
| — | x | page | scan_load |  | `duration` 加载时长/ms |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成 `finish` | x | button | scan_click | 按钮点击时 |  |
| 全选 `check_all` | x | button | scan_click | 按钮点击时 |  |

**模块：底部工具栏** `tool_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 移动按钮 `move` | x | button | scan_click | 按钮点击时 | `file_count` 选择的文档数量 |
| 合并按钮 `merge` | x | button | scan_click | 按钮点击时 | `file_count` 选择的文档数量 |
| 删除按钮 `delete` | x | button | scan_click | 按钮点击时 | `file_count` 选择的文档数量 |
| 导出按钮 `export` | x | button | scan_click | 按钮点击时 | `file_count` 选择的文档数量 |
| 重命名按钮 `rename` | x | button | scan_click | 按钮点击时 |  |
| 分享按钮 `share` | x | button | scan_click | 按钮点击时 |  |

**模块：导出弹窗** `export_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  |  |
| 关闭按钮 `close` | x | button | scan_click | 按钮点击 |  |
| 导出方式选择 `export` | x | button | scan_click | 按钮点击 | `export_type` 导出方式 = 导出为pdf：export_pdf / 导出为word：export_word / 导出为execl：export_execl / 导出为ppt: export_ppt / 保存到相册：save_album |

**模块：删除弹窗** `delete_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  |  |
| 删除按钮 `delete` | x | button | scan_click | 按钮点击 |  |
| 取消按钮 `cancel` | x | button | scan_click | 按钮点击 |  |

**模块：合并弹窗** `merge_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  |  |
| 关闭按钮 `close` | x | button | scan_click | 按钮点击 |  |
| 合并方式选择 `merge` | x | button | scan_click | 按钮点击 | `merge_type` 合并方式 = 合并成一个文件：merge_withoutoriginals / 合并且保留原件：merge_keeporiginals |

**模块：转换进度条加载区域** `convert_load_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 取消按钮 `cancel_btn` | x | button | scan_click | 按钮点击时 | `edit_type` 编辑类型 = export_ppt：导出为演示文档 ；`duration` 加载等待时长/ms |

### 扫描件预览页 `preview_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show |  | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面来源 = 从处理页进入：editpage / 从首页/全部文档列表进入：list ；`is_structured_extract` 是否默认打开提取识别区域 = true：是 / false：否 |
| — | x | page | scan_stay |  | `duration` 停留时长/ms ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面来源 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| — | x | page | scan_load |  | `duration` 加载时长/ms ；`status` 加载结果 = success：成功 / fail：失败 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面来源 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` | x | button | scan_click | 按钮点击时 | `is_switched_word` 是否点击过转Word = true：是 / false：否 ；`is_switched_excel` 是否点击过转Excel = true：是 / false：否 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 返回 `back` | x | button | docer_scan_click | 按钮点击时 | `page_from` 页面来源 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 重命名 `rename` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面来源 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 分享 `share` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |

**模块：保存成功提示** `success_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show | 提示展示时 |  |
| 查看 `go_to` | x | button | scan_click | 按钮点击时 |  |

**模块：底部编辑区** `edit_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 添加拍照按钮 `photograph` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 打印按钮 `print` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 导出按钮 `export` | x | button | scan_click | 按钮点击时 | `export_type` 导出类型 = export_table: 导出表格 / extract_info: 提取信息录表 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 导出按钮 `export` | x | button | docer_scan_click | 按钮点击时 | `page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 导出弹窗 `export_popup` | x | module | scan_show | 弹窗展示时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面来源 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 导出弹窗 `export_popup` | x | button | scan_click | 按钮点击时 | `export_type` 导出方式 = 导出为pdf：export_pdf / 导出为word：export_word / 导出为execl：export_execl / 导出ppt: export_ppt / 保存到相册：save_album ；`action` 关闭 = close ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 编辑按钮 `edit` | x | button | docer_scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 分享 `share` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 上一页 `page_up` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 下一页 `page_down` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 提取识别 `structured_extract` | x | button | scan_click | 按钮点击时 |  |

**模块：提取文字** `extract_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 提取文字 `extract` | x | button | scan_click | 按钮点击时 |  |

**模块：提取模式弹窗** `extract_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  |  |
| 深度提取 `extract_deep` | x | button | scan_click | 按钮点击时 |  |
| 快速提取 `extract_fast` | x | button | scan_click | 按钮点击时 |  |
| 关闭 `close` | x | button | scan_click | 按钮点击时 |  |

**模块：扫描票据** `scan_receipt`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 复制全部 `copy_all` | x | button | scan_click | 按钮点击时 |  |
| 复制单行 `copy_part` | x | button | scan_click | 长按字段时 |  |
| 双击编辑 `edit_receipt` | x | button | scan_click | 字段双击时 |  |
| 问题反馈 `feedback` | x | button | scan_click | 按钮点击时 |  |

**模块：格式切换区域(2025.08新增)** `switch_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 格式切换胶囊 `preview_switch` | x | button | scan_click | 按钮点击时 | `status` 切换的格式状态 = picture：图片 / word：文字 / excel：表格 |

**模块：转换进度条加载区域（2025.11新增）** `convert_load_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 取消按钮 `cancel_btn` | x | button | scan_click | 按钮点击时 | `edit_type` 编辑类型 = export_ppt：导出为演示文档 ；`duration` 加载等待时长/ms |

**模块：半屏面板** `half_panel`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 半屏面板曝光时 |  |
| — | x | page | scan_stay |  | `duration` 停留时长/ms ；`integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| 查看文档按钮 `view_btn` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| 导出 `export` | x | button | scan_click | 按钮点击时 | `export_type` 导出方式 = 导出为pdf：export_pdf / 导出为word：export_word / 导出为execl：export_excel / 保存到相册：save_album |
| 打印 `print` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| 分享给好友 `share` | x | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 关闭 `close` | x | button | scan_click | 按钮点击时 |  |
| 添加水印 `watermark` | x | button | scan_click | 按钮点击时 |  |

**模块：云同步弹窗** `cloud_sync`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show | 弹窗展示时 |  |
| 开启云同步按钮 `on` | x | button | scan_click | 按钮点击时 |  |
| 取消按钮 `cancle` | x | button | scan_click | 按钮点击时 |  |

## 新归档页埋点（25.12上线）


### 全部文档页 `file_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show |  | `page_from` 页面来源 = 从预览页进入：preview_page / 从首页进入：homepage |
| — |  | page | scan_stay |  | `duration` 停留时长/ms |
| — |  | page | scan_load |  | `duration` 加载时长/ms |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 搜索按钮 `search_bar` |  | button | scan_click | 按钮点击时 |  |
| 关闭按钮 `close` |  | button | scan_click | 按钮点击时 |  |

**模块：导入区域** `import_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导入方式 `import` |  | button | scan_show | 导入按钮曝光时 | `import_way` 导入方式 = wechat:微信导入 / photo:相册导入 / file:文件导入 |
| 导入方式 `import` |  | button | scan_click | 导入按钮点击时 | `import_way` 导入方式 = wechat:微信导入 / photo:相册导入 / file:文件导入 |
| 导入方式 `import` |  | button | scan_result | 完成导入时 | `file_type` 导入类型 = pdf/word/ppt/excel：文件 / photo：图片 |

**模块：tab切换区域** `tab`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 全部扫描件tab `filelist_tab` |  | button | scan_click | 按钮点击时 |  |
| 已导出文件tab `exportlist_tab` |  | button | scan_click | 按钮点击时 |  |

**模块：扫描文档列表** `file_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 扫描文件列表曝光时 |  |
| 文件 `file` |  | button | scan_click | 文件预览点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 文件 `file_reextract` |  | button | scan_click | 点击“重新识别”时 |  |
| 文件夹 `folder` |  | button | scan_click | 文件夹点击时 | `folder_name` 文件夹名称 = 中文名称 ；`folder_type` 文件夹类型 = 固定文件夹：fixed_folder / 用户创建的文件夹：ceate_folder |
| 自定义文件夹操作 `edit` |  | button | scan_click | 重命名或者删除时 | `folder_name` 文件夹名称 = 中文名称 ；`edit_type` 操作类型 = 重命名：rename / 删除：delete |
| 排序按钮 `sort` |  | button | scan_click | 按钮点击时 |  |
| 切换视角按钮 `change_view` |  | button | scan_click | 按钮点击时 | `view_mode` 视角模式 = 切换为列表：list / 切换为宫格：thumbnail |
| 创建文件夹按钮 `create_folder` |  | button | scan_click | 按钮点击时 |  |

**模块：已导出文件列表** `export_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 已导出文件列表曝光时 |  |
| 筛选标签按钮 `export_filter` |  | button | scan_click | 按钮点击时 | `filter_type` 筛选类型 = all/pdf/word/excel/ppt |
| 已导出文件 `export_file` |  | button | scan_click | 已导出文件点击时 | `file_type` 文件类型 = pdf/word/excel/ppt |

**模块：排序弹窗** `sort_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 弹窗曝光时 |  |
| 排序方式 `sort` |  | button | scan_click | 按钮点击时 | `sort_name` 排序类型 = 按照更新时间排序：update_time / 按照创建时间排序：ceate_time ；`sort_order` 排序顺序 = 从新到旧：asc / 从旧到新：desc |

**模块：新建文件夹弹窗** `create_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 弹窗曝光时 |  |
| 确定按钮 `confirm` |  | button | scan_click | 按钮点击时 | `folder_name` 文件夹名称 = 中文名称 |
| 取消按钮 `cancel` |  | button | scan_click | 按钮点击时 |  |

**模块：自定义文件夹二级页面** `custom_folder`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 文件 `file` |  | button | scan_click | 文件点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一id ；`folder_name` 文件夹名称 = 中文名称 |
| 导入方式 `import` |  | button | scan_click | 导入按钮点击时 | `import_way` 导入方式 = scan：拍照导入 / photo：相册导入 / file：文件导入 / move：移入扫描件 |
| 导入方式 `import` |  | button | scan_result | 完成导入时 | `file_type` 导入类型 = pdf/word/ppt/excel：文件 / photo：图片 / file：扫描件 |

**模块：固定文件夹二级界面** `default_folder`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 文件 `file` |  | button | scan_click | 文件点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一id ；`folder_name` 文件夹名称 = 中文名称 |
| 立即添加按钮 `empty_add` |  | button | scan_click | 按钮点击时 | `folder_name` 文件夹名称 = 中文名称 ；`entry_scene` 一级进入场景名称 = 📄拍照扫描埋点方案 / 具体见行为埋点公共属性 ；`second_entry_scene` 二级进入场景名称 |
| 拍摄添加按钮 `scene` |  | button | scan_click | 按钮点击时 | `folder_name` 文件夹名称 = 中文名称 ；`entry_scene` 一级进入场景名称 ；`second_entry_scene` 二级进入场景名称 |

## 文件导出分享


### 文件导出页 `share_page / （导出和分享点击时：iOS研发埋的是export_share）`


**模块：$页面级事件** `D28`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show |  | `integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| — |  | page | scan_stay |  | `duration` 停留时长/ms ；`integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| — |  | page | scan_load |  | `duration` 加载时长/ms ；`integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |

**模块：导出和分享** `export_share`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导出 `export` |  | button | scan_click | 按钮点击时 | `export_type` 导出类型 = 导出为pdf：export_pdf / 导出为word：export_word / 导出为execl：export_execl / 导出为ppt：export_ppt / 保存到相册：save_album ；`integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id ；`picture_quality` 画质 = UHD：超清 / HD：高清imageLevelStr / SD：省流 / 如导入的图片无画质上报“0“占位  / 如多图有多画质时，用“,”区分 |
| 打印 `print` |  | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| 分享 `share` |  | button | scan_click | 按钮点击时 | `share_type` 分享类型 = 扫描分享：scan_share |
| 分享 `share` |  | button | docer_scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 首页按钮 `homepage` |  | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| 重命名按钮 `rename_btn` |  | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一id ；`cloud_file_id` 云文档id |
| 查看文档按钮 `view_btn` |  | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一id |
| 查看文档按钮 `view_btn` |  | button | docer_scan_click | 按钮点击时 | `cloud_file_id` 云文档id |

### 导出预览页 `export_preview_page`


**模块：$页面级事件** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 查看文档按钮 `view_btn` |  | page | scan_show |  | `integritycheckvalue` 文档唯一ID ；`page_source` share_page:导出页面 / preview_page:预览页面 / convert_to_word_process_page：转word处理页convert_to_excel_process_page：转excel处理页 / multiple_page：多选页 / edit_page：处理页（2025.04新增） / preview_page_switch：预览页快速切换（2025.10新增） / half_panel：预览页半屏面板（2025.11新增） / convert_to_pdf_process_page：转PDF处理页（2026.04新增） ；`page_type` excel:转表格预览页 / extractdata：提取数据录表预览页 = 仅excel场景上报 ；`photo_sum` 上报图片数量 = 仅excel场景上报 ；`export_type` 导出为pdf：export_pdf / 导出为word：export_word / 导出为execl：export_excel ；`cloud_file_id` 云文档唯一ID ；`preview_file_id` 预览链接ID ；`model` 模型版本 = yolo：四边形检测新模型 / old：旧模型 |
| 查看文档按钮 `view_btn` |  | page | scan_stay |  | `duration` 停留时长/ms ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 查看文档按钮 `view_btn` |  | page | scan_load |  | `duration` 加载时长/ms ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` |  | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：去水印提示条** `membership_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| pdf-开通会员 `membership_btn` |  | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-开通会员 `membership_btn` |  | button | scan_show | 提示条曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：WPS水印** `wps_watermark`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 关闭 `close` |  | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 关闭 `close` |  | button | scan_show | 水印曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：去水印半屏面板 / (2025.05新增)** `watermark_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 半屏面板曝光时 |  |
| 导出无二维码水印文件 `no_watermark` |  | button | scan_click | 按钮点击时 |  |
| 继续导出 `keep` |  | button | scan_click | 按钮点击时 |  |
| 关闭按钮 `close` |  | button | scan_click | 按钮点击时 |  |

**模块：提示条运营位** `activity_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 运营位 `tips` | / | button | scan_show | 功能曝光时 | `function_name` 功能名 = scan_pic2pdf：转pdf / scan_pic2word：转word / scan_pic2et：转表格 / scan_extractdata：录表 / scan_pic2txt：提取文字 ；`activity_name` 活动名 = 读天策活动的活动名称 |
| 运营位 `tips` | / | button | scan_click | 按钮点击时 | `function_name` 功能名 = scan_pic2pdf：转pdf / scan_pic2word：转word / scan_pic2et：转表格 / scan_extractdata：录表 / scan_pic2txt：提取文字 ；`activity_name` 活动名 = 读天策活动的活动名称 |
| 关闭按钮 `close` | / | button | scan_click | 按钮点击时 | `function_name` 功能名 = scan_pic2pdf：转pdf / scan_pic2word：转word / scan_pic2et：转表格 / scan_extractdata：录表 / scan_pic2txt：提取文字 ；`activity_name` 活动名 = 读天策活动的活动名称 |

**模块：底部编辑区** `edit_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| pdf-编辑tab `edit` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-版式tab `format_btn` | / | button | scan_click | 按钮点击时 | `format_type` 版式类型 = native:原尺寸版式 / joint:拼接版式 / 11size:1*1版式 / 21size:2*1版式 / 22size:2*2版式 / 32size:3*2版式 / 33size:3*3版式 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-版式tab `format_btn` | / | button | scan_show | 按钮曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-水印tab `watermark_btn` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-水印tab `watermark_btn` | / | button | scan_show | 按钮曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-更换tab `change` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-更换tab `change` | / | button | scan_show | 按钮曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-模式tab `export_mode` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf-模式tab `export_mode` | / | button | scan_show | 按钮曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf_画质选项tab `quality_btn` | / | button | scan_click | 按钮点击时 | `picture_quality` 画质类型 = SD:原图 / HD:AI高清 / UHD:AI超清 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf_画质选项tab `quality_btn` | / | button | scan_show | 按钮曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf_画质处理停止按钮 `cancel_btn` | / | button | scan_show | 按钮曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| pdf_画质处理停止按钮 `cancel_btn` | / | button | scan_click | 按钮点击时 | `picture_quality` 画质类型 = HD:AI高清 / UHD:AI超清 ；`duration` 加载等待时长/ms ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| excel-转表格 `change_excel` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`preview_file_id` 预览链接ID = 仅excel场景上报 |
| excel-转表格 `change_excel` | / | button | scan_show | 按钮曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`preview_file_id` 预览链接ID = 仅excel场景上报 |
| excel-提取数据录表 `extractdata` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`preview_file_id` 预览链接ID = 仅excel场景上报 |
| excel-提取数据录表 `extractdata` | / | button | scan_show | 按钮曝光时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`preview_file_id` 预览链接ID = 仅excel场景上报 |
| pdf/word/excel-保存导出按钮 `save_export` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_source` 页面来源 = share_page:导出页面 / preview_page:预览页面 / convert_to_word_process_page：转word处理页convert_to_excel_process_page：转excel处理页 / convert_to_pdf_process_page：转PDF处理页 / multiple_page：多选页 / edit_page（2025.04新增）preview_page_switch：预览页快速切换（2025.10新增） / half_panel：预览页半屏面板（2025.11新增） / convert_to_pdf_process_page：转PDF处理页（2026.04新增） ；`file_format` 文档的格式 = et：表格 / pdf: PDF / writer:文字 / ppt::演示 ；`picture_count` 确认导出的图片数量 ；`picture_quality / （仅PDF保存按钮上报该属性）` 画质类型 = SD:原图 / HD:AI高清 / UHD:AI超清 ；`export_mode` 导出模式 = searchable_pdf：双层pdf / Image_pdf：纯图pdf |
| excel-导出表格 `excel_export` | / | button | scan_click | 按钮点击时 | `preview_file_id` 预览链接ID ；`page_source` 页面来源 = preview_page_switch：预览页快速切换（2025.10新增） / half_panel：预览页半屏面板（2025.11新增） |
| extractdata-录入表格 `extractdata_export` | / | button | scan_click | 按钮点击时 | `preview_file_id` 预览链接ID ；`page_source` 页面来源 = preview_page_switch：预览页快速切换（2025.10新增） / half_panel：预览页半屏面板（2025.11新增） ；`picture_count` 确认导出的图片数量 |
| excel-导出方式弹窗 `excel_exporttype` | / | button | scan_show | 页面曝光时 | `integritycheckvalue` 文档唯一ID = 仅在转表格-导出预览页上报 ；`cloud_file_id` 云文档唯一ID = 仅在转表格-导出预览页上报 ；`preview_file_id` 预览链接ID = 仅在转表格-导出预览页上报 |
| excel-导出方式弹窗 `excel_exporttype` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID = 仅在转表格-导出预览页上报 ；`cloud_file_id` 云文档唯一ID = 仅在转表格-导出预览页上报 ；`preview_file_id` 预览链接ID = 仅在转表格-导出预览页上报 ；`export_type` multi_sheet:导出为多个sheet / single_sheet：导出为单个sheet = 仅在转表格-导出预览页上报 |
| extractdata-录表方式弹窗 `extractdata_exporttype` | / | page | scan_show | 页面曝光时 | `integritycheckvalue` 文档唯一ID = 仅在提取数据录表导出预览页上报 ；`cloud_file_id` 云文档唯一ID = 仅在提取数据录表导出预览页上报 ；`preview_file_id` 预览链接ID = 仅在提取数据录表导出预览页上报 |
| extractdata-录表方式弹窗 `extractdata_exporttype` | / | page | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID = 仅在提取数据录表导出预览页上报 ；`cloud_file_id` 云文档唯一ID = 仅在提取数据录表导出预览页上报 ；`preview_file_id` 预览链接ID = 仅在提取数据录表导出预览页上报 ；`export_type` input_newsheet ：录入新表 / input_oldsheet：录入已有表 = 仅在提取数据录表导出预览页上报 |

**模块：pdf-编辑页** `edit_page`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 保存 `save` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 图片调整 `picture_adjust` | / | button | scan_click | 按钮点击时 | `adjust_btn_type` 图片调整功能类型 = clear:一键清晰 / cut：裁剪 / filter：滤镜 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`model` 模型版本 = yolo：四边形检测新模型 / old：旧模型 |
| 图片标注 `picture_mark` | / | button | scan_click | 按钮点击时 | `mark_btn_type` 图片标准功能类型 = mosiac:马赛克 / brush:画笔 / word:添加文字 / watermark：添加水印 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 去污修复 `picture_restore` | / | button | scan_click | 按钮点击时 | `restore_btn_type` 去污修复功能类型 = quality_fix:画质修复 / eraser：消除笔 / no_noise:去屏纹 / no_shadow:去阴影 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：pdf-水印页** `watermark_page`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 完成 `finish` | / | button | scan_click | 按钮点击时 | `watermark_type` 是否添加水印 = add_watermark:加水印 / no_watermark:不加水印 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：pdf-更换图片页** `change_page`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 添加图片 `add` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 更换图片 `change` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 删除图片 `delete` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：pdf-模式页** `export_mode_page`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 双层pdf `searchable_pdf` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 纯图pdf `Image_pdf` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

### 保存文档页 `save_doc_page`


**模块：$页面级事件** `export_mode_page`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 纯图pdf `Image_pdf` | / | page | scan_show |  | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 纯图pdf `Image_pdf` | / | page | scan_stay |  | `duration` 停留时长/ms ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 纯图pdf `Image_pdf` | / | page | scan_load |  | `duration` 加载时长/ms ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：顶部导航栏** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：路径选择区** `path_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 新建文件夹 `new_folder` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 选择保存路径（仅安卓） `save_path` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

**模块：底部编辑区** `edit_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 重命名 `rename` | / | input_box | scan_click | 输入框点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 文件类型 `doc_format` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |
| 保存按钮 `save` | / | button | scan_click | 按钮点击时 | `save_result` 是否保存成功 = saved:保存成功 / save_fail:保存失败 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

### 分享页面 `share_popup_page`


**模块：分享弹窗** `show_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 保存按钮 `save` | / | page | scan_show | 分享面板展示时 | `page_source` 弹窗所在的页面来源 = multiple_page: 文件选择页面 / share_page：导出页面 / preview_page：预览页面 ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 关闭按钮 `close` | / | button | scan_click | 按钮点击时 | `integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_source` 弹窗所在的页面来源 = multiple_page: 文件选择页面 / share_page：导出页面 / preview_page：预览页面 ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 分享方式选择 `share` | / | button | scan_click | 按钮点击时 | `share_type` 分享方式 = 以图片发送： / picture_share / 以纯图PDF发送： / pdf_share ；`page_source` 弹窗所在的页面来源 = multiple_page: 文件选择页面 / share_page：导出页面 / preview_page：预览页面 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |

### 打印页面 `print_page`


**模块：$页面级事件** `print_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 分享方式选择 `share` | / | page | scan_show | 打印面板展示时 | `page_source` 弹窗所在的页面来源 = share_page：导出页面 / preview_page：预览页面 ；`integritycheckvalue` 文档唯一ID ；`cloud_file_id` 云文档唯一ID |

## 设置页面


### 设置页面 `settings_page`


**模块：设置** `scan_settings`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 设置界面 `settings` |  | page | scan_show |  |  |
| 设置界面 `settings` |  | page | scan_stay |  | `duration` 停留时长/ms |
| 设置界面 `settings` |  | page | scan_load |  | `duration` 加载时长/ms |
| 设置界面 `settings` |  | button | scan_click | 按钮点击时 | `function_name` = batch_export ；`batch_export` = export：导出 / cancel：取消 ；`batch_export_process` = cance：取消 ；`cloud_sync` = 0｜1，报用户执行后的结果，比如从开到关，就报0即可 ；`cellular_data` = 0｜1 |
| 设置界面 `settings` |  | switch | scan_click | 按钮点击时 | `quality_improvement` = 0｜1 |

## 打印面板


### 打印面板 `print_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 页面展示时上报 | `comp` 打开组件 = scan/wps/ppt/et/pdf |
| 关闭 `close` |  | button | scan_click | 按钮点击时 |  |

**模块：手机连接打印机** `connect_printer_via_mobilephone`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 确认 `confirm` |  | button | scan_click | 热区点击时 | `--` -- |

**模块：发送到电脑上打印** `send_to_PC_for_printing`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | module | scan_show | 模块展示时 | `devices_count` 设备数量 = 0、1、2… |
| 发送 `send` |  | button | scan_click | 按钮点击时 | `device_name` 所选设备名称 ；`devices_count` 设备数量 = 0、1、2… |
| 扫码登录 `scan` |  | button | scan_click | 按钮点击时 | `devices_count` 设备数量 = 0、1、2… |

### 扫码页面 `scan_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 页面展示时上报 | `comp` 打开组件 = scan/wps/ppt/et/pdf |

**模块：扫码** `scan`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` |  | button | scan_click | 按钮点击时 |  |
| 完成扫描 `scan_done` |  | button | scan_click | 完成扫描时 |  |

### 登录页面 `login_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 页面展示时上报 | `comp` 打开组件 = scan/wps/ppt/et/pdf |

**模块：登录** `login`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 确认登录 `confirm_login` |  | button | scan_click | 按钮点击时 |  |
| 关闭 `close` |  | button | scan_click | 登录页关闭时 |  |

### 传输状态页面 `send_status_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 页面展示时上报 | `comp` 打开组件 = scan/wps/ppt/et/pdf |

**模块：过程** `process`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 发送中 `sending` |  | module | scan_show | 模块展示时 | `fileform` 文件传输形式 = network-网络传输 / wlan-局域网传输 |

**模块：结果** `result`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 发送成功 `success` |  | module | scan_show | 模块展示时 | `time` 从发送到结果的耗时 = （毫秒为单位） |
| 发送终止 `discontinue` |  | module | scan_show | 模块展示时 | `source` 终止来源 = PC端｜pc / 移动端｜mobile ；`time` 从发送到结果的耗时 = （毫秒为单位） |
| 发送失败 `fail` |  | module | scan_show | 模块展示时 | `reason` 失败原因 = 设备离线｜offline / 网络异常｜internet ；`time` 从发送到结果的耗时 = （毫秒为单位） |

**模块：操作** `operation`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 关闭 `close` |  | button | scan_click | 按钮点击时 | `status` 当前状态 = 发送成功｜success / 发送终止｜discontinue / 发送失败｜fail_internet |
| 终止发送 `discontinue` |  | button | scan_click | 按钮点击时 |  |
| 重新发送 `retry` |  | button | scan_click | 按钮点击时 |  |

## 证件场景特有


### 证件列表页 `certificate_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show |  |  |
| — |  | page | scan_stay |  | `duration` 停留时长，单位：ms |
| — |  | page | scan_load |  | `duration` 耗时，单位：ms |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` |  | button | scan_click |  | `null` null |

**模块：证件列表** `card_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 证件 `card` |  | button | scan_click | 点击某一证件夹时 | `card_name` 证件名称： / 通用证件 \| universal_card / 身份证 \| identification_card / 户口本 \| household_registration_booklet / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driver_license |

**模块：拍照扫描区域** `photo_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 拍照按钮 `photograph` |  | button | scan_click | 点击拍照按钮时上报 |  |

### 证件详情页 `certificatedetail_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show |  |  |
| — |  | page | scan_stay |  | `duration` 停留时长，单位：ms |
| — |  | page | scan_load |  | `duration` 耗时，单位：ms |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` |  | button | scan_click | 按钮点击时 |  |
| 管理 `manage` |  | button | scan_click | 按钮点击时 |  |

**模块：编辑操作区域** `edit_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 操作 `operate` |  | button | scan_click | 点击某一个操作相关按钮时上报 | `edit_type` 操作类型 = view_scan \| 查看扫描件 ；`edit_type` 操作类型 = copy \| 复制信息 ；`edit_type` 操作类型 = hide \| 隐藏信息 ；`edit_type` 操作类型 = show \| 展示信息 |

### 全部证件页 / （26年2月新增） `allcredentials_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | -- | page | scan_show |  |  |
| — | -- | page | scan_stay |  | `duration` 停留时长，单位：ms |
| — | -- | page | scan_load |  | `duration` 耗时，单位：ms |

**模块：顶部导航栏** `nav_bar_top`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` | -- | button | scan_click | 按钮点击时 |  |

**模块：导航栏** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 标题 `category` | -- | button | scan_show | 展示时 | `category_tab` = 常用 \| common_use / 学生 \| student / 生活 \| life / 职业 \| career |
| 标题 `category` | -- | button | scan_click | 按钮点击时 | `category_tab` = 常用 \| common_use / 学生 \| student / 生活 \| life / 职业 \| career |

**模块：证件列表** `card_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 常用 `common_use` | -- | button | scan_click | 按钮点击时 | `card_name` 证件名称 = 身份证 \| identification_card / 户口本 \| household_registration_booklet / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driver_license / 学生证 \| student_id_card / 证书 \| certificate / 毕业证 \| graduate_certificate |
| 学生 `student` | -- | button | scan_click | 按钮点击时 | `card_name` 证件名称 = 学生证 \| student_id_card / 证书 \| certificate / 毕业证 \| graduate_certificate / 四六级证书 \| cet_certificate |
| 生活 `life` | -- | button | scan_click | 按钮点击时 | `card_name` 证件名称 = 企业证件 \| business_certificate / 居住证 \| resident_license / 结婚证 \| marriage_certificate / 离婚证 \| divorce_certificate / 社保卡 \| social_security_card / 残疾人证 \| disability_certificate / 存折 \| passbook / 港澳通行证 \| HKM_permit / 出生医学证明（新版）\| birth_medical_certificate |
| 职业 `career` | -- | button | scan_click | 按钮点击时 | `card_name` 证件名称 = 教师资格证 \| teacher_qualification_certificate / 律师执业证 \| lawyer_practising_license / 医师 \| physician |

## 试卷场景特有

> **Sheet 说明**：注意：「处理页」和「预览页」所有按钮带有entry_scene属性值均需上报当前场景「scan_testpaper」


### 拍摄页 `scan_page`


**模块：扫描切换区域** `photo_scene`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 子扫描类型 `second_scene` |  | button | scan_click | 场景点击时 | `second_scene` 二级场景 = 去除笔迹：remove_handwriting / 收集错题：collecting_mistakes ；`isActiveClick` 区分主动点击和默认跳转 = 主动点击：1 / 默认跳转：0 |

### 全部文档页 `file_page`


**模块：扫描文档列表** `file_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 文件夹 `folder` |  | button | scan_click | 文件夹点击时 | `folder_name` 文件夹名称 = 我的错题本：mistake_notebook ；`folder_type` 文件夹类型 = 固定文件夹：fixed_folder / 用户创建的文件夹：ceate_folder |

### 我的错题本页 `mn_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show |  | `question_count` 题目数量 = mathematics:x; / chinese:x; / english:x; / science:x; / physics:x; / chemistry:x; / biology:x; / geography:x; / history:x; / politics:x; / chinese_humanities:x; / natural_science:x; / others:x; |
| — |  | page | scan_stay |  | `duration` 停留时长，单位：ms |
| — |  | page | scan_load |  | `duration` 耗时，单位：ms |

**模块：学科列表** `subjects_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 学科 `subject` |  | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |

**模块：底部编辑区** `edit_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 收集按钮 `collect` |  | button | scan_click | 按钮点击时 |  |

### 学科错题本页 `sn_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 页面展示时 | `question_count` 题目数量 = (数学)mathematics:x; / (语文)chinese:x; / (英语)english:x; / (科学)science:x; / (物理)physics:x; / (化学)chemistry:x; / (生物)biology:x; / (地理)geography:x; / (历史)history:x; / (政治)politics:x; / (文综)chinese_humanities:x; / (理综)natural_science:x; / (其他)others:x; |
| — |  | page | scan_stay |  | `duration` 停留时长，单位：ms |
| — |  | page | scan_load |  | `duration` 耗时，单位：ms |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 首页按钮 `homepage` |  | button | scan_click | 按钮点击时 |  |

**模块：题目列表** `question_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 选择按钮 `select` | x | button | scan_click | 按钮点击时 |  |
| 查看原试卷 `retrace` | x | button | scan_click | 按钮点击时 |  |
| 题目详情 `detail` | x | button | scan_click | 按钮点击时 |  |
| 标题修改 `edit` | x | button | scan_click | 按钮点击时 |  |
| AI解题 `ai_answers / （2025.5新增）` | x | button | scan_click | 按钮点击时 |  |

**模块：学科切换** `subject_switching`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show | 页面展示时 | `current_subject` 当前学科 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 进入 `entry` | x | button | scan_click | 按钮点击时 | `current_subject` 当前学科 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 切换 `switch` | x | button | scan_click | 按钮点击时 | `current_subject` 当前学科 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others ；`target_ subject` 目标学科 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 关闭 `close` | x | button | scan_click | 蒙层点击时 |  |

**模块：空状态** `empty_state`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 立即添加 `add` | x | button | scan_click | 按钮点击时 |  |

### 试卷错题本页 `pn_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 页面展示时 | `question_count` 题目数量 = x |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回按钮 `back` | x | button | scan_click | 按钮点击时 |  |

**模块：题目列表** `question_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 选择按钮 `select` | x | button | scan_click | 按钮点击时 |  |
| 标题修改 `edit` | x | button | scan_click | 按钮点击时 |  |

### 调整范围页 `rangeadjust_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 页面展示时 |  |

**模块：底部工具栏** `tool_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 确认 `confirm` | x | button | scan_click | 按钮点击时 |  |
| 删除此题 `delete` | x | button | scan_click | 按钮点击时 |  |
| 上一题 `previous` | x | button | scan_click | 按钮点击时 |  |
| 下一题 `next` | x | button | scan_click | 按钮点击时 |  |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回按钮 `back` | x | button | scan_click | 按钮点击时 |  |

### 添加题目页 `rangeadd_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 页面展示时 |  |

**模块：底部工具栏** `tool_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 确认 `confirm` | x | button | scan_click | 按钮点击时 |  |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回按钮 `back` | x | button | scan_click | 按钮点击时 |  |

### 多选页面 `multiple_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 页面展示时 | `entry_way` 进入方式 = 学科错题本页：sn_page / 试卷错题本页：pn_page |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 取消 `cancel` | x | button | scan_click | 按钮点击时 |  |
| 全选 `select_all` | x | button | scan_click | 按钮点击时 |  |
| 取消全选 `deselect_all` | x | button | scan_click | 按钮点击时 |  |

**模块：底部工具栏** `tool_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 删除 `delete` | x | button | scan_click | 按钮点击时 | `question_count` 选择的题目数量 |
| 打印 `print` | x | button | scan_click | 按钮点击时 | `question_count` 选择的题目数量 |

**模块：删除弹窗** `delete_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  |  |
| 删除按钮 `delete` | x | button | scan_click | 按钮点击 |  |
| 取消按钮 `cancel` | x | button | scan_click | 按钮点击 |  |

### 收集错题页 `collect_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show |  |  |
| — | x | page | scan_stay |  | `duration` 停留时长，单位：ms |
| — | x | page | scan_load |  | `duration` 耗时，单位：ms |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 关闭按钮 `close` | x | button | scan_click | 按钮点击时 |  |
| 图片管理 `image_manage` | x | button | scan_click | 按钮点击时 |  |
| 问题反馈 `feedback` | x | button | scan_click | 按钮点击时 |  |

**模块：笔迹模式切换** `handwriting_switch`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show | 开关展示时上报 |  |
| 有笔迹 `handwriting_retain` | x | button | scan_click | 点击切换至相应状态时上报 |  |
| 无笔迹 `handwriting_remove` | x | button | scan_click | 点击切换至相应状态时上报 |  |

**模块：题目区域** `question_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 选中 `select` | x | button | scan_click | 按钮点击时 |  |
| 取消选中 `cancel_select` | x | button | scan_click | 按钮点击时 |  |
| 编辑 `edit` | x | button | scan_click | 按钮点击时 |  |

**模块：底部工具栏** `tool_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 添加题目 `add` | x | button | scan_click | 按钮点击时 |  |
| 多栏分割 `split` | x | button | scan_click | 按钮点击时 |  |
| 保存到错题本 `save` | x | button | scan_click | 按钮点击时 | `question_count` 选择的题目数量 |
| AI解题 `ai_answers / （2025.5新增）` | x | button | scan_click | 按钮点击时 |  |

**模块：保存半屏** `save_panel`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 取消 `cancel` | x | button | scan_click | 按钮点击时 |  |
| 确认 `confirm` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others ；`grade` 年级 = 一年级：grade_1 / 二年级：grade_2 / 三年级：grade_3 / 四年级：grade_4 / 五年级：grade_5 / 六年级：grade_6 / 初一：junior_grade_1 / 初二：junior_grade_2 / 初三：junior_grade_3 / 高一：senior_grade_1 / 高二：senior_grade_2 / 高三：senior_grade_3 / 大学：university / 公务员考试：civil_service_exam / 考研：postgraduate_entrance_exam / 司法考试：judicial_exam / 教师资格证：teacher_certification / 注册会计师：tified_public_accountant / 未选择：not_selected ；`semester` 学期 = 上学期：last_semester / 下学期：next_semester / 未选择：not_selected |

### 图片处理页 `edit_page`


**模块：笔迹模式切换** `handwriting_switch`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show | 开关展示时上报 |  |
| 有笔迹 `handwriting_retain` | x | button | scan_click | 点击切换至相应状态时上报 |  |
| 无笔迹 `handwriting_remove` | x | button | scan_click | 点击切换至相应状态时上报 |  |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 关闭按钮 `close` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |

**模块：底部工具栏** `tool_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 公式识别 `formula` | x | button | scan_click | 按钮点击时 |  |

**模块：编辑类型选择区域** `edit_choose_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 完成按钮 `finish_btn` | x | button | scan_click | 按钮点击时 | `is_change_filter` 是否主动收集错题 = 是：true / 否：false ；`handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |

### 扫描件预览页 `preview_page`


**模块：笔迹模式切换** `handwriting_switch`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show | 开关展示时上报 |  |
| 有笔迹 `handwriting_retain` | x | button | scan_click | 点击切换至相应状态时上报 |  |
| 无笔迹 `handwriting_remove` | x | button | scan_click | 点击切换至相应状态时上报 |  |

**模块：底部编辑区** `edit_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 打印按钮 `print` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |
| 导出按钮 `export` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |
| 编辑按钮 `edit` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |
| 查看错题按钮 `review_mistakes` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |
| 收集错题按钮 `collecting_mistakes` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| AI解题 `ai_answers` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove ；`page_from` 页面类型 = 从处理页进入：editpage / 从首页/全部文档列表进入：list |
| 上一页 `page_up` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |
| 下一页 `page_down` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |

**模块：半屏面板** `half_panel`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 收集错题 `collecting_mistakes` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |
| AI解题 `ai_answers` | x | button | scan_click | 按钮点击时 | `handwriting_mode` 笔迹模式 = 有笔迹：retain / 无笔迹：remove |

## 票据场景特有


### 处理页 `edit_page`


**模块：扫描票据（12月新增）** `scan_receipt`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 提取识别 `structured_extract` |  | button | scan_click | 按钮点击时 | `扫描票据（12月新增）` |
| 复制全部 `copy_all` |  | button | scan_click | 按钮点击时 | `扫描票据（12月新增）` |

### 票据列表页 `receipt_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show |  | `扫描票据（12月新增）` |
| — |  | page | scan_stay |  | `duration` 停留时长，单位：ms ；`扫描票据（12月新增）` |
| — |  | page | scan_load |  | `duration` 耗时，单位：ms ；`扫描票据（12月新增）` |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` |  | button | scan_click |  | `null` null ；`扫描票据（12月新增）` |

**模块：票据列表** `receipt_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 票据 `file_reextract` |  | button | scan_click | 点击“重新识别”时 | `扫描票据（12月新增）` |

## 我的错题本特有

> **Sheet 说明**：注意：「处理页」和「预览页」所有按钮带有entry_scene属性值均需上报当前场景「scan_testpaper」


### 我的错题本页 `mn_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — |  | page | scan_show | 页面展示时 | `question_count` 题目数量 = mathematics:x; / chinese:x; / english:x; / science:x; / physics:x; / chemistry:x; / biology:x; / geography:x; / history:x; / politics:x; / chinese_humanities:x; / natural_science:x; / others:x; |
| — |  | page | scan_stay | 页面停留时 | `duration` 停留时长，单位：ms |
| — |  | page | scan_load | 页面加载时 | `duration` 耗时，单位：ms |

**模块：学科列表** `subjects_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 学科 `subject` |  | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回按钮 `back` |  | button | scan_click | 按钮点击时 |  |
| 题目管理 `question_management` |  | button | scan_click | 按钮点击时 |  |

**模块：题目列表** `question_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 选择按钮 `select` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 查看试卷原图 `retrace_pic` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 查看解析 `detail` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 标题修改 `edit` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 去解题 `ai_answers` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 批改详情 `ai_paper_correction` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |

**模块：全选** `all_select`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 全选 `select` | x | button | scan_click | 按钮点击时 |  |

**模块：底部编辑区** `edit_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 收集按钮 `collect` | x | button | scan_click | 按钮点击时 |  |

**模块：底部打印题目** `edit_print`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 打印题目按钮 `edit_print_paper` | x | button | scan_click | 按钮点击时 | `question_count` 选择的题目数量 |

**模块：底部导出题目** `edit_export`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导出题目按钮 `edit_export_paper` | x | button | scan_click | 按钮点击时 |  |

**模块：空状态** `empty_state`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 立即添加 `add` | x | button | scan_click | 按钮点击时 |  |

### 试卷错题本页 `pn_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 页面展示时 | `question_count` 题目数量 = mathematics:x; / chinese:x; / english:x; / science:x; / physics:x; / chemistry:x; / biology:x; / geography:x; / history:x; / politics:x; / chinese_humanities:x; / natural_science:x; / others:x; |
| — | x | page | scan_stay | 页面停留时 | `duration` 停留时长，单位：ms |

**模块：学科列表** `subjects_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 学科 `subject` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |

**模块：顶部导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回按钮 `back` | x | button | scan_click | 按钮点击时 |  |
| 题目管理 `question_management` | x | button | scan_click | 按钮点击时 |  |

**模块：题目列表** `question_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 选择按钮 `select` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 查看试卷原图 `retrace_pic` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 查看解析 `detail` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 标题修改 `edit` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 去解题 `ai_answers` | x | button | scan_click | 按钮点击时 | `subject_name` 学科名称 = 数学：mathematics / 语文：chinese / 英语：english / 科学：science / 物理：physics / 化学：chemistry / 生物：biology / 地理：geography / 历史：history / 政治：politics / 文综：chinese_humanities / 理综：natural_science / 其他：others |
| 批改详情 `ai_paper_correction` | x | button | scan_click | 按钮点击时 |  |

**模块：全选** `all_select`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 全选 `select` | x | button | scan_click | 按钮点击时 |  |

**模块：底部编辑区** `edit_area`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 收集按钮 `collect` | x | button | scan_click | 按钮点击时 |  |

**模块：底部打印题目** `edit_print`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 打印题目按钮 `edit_print_paper` | x | button | scan_click | 按钮点击时 | `question_count` 选择的题目数量 |

**模块：空状态** `empty_state`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 立即添加 `add` | x | button | scan_click | 按钮点击时 |  |

**模块：底部导出题目** `edit_export`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导出题目按钮 `edit_export_test` | x | button | scan_click | 按钮点击时 |  |

### 题目管理页 `manage_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 页面展示时 | `entry_way` 进入方式 = 我的错题本页：mn_page / 试卷错题本页：pn_page |

**模块：题目列表** `question_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 选择按钮 `select` | x | button | scan_click | 按钮点击时 |  |
| 查看试卷原图 `retrace_pic` | x | button | scan_click | 按钮点击时 |  |
| 查看解析 `detail` | x | button | scan_click | 按钮点击时 |  |
| 标题修改 `edit` | x | button | scan_click | 按钮点击时 |  |
| 去解题 `ai_answers` | x | button | scan_click | 按钮点击时 |  |
| 批改详情 `ai_paper_correction` | x | button | scan_click | 按钮点击时 |  |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` | x | button | scan_click | 按钮点击时 |  |
| 全选 `select_all` | x | button | scan_click | 按钮点击时 |  |

**模块：底部工具栏** `tool_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 删除 `delete` | x | button | scan_click | 按钮点击时 | `question_count` 选择的题目数量 |

**模块：删除弹窗** `delete_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  |  |
| 删除按钮 `delete` | x | button | scan_click | 按钮点击 |  |
| 取消按钮 `cancel` | x | button | scan_click | 按钮点击 |  |

### 试卷-管理页 `pn_manage_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 页面展示时 | `entry_way` 进入方式 = 我的错题本页：mn_page / 试卷错题本页：pn_page |

**模块：题目列表** `question_list`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 选择按钮 `select` | x | button | scan_click | 按钮点击时 |  |
| 查看原图 `retrace_pic` | x | button | scan_click | 按钮点击时 |  |
| 查看解析 `detail` | x | button | scan_click | 按钮点击时 |  |
| 标题修改 `edit` | x | button | scan_click | 按钮点击时 |  |
| 去解题 `ai_answers` | x | button | scan_click | 按钮点击时 |  |
| 批改详情 `ai_paper_correction` | x | button | scan_click | 按钮点击时 |  |

**模块：导航条** `nav_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 返回 `back` | x | button | scan_click | 按钮点击时 |  |
| 全选 `select_all` | x | button | scan_click | 按钮点击时 |  |

**模块：底部工具栏** `tool_bar`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 删除 `delete` | x | button | scan_click | 按钮点击时 | `question_count` 选择的题目数量 |

**模块：删除弹窗** `delete_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | module | scan_show |  |  |
| 删除按钮 `delete` | x | button | scan_click | 按钮点击 |  |
| 取消按钮 `cancel` | x | button | scan_click | 按钮点击 |  |

## 拍照生成特有

> **Sheet 说明**：注意：「处理页」和「预览页」所有按钮带有entry_scene和second_entry_scene / 属性值均需上报entry_scene=generate_pic，second_entry_scene=mindmap 、flowchart、structural_diagram


### 首页 `home_page`


**模块：功能卡片** `function_card`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 卡片按钮 `card_btn` | x | button | scan_click | 卡片点击时 | `card_name` 卡片名称 = generate_pic \| 拍照生成 |
| 卡片按钮 `card_btn` | x | button | scan_show | 卡片曝光时 | `card_name` 卡片名称 = generate_pic \| 拍照生成 |

### m `scan_page`


**模块：扫描切换区域** `photo_scene`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 扫描类型 `scene` | x | button | scan_click | 场景点击时 | `scene` 扫描场景 = generate_pic \| 拍照生成 |
| 扫描类型 `scene` | x | page | scan_show | 场景展示时 | `scene` 扫描场景 = generate_pic \| 拍照生成 ；`second_scene` 二级场景 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| 扫描类型 `scene` | x | page | scan_show | 场景滑动切换时 | `scene` 扫描场景 = generate_pic \| 拍照生成 ；`second_scene` 二级场景 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| 子扫描类型 `second_scene` | x | button | scan_click | 场景点击时 | `second_scene` 二级场景 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |

### 生成过程页 `generate_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show | 页面展示时 | `generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| — | x | page | scan_stay | 页面停留 | `duration` 停留时长/ms ；`generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| — | x | page | scan_load | 页面加载 | `duration` 加载时长/ms ；`generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |

**模块：生成中状态** `generate_process`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 生成中状态卡片 `process_card` | x | module | scan_show | 卡片曝光时 |  |
| 取消 `cancel` | x | button | scan_click | 按钮点击时 |  |
| — | x | page | scan_load | 总结生成加载 | `duration` 加载时长/ms |

### 生成结果预览页 `preview_page`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | x | page | scan_show |  | `page_from` 页面来源 = 从生成过程页进入：generate_page ；`generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| — | x | page | scan_load |  | `page_from` 页面来源 = 从生成过程页进入：generate_page |

**模块：图片总结** `pic_summary`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 图片总结卡片 `summary_card` | x | module | scan_show | 卡片曝光时 |  |
| 图片总结卡片 `summary_card` | x | button | scan_click | 按钮点击时 |  |
| 总结图片缩略图 `summary_pic` | x | button | scan_click | 按钮点击时 |  |
| 总结图片缩略图 `summary_pic` | x | page | scan_show | 图片缩略图展示时 |  |
| 下载图片缩略图 `summary_pic_download` | x | button | scan_click | 按钮点击时 |  |
| 关闭图片缩略图 `summary_pic_close` | x | button | scan_click | 按钮点击时 |  |
| 复制总结内容 `summary_copy` | x | button | scan_click | 按钮点击时 |  |
| 重新生成总结内容 `summary_reload` | x | button | scan_click | 按钮点击时 |  |
| 导出总结内容 `summary_toword` | x | button | scan_click | 按钮点击时 |  |
| 修改总结内容 `summary_edit` | x | button | scan_click | 按钮点击时 |  |
| 修改总结内容_更精简 `summary_edit_simplify` | x | button | scan_click | 按钮点击时 |  |
| 修改总结内容_扩充细节 `summary_edit_expand` | x | button | scan_click | 按钮点击时 |  |
| 修改总结内容_分点梳理 `summary_edit_structure` | x | button | scan_click | 按钮点击时 |  |
| 修改总结内容_更正式 `summary_edit_formal` | x | button | scan_click | 按钮点击时 |  |
| 修改总结内容_确认弹窗 `re_summary_alert` | x | module | scan_show | 卡片曝光时 |  |
| 修改总结内容_确认弹窗_采用 `summary_accept` | x | button | scan_click | 按钮点击时 |  |
| 修改总结内容_确认弹窗_弃用 `summary_cancel` | x | button | scan_click | 按钮点击时 |  |

**模块：图片预览** `pic_preview`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 图片预览区域 `summary_cancel` | x | module | scan_show | 卡片曝光时 | `generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| tab_思维导图 `mindmap` | x | button | scan_click | 按钮点击时 |  |
| tab_流程图 `flowchart` | x | button | scan_click | 按钮点击时 |  |
| tab_结构图 `structural_diagram` | x | button | scan_click | 按钮点击时 |  |

**模块：底部工具栏** `bottom_tool`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 重新生图 `re_generate` | x | button | scan_click | 按钮点击时 | `generate_type` 图片类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| 重新生图 `re_generate` | x | button | scan_load | 重新生成时加载 | `duration` 加载时长/ms ；`generate_type` 图片类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| 重新生图_确认弹窗 `re_generate_alert` | x | module | scan_show | 卡片曝光时 | `generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| 重新生图_确认弹窗_采用 `alert_accept` | x | button | scan_click | 按钮点击时 | `generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| 重新生图_确认弹窗_弃用 `alert_cancel` | x | button | scan_click | 按钮点击时 | `generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |
| 更改样式 `change_template` | x | button | scan_click | 按钮点击时 |  |
| 更改样式 `change_template` | x | module | scan_show | 卡片曝光时 |  |
| 样式类型 `template` | x | button | scan_click | 按钮点击时 | `template` 模板类型 |
| 关闭样式面板 `cancel_template` | x | button | scan_click | 按钮点击时 |  |
| 导出图片 `save_pic` | x | button | scan_click | 按钮点击时 | `generate_type` 图片类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 ；`template` 模板类型 ；`is_change_template` 是否更改过模板 = 0 \| 没有 / 1 \| 更改过 |

### 导出预览页（万能扫描） `preview_page`


**模块：导出弹窗** `export_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导出方式选择 `export` | x | button | scan_click | 按钮点击时 | `generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |

### 多选页面 `multiple_page`


**模块：导出弹窗** `export_popup`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 导出方式选择 `export` | x | button | scan_click | 按钮点击时 | `generate_type` 生成类型 = mindmap \| 思维导图 / flowchart \| 流程图 / structural_diagram \| 结构图 |

## 开学季活动特有


### 拍摄页 `scan_page`


**模块：活动** `activity`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 活动入口 `entrance` |  | button | scan_show | 活动入口展示时 | `activity_name` 活动名 = school_opens |
| 活动入口 `entrance` |  | button | scan_click | 点击活动入口时 | `activity_name` 活动名 = school_opens |
| 活动入口 `close` |  | button | scan_click | 点击关闭入口时 | `activity_name` 活动名 = school_opens |

**模块：新手引导提示** `school_opens_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 开学季活动新手引导提示 `school_opens_tips` | -- | module | scan_show | 提示条曝光时 |  |
| 关闭 `close` | -- | button | scan_click | 点击时 |  |

### 处理页 `edit_page`


**模块：活动** `activity`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 活动入口 `entrance` |  | button | scan_show | 活动入口展示时 | `activity_name` 活动名 = school_opens |
| 活动入口 `entrance` |  | button | scan_click | 点击活动入口时 | `activity_name` 活动名 = school_opens |
| 活动入口 `close` |  | button | scan_click | 点击关闭入口时 | `activity_name` 活动名 = school_opens |

**模块：新手引导提示** `school_opens_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 开学季活动新手引导提示 `school_opens_tips` | -- | module | scan_show | 提示条曝光时 |  |
| 关闭 `close` | -- | button | scan_click | 点击时 |  |

### 预览页 `preview_page`


**模块：活动** `activity`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 活动入口 `entrance` |  | button | scan_show | 活动入口展示时 | `activity_name` 活动名 = school_opens |
| 活动入口 `entrance` |  | button | scan_click | 点击活动入口时 | `activity_name` 活动名 = school_opens |
| 活动入口 `close` |  | button | scan_click | 点击关闭入口时 | `activity_name` 活动名 = school_opens |

**模块：新手引导提示** `school_opens_tips`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 开学季活动新手引导提示 `school_opens_tips` | -- | module | scan_show | 提示条曝光时 |  |
| 关闭 `close` | -- | button | scan_click | 点击时 |  |

### 活动卡片 `card`


**模块：$页面级事件**

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| — | -- | page | scan_show | 卡片展示时 | `page_position` 所在页面 = scan_page:拍摄页 / edit_page:处理页 / preview_page:预览页 ；`card_type` 卡片类型 = 根据服务端返回显示 |

**模块：按钮** `button`

| 元素 | 位置 | 类型 | 事件 | 触发时机 | 属性 |
|---|---|---|---|---|---|
| 收下卡片 `accept` | -- | button | scan_click | 点击时 | `page_position` 所在页面 = scan_page:拍摄页 / edit_page:处理页 / preview_page:预览页 ；`card_type` 卡片类型 = 根据服务端返回显示 |
| 进入活动页 `gotoh5` | -- | button | scan_click | 点击时 | `page_position` 所在页面 = scan_page:拍摄页 / edit_page:处理页 / preview_page:预览页 ；`card_type` 卡片类型 = 根据服务端返回显示 |
| 关闭 `close` | -- | button | scan_click | 点击时 | `page_position` 所在页面 = scan_page:拍摄页 / edit_page:处理页 / preview_page:预览页 ；`card_type` 卡片类型 = 根据服务端返回显示 |

## 四、其他场景埋点


## 性能埋点方案

> 性能/链路类埋点（与行为埋点分开管理），用于监控扫描各环节耗时与成功率。

### 公共属性

| 属性名 | 中文/说明 | 取值 |
|---|---|---|
| `action_id` | 拍照扫描场景id，点击首页或者工具落地页任一位置进行扫描落地页时生成，一直透传到保存成功落地页 | 32位的UUID，格式是xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx，保证全局唯一 |
| `track_id` | 拍照扫描主链路ID，点击拍照扫描落地页拍照按钮时生成，每点击一下则重新生成一次，一直透传到保存成功落地页 | 32位的UUID，格式是xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx，保证全局唯一 |
| `operation` | 功能操作 | start_camera \| 启动相机 |
| `operation` | 功能操作 | edge \| 聚焦 |
| `operation` | 功能操作 | recognition \| 边缘识别 |
| `operation` | 功能操作 | take_pic \| 拍照 |
| `scene` | 扫描场景 | 如扫描证件 / 扫描证件 \| scan_credentials / 扫描书籍 \| scan_books / 万能扫描 \| universal_scanning / 转word \| convert_word / 转表格 \| convert_execl / 文字识别 \| text_recognition / 图片翻译 \| image_translation / 扫描试卷｜scan_testpaper（11月新增） |
| `second_scene` | 二级场景，如scene = 扫证件下的身份证、户口、驾驶证 | 如扫描身份证 / 通用证件 \| universal_card / 身份证 \| identification card / 户口本 \| household_registration_booklet / 银行卡 \| bank_card / 护照 \| passport / 营业执照 \| business_license / 驾驶证 \| driver_license |
| `status` | 各环节请求的结果状态 | success \| 成功 |
| `status` | 各环节请求的结果状态 | fail_reason \| 失败 |
| `status` | 各环节请求的结果状态 | discontinue \| 中断识别 |
| `fail_reason` | 失败原因 | 非字符串，双端研发自行定义，尽可能统一 |

### 事件清单

| 处理环节 | 功能/操作 | 具体操作节点 | 事件名 | 上报时机 | 属性 | 取值/说明 |
|---|---|---|---|---|---|---|
| 启动相机 | 点击扫描按钮 | 点击【扫描】按钮至出现拍摄画面 | scan_proc_start | 启动相机到预览界面呈现后 | `cost` 单位ms，此环节总时长，steps1+steps2+steps3； ；`steps1` 单位ms，点击扫描-出现拍摄画面； |  |
| 聚焦(仅安卓，iOS没有回调） | 画面聚焦 | 出现画面聚焦 | scan_proc_rec_focus | 用户点击屏幕尝试聚焦，聚焦结果返回时 | `cost` 单位ms，此环节总时长，steps1+steps2+steps3； ；`steps1` 单位ms，点击屏幕尝试聚焦-画面聚焦结果 ；`result` success/fail，聚焦成功或者失败 |  |
| 识别 | 边缘识别 | 拍摄页面-边缘识别成功 | scan_proc_rec_rectangle | 点击完成，进入处理页时 | `cost` 单位ms，此环节总时长，steps1+steps2+steps3； ；`steps1` 单位ms，点击完成时，在每隔1秒处理的30帧图像中，边缘识别结果的平均耗时 / 成功和失败分开报，取各自的平均值 ；`result` success/fail，边缘识别成功或者失败，在进入处理页前可能会出现多次成功或者失败，取平均值 ；`numbers` 当前识别张数 |  |
| 拍照 | 拍照 | 点击【拍照】按钮至拍摄完成 | scan_proc_rec_shoot | 进入处理页前 | `cost` 单位ms，此环节总时长，steps1+steps2 ；`steps1` 拍照按钮-拍摄成功（拿到图片） ；`steps2` 图片处理，裁剪+矫正+存盘 ；`result` success/fail，拍摄成功或者失败 ；`numbers` 拍照张数 | IOS 暂不处理 先传-1 |
| 图片（或文档）导入 | 导入图片 | 点击【确认导入】至出现编辑页 | scan_proc_rec_import | 点击确认导入+第一张图片处理返回后上报 | `cost` 单位ms，此环节总时长，steps1+steps2+steps3； ；`steps1` 单位ms，点击确认导入-出现编辑页； ；`format` word/pdf/ppt/excel/picture ；`result` success/fail，导入成功和失败 ；`size` 导入图片/扫描件大小 ；`numbers` 导入张数 |  |
| 图片处理 | 一键清晰 / 初次切换【增强/黑白/锐化/灰度】 / 多次切换【增强/黑白/锐化/灰度】 / 去手写 / 去屏纹 / 文字识别 / 智能消除 | 点击【一键清晰】至生成清晰图片 / 基于拍照后初始状态，点击切换滤镜 / 重复、再次点击不同滤镜 / 点击【去手写】按钮至生成无手写字图片 / 点击【去屏纹】按钮至生成无屏纹图片 / 点击【文字提取】按钮至提取到文本 / 点击【文字提取】按钮至提取到文本 | scan_proc_rec_func | 返回每张图片“处理结果”时上报 | `cost` 单位ms，此环节总时长，steps1+steps2+steps3+steps4； ；`steps1` 单位ms，上传流程；仅一键清晰等服务化接口有 ；`steps2` 单位ms，处理流程；服务接口和本地SDK都有 ；`steps3` 单位ms，下载流程；仅一键清晰等服务化接口有 ；`steps1` 单位ms，由于滤镜现在将上传，处理和下载三个流程合并成单个接口，步骤合并 ；`steps4` 单位ms，显示流程；服务接口和本地SDK都有 ；`pre_size` 压缩前：导入图片/扫描件大小 ；`after_size` 压缩后：导入图片/扫描件大小 ；`func` smart_clarify：智能滤镜 / enhance： 增强 / black_white：黑白 / sharpen：锐化 / grayscale：灰度 / wipe_handwriting：纯去手写 / wipe_handwriting_%s：去手写，%s为叠加的滤镜 / wipe_moire：去摩尔纹 / wipe_moire_%s：去摩尔纹，%s为叠加的滤镜 / wipe_smart：智能擦除 / extract_text：提取文字 / x_y_z：x,y,z都为功能的名称，用于多种功能叠加 ；`result` success/fail，图片处理结果成功或者失败 ；`type` api/sdk/api_and_sdk，服务处理和客户端处理 ；`page_name` scan_shoot_page: 图片处理发生在拍摄页面 / scan_process_page：图片处理发生在处理页面 ；`appy_all` true/false，当前效果是否应用到全部图片 / 为true时，cost为总耗时 / 为false时，cost为单张图片的耗时，且无需统计图片总数 ；`numbers` 导入张数（仅滤镜应用全部时上报） |  |
| 文件类型转换 | 转word / 转excel / 转pdf / 转ppt（2025.11新增） | 点击【导出为wordl】至生成word / 点击【导出为excel】至生成excel / 点击【导出为pdf】至生成pdf / 点击【导出为ppt】至生成ppt | scan_proc_rec_convert | 呈现结果时（出现预览）上报 | `cost` 单位ms，此环节总时长，steps1+steps2 ；`steps1` 单位ms，打包文件耗时 ；`steps1` 单位ms，解压文件耗时，仅当type为扫描件时有此流程； ；`steps1` 单位ms，上传流程 ；`steps2` 单位ms，处理流程 ；`steps5` 单位ms，下载流程 ；`target_format` 转换的格式，word/pdf/ppt/excel ；`scan_total_size` 全部上传成功后，导入图片/扫描件的总大小 ；`numbers` 实际上传张数 |  |
| 文档解压 | 预览页面打开扫描件 | 将文件进行解压 | scan_proc_rec_compress | 解压完成进行上报 | `cost` 单位ms，此环节总时长，steps1 ；`steps1` 单位ms，解压文件耗时 ；`size` 文档的大小 ；`pages` 文档的页数 ；`item` 结果图+原图: origin_and_result / 结果图：result |  |
| 图片处理 | 【万能扫描】编辑页图片处理 | 点击【万能扫描】入口拍摄图片 / 编辑页图片处理 | scan_proc_rec_process | 编辑页处理完成上报 | `mode` 扫描件模式 ；`numbers` 拍照张数 ；`step` begin/end，编辑页处理开始/结束 ；`result` success/fail，编辑页处理成功/失败 ；`is_reedit` 是否二次编辑 /  "true：是 / false：否" ；`fail_msg` 失败错误信息 | 仅安卓 ；仅安卓 ；仅安卓 ；仅安卓 ；仅安卓 ；仅安卓 |
| 扫描件保存 | 扫描件处理完成保存至扫描库 | 点击【完成】至扫描件保存本地 | scan_proc_rec_save | 保存流程结束后进行上报 | `mode` 扫描件模式，取值同mode_switch点击完成时的模式 ；`numbers` 拍照张数 ；`result` success/fail，保存本地成功或者失败 ；`is_reedit` 是否二次编辑 /  "true：是 / false：否" ；`fail_msg` 失败错误信息 |  |
| 扫描件上云 | 扫描件上云 | 点击【完成】后扫描件触发上云 | scan_proc_rec_cloud | 上云流程结束后上报 | `mode` 扫描件模式 ；`step` begin/end，上云开始/结束 ；`result` success/fail，上云成功/失败 ；`fail_msg` 失败错误信息 | 仅安卓 ；仅安卓 ；仅安卓 ；仅安卓 |
| 扫描件打开 | 扫描件打开 | 点击扫描件及成功打开后上报 | scan_file_open |  | `step` begin/end ；`result` success/fail ；`fail_msg` 失败错误信息 |  |
| 扫描件转换word等 | 扫描件转换 | 扫描转换开始及结束上报 | scan_file_convert |  | `step` begin/end ；`result` success/fail ；`fail_msg` 失败错误信息 |  |

## 小程序埋点

> 微信小程序场景的埋点（独立体系，与移动端 App 埋点解耦）。


### 默认参数 / 公共属性

| 参数 | 参数名 | 上报属性 | 参数说明 | 备注 | 添加日期 | 产品 | 开发 |
|---|---|---|---|---|---|---|---|
| _scene | 场景值 | string(字符串) | 场景值参数定义 | https://developers.weixin.qq.com/miniprogram/dev/reference/scene-list.html | 20190302 |  |  |
| _iswpsplus | 判断是否为新企业账号 | string(字符串) | 判断是否为新企业账号: 1=新企业账号；0=非新企业账号；null=未登录 |  | 20190410 |  |  |
| _entrance_source | 扫码场景值 | string(字符串) |  | 小程序扫二维码打开时，扫码的场景值from | 20191204 |  |  |
| _flag | 标记 | string(字符串) | login0=A方案；login1=B方案 | 用于标记优化方案 | 20190410 | 陈诗颖 | 程俊森 |

### 扫描小程序埋点

| 参数 | 参数名 | 上报属性 | 参数说明 | 备注 | 添加日期 | 产品 | 开发 |
|---|---|---|---|---|---|---|---|
| entrance | 入口 | string | homepage等原值不变，新增以下： / component_word \| 在线文字组件 / component_excel \| 在线表格 / component_et \| 智能表格 |  | 20251125 | 郭秋韵 |  |
| page_name | 页面名称 | string | scan_page \| 拍摄页 / edit_page \| 处理页 / crop_page \| 裁剪旋转页 / page_2word \| 转Word / page_2Excel \| 转Excel / page_2form \| 转收集表 |  | 20251125 | 郭秋韵 |  |
| entry_scene | 一级进入场景名称（默认定位到功能入口也上报） | string | file_scan \| 拍照扫描 / convert_word \| 转Word / convert_excel \| 转Excel / convert_form \| 转收集表 / conver_pdf \| 转PDF |  | 20251125 | 郭秋韵 |  |
| action | 操作 | string | show｜展示； |  | 20251125 | 郭秋韵 |  |
| entrance | 入口 | string | homepage等原值不变，新增以下： / component_word \| 在线文字组件 / component_excel \| 在线表格 / component_et \| 智能表格 |  | 20251125 | 郭秋韵 |  |
| page_name | 页面名称 | string | scan_page \| 拍摄页 / edit_page \| 处理页 / crop_page \| 裁剪旋转页 / page_2word \| 转Word / page_2Excel \| 转Excel / page_2form \| 转收集表 |  | 20251125 | 郭秋韵 |  |
| entry_scene | 一级进入场景名称（默认定位到功能入口也上报） | string | file_scan \| 拍照扫描 / convert_word \| 转Word / convert_excel \| 转Excel / convert_form \| 转收集表 / conver_pdf \| 转PDF |  | 20251125 | 郭秋韵 |  |
| action | 操作 | string | click \| 点击 |  | 20251125 | 郭秋韵 |  |
| element_name | 元素名称 | string | back \| 返回 / file_scan \| 拍照扫描tab / convert_word \| 转Word / convert_excel \| 转Excel / convert_form \| 转收集表 / convert_pdf \| 转PDF / wechat_file \| 微信文件 / album \| 相册 / photograph \| 拍照 / replace_pic \| 更换图片 / crop \| 裁剪旋转入口 / crop_left \| 向左旋转 / crop_right \| 向右旋转 / finbtn_crop \| 确认裁剪 / filter \| 点击切换滤镜 / insert_pic \| 插入 |  | 20251125 | 郭秋韵 |  |
| filter | 滤镜 | string | source \| 原图 / optimization \| 优化 / intelligent \| 智能 / sharpen \| 锐化 / enhance \| 增强 / blackwhite \| 黑白 / grayscale \| 灰度 / inksaving \| 省墨 | 点击处理页底部的转Word、转Excel、转PDF、转收集表时上报 / antion = click， / page_name=edit_page，element_name=convert_word/convert_excel/convert_form/conver_pdf | 20251125 | 郭秋韵 |  |
| result | 转换结果 | string | success｜成功； / fail｜失败 | 点击处理页底部的转Word、转Excel、转PDF、转收集表时上报 / antion = click， / page_name=edit_page，element_name=convert_word/convert_excel/convert_form/conver_pdf | 20251125 | 郭秋韵 |  |
| costtime | 耗时 | string | result = success时上报耗时 | 点击处理页底部的转Word、转Excel、转PDF、转收集表时上报 / antion = click， / page_name=edit_page，element_name=convert_word/convert_excel/convert_form/conver_pdf | 20251125 | 郭秋韵 |  |
| errorcode | 错误原因 | string | result = fail时上报错误码 | 点击处理页底部的转Word、转Excel、转PDF、转收集表时上报 / antion = click， / page_name=edit_page，element_name=convert_word/convert_excel/convert_form/conver_pdf | 20251125 | 郭秋韵 |  |
| filetype | 转换文档类型 | string | 文档后缀名 | 点击处理页底部的转Word、转Excel、转PDF、转收集表时上报 / antion = click， / page_name=edit_page，element_name=convert_word/convert_excel/convert_form/conver_pdf | 20251125 | 郭秋韵 |  |
| insert_comp / （组件内插入时才上报此字段） | 插入的组件 | string | component_word \| 在线文字组件 / component_excel \| 在线表格 / component_et \| 智能表格 | 点击处理页底部的转Word、转Excel、转PDF、转收集表时上报 / antion = click， / page_name=edit_page，element_name=convert_word/convert_excel/convert_form/conver_pdf | 20251125 | 郭秋韵 |  |

### 小程序_组件埋点

| 参数 | 参数名 | 上报属性 | 参数说明 | 备注 | 添加日期 | 产品 | 开发 |
|---|---|---|---|---|---|---|---|
| click | 点击 | string | insert_scan \| 添加图片_拍照扫描 |  | 20251125 | 郭秋韵 | @任同福 |
| entry_scene | 进入场景名称 | string | file_scan \| 拍照扫描 | 当click=insert_scan，返回转换结果时上传 | 20251125 | 郭秋韵 | @任同福 |
| result | 转换结果 | string | success｜成功； / fail｜失败 | 当click=insert_scan，返回转换结果时上传 | 20251125 | 郭秋韵 | @任同福 |
| errorcode | 错误原因 | string | result = fail时上报错误码 | 当click=insert_scan，返回转换结果时上传 | 20251125 | 郭秋韵 | @任同福 |
| value | 点击 | string | insert__cellpic__scan \| 插入_单元格图片_拍照扫描 |  | 20251125 | 郭秋韵 | @李永成 |
| entry_scene | 进入场景名称 | string | file_scan \| 拍照扫描 | 当click=insert__cellpic__scan，返回转换结果时上传 | 20251125 | 郭秋韵 | @李永成 |
| result | 转换结果 | string | success｜成功； / fail｜失败 | 当click=insert__cellpic__scan，返回转换结果时上传 | 20251125 | 郭秋韵 | @李永成 |
| errorcode | 错误原因 | string | result = fail时上报错误码 | 当click=insert__cellpic__scan，返回转换结果时上传 | 20251125 | 郭秋韵 | @李永成 |