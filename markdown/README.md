# TRAE_RTL - Protocol Arbiter RTL 项目

基于 Excel 配置自动生成、验证与管理的 DDR 协议仲裁器 RTL 代码仓库。

## 📁 目录结构

```
TRAE_RTL/
├── rtl/                    # 最新版 RTL 源码（SystemVerilog）
├── scripts/                # Python 自动化脚本
├── markdown/               # 项目文档与报告
├── xlsx/                   # Excel 配置表（Protocol Arbiter 系列）
├── Room/                   # 历史备份版本（rtl_0930、rtl_backup 等）
├── .gitignore             # 仿真波形、日志、构建产物忽略规则
└── .spec-workflow/        # 迁移与规格文档
```

## 🚀 核心功能

1. **Excel → RTL 自动生成**  
   读取 `xlsx/Protocol_Arbiter*.xlsx` 配置，自动生成对应 RTL（`rtl/*.sv`）。

2. **端口一致性验证**  
   脚本自动比对 Excel 与 RTL 端口定义，输出差异报告到 `markdown/`。

3. **QoS 优先级仲裁逻辑**  
   支持可配置的优先级策略，已回退至统一非区分方案（详见提交历史）。

4. **回归验证流水线**  
   `scripts/verify_rtl.sh` + `scripts/check_excel.py` 一键完成语法、端口、数据一致性检查。

## 🛠️ 快速开始

```bash
# 1. 安装 Python 依赖（如需要）
pip install -r requirements.txt

# 2. 生成最新 RTL
python scripts/generate_rtl_from_excel.py

# 3. 运行完整验证
bash scripts/verify_rtl.sh
```

## 📊 关键脚本

| 脚本 | 作用 |
|------|------|
| `generate_rtl_from_excel.py` | Excel → RTL 自动生成 |
| `check_excel.py` | Excel 数据合法性检查 |
| `compare_rtl_excel_ports.py` | 端口一致性比对 |
| `run_complete_rtl_flow.py` | 一键完整流程 |

## 📋 文档索引

- 迁移与规格文档：`markdown/RTL_Generation_Summary.md`  
- 端口对应关系：`markdown/detailed_port_correspondence_report.md`  
- 语法错误记录：`markdown/rtl_syntax_error_report.md`  
- QoS 修改记录：`markdown/qos_priority_modification_report.md`

## 🔄 版本管理

- **main 分支**：稳定可综合版本（当前）
- **feature/**：新功能开发（如 CI、LFS）  
- 历史备份：`Room/rtl_0930/`、`Room/rtl_backup/` 等保留完整历史。

## 📦 Git LFS（可选）

大文件（*.vcd、*.fsdb、*.xlsx）已配置 LFS 跟踪，克隆时自动拉取：

```bash
git lfs install
git clone git@github.com:GinoZMYS/trae-rtl.git
```

## 🤝 贡献流程

1. Fork & 创建 feature 分支  
2. 提交前运行 `bash scripts/verify_rtl.sh` 确保无回归  
3. 提交 Pull Request，CI 通过后由维护者合并

## 📄 许可证

MIT License - 详见 LICENSE 文件（如有）

> 自动生成于 TRAE IDE，基于 Excel 配置驱动，持续迭代中 🚧