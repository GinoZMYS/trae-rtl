## 目标

* 将当前 TRAE\_RTL 仓库及工作记录完整迁移到新电脑，保证可继续在 TRAE 环境中迭代。

* 交付一份可执行的 SPEC 文档（Requirements → Design → Tasks → Implementation），系统化记录此前所有需求与实现方案，作为新环境的持续开发依据。

## 迁移方案

* 代码迁移：

  * Git：在旧电脑完成本地变更暂存并推送到远端（或创建裸仓库），新电脑 `git clone` 获取；保留分支与提交历史。

  * 压缩/同步：`tar/zip/rsync` 同步整个 `TRAE_RTL` 目录（包含隐藏文件和配置，如 `.spec-workflow/`、IDE 配置）。

* 环境准备（新电脑）：

  * 安装 TRAE IDE 与必要 VS Code 插件（若使用）。

  * 安装 EDA/仿真工具（例如 xmvlog/仿真器）、Shell 工具（grep/ripgrep）。

  * 设置与旧机一致的环境变量/路径（如编译脚本、库路径）。

* 验证：

  * 在新电脑执行一次基础编译（例如 xmvlog），确保无路径/位宽差异问题。

  * 使用 SPEC 的 Tasks 和 Implementation Logs 对照检查关键模块（function\_arbiter.sv、pre\_all.sv、command\_arbiter.sv、ddrc\_pa.sv）。

## SPEC 文档结构

* 文件：`.spec-workflow/specs/trae-rtl-migration-spec/{requirements, design, tasks}.md`

* 流程：严格按照 Requirements → Design → Tasks → Implementation 四阶段；每阶段输出一个文件并经审批确认。

## Requirements（需求）

* 总体：记录所有历史需求（来自你给出的会话摘要），覆盖三大模块变更：

  * function\_arbiter.sv：

    * 仅 HQoS 的 MRR4 能上锁（删除低优锁），锁用于强制选择与屏蔽。

    * mask 生成基于紧急信号与各高优 grant 的寄存版本；移除 `prepb_req_ref_h` 对 mask 的贡献。

    * 去除 `prepb_lock` 及其所有使用；强制选择链去掉 `prepb_lock` 分支。

    * PIMX/HQoS 整合；避免组合环（如 pim\_grant 打拍或去反馈）。

  * pre\_all.sv：

    * `pa_cmd_vld` 组合门控只看 `pre_ab_allow` 与处理态，rank/sc 细分；相位直传 `pre_ab_allow_ph` 切片。

    * Intent 同拍撤销保护（LP 域）；flush 单脉冲；S\_IDLE 仅看 bank\_close 与 intent；取消在非处理态的请求置起。

    * ack 掩码支持局部 `bank_close_info` 同拍（后按你的回退可不启用）。

    * LP 端口宽度扩展与逐 SC 粘性记录（已完成）。

  * command\_arbiter.sv：

    * ACT1 锁逻辑；RD/WR/ACT2 在锁期间放行策略。

    * PB grant 统一不区分优先级；去除 HQoS 联合下降沿覆盖与低优门控；PB bank 选择直接遍历 `prepb_grant_ref`。

    * 相关无用信号（prev 打拍、fall 检测）清理。

* 迁移需求：保留 SPEC、实现日志与任务清单，确保新环境连续性。

## Design（设计）

* 架构：两级仲裁（function\_arbiter → command\_arbiter）+ PRE ALL 状态机（pre\_all）；锁、mask、intent 同拍策略统一。

* 关键设计点：

  * 避免组合环：grant 不参与同拍反馈；mask 用寄存 grant 或紧急信号。

  * 门控统一：发令只在处理态与允许同拍；相位直传；rank/sc 单比特允许。

  * PB 行为统一：不区分 HQ/LQ 的寄存器路径，银行选择直接基于 grant。

* 接口：列出四模块关键端口与位宽约定（如 `DDRC_SCRKBGBK_WIDTH`、`RK_NUM*SC_NUM`）。

## Tasks（任务）

* 示例任务分解（每项在 tasks.md 以原子任务列出）：

  * function\_arbiter：移除 `prepb_lock` 全引用；更新 mask 去除 `prepb_req_ref_h`；保持 mrr4 高优锁语义。

  * pre\_all：统一 S\_IDLE/S\_FLUSH/S\_PROCESS 的请求门控；LP 撤销保护；相位直传；取消非处理态的请求置起。

  * command\_arbiter：PB grant 不区分优先级；删除 HQoS fall 逻辑与 prev 打拍；组合 bank 选择遍历 `prepb_grant_ref`。

  * 迁移支持：在新机跑一次编译与最小仿真；用 grep 检查残留信号（如 `prepb_lock`、`*_fall`、`*_prev`）。

* 每个任务包含：目标、涉及文件路径、成功标准、验证方法（编译通过 / 单元仿真）。

## Implementation（实施使用说明）

* 在新电脑：

  * 读 `requirements.md` → `design.md` → `tasks.md`；使用 spec-status 查看整体进度。

  * 开始任务：将任务从 `[ ]` 设为 `[-]`，实现代码后用 log-implementation 记录改动与工件，再标记 `[x]` 完成。

  * 验证：运行编译/仿真；必要时用 ripgrep 对比实现日志避免重复实现或遗漏。

## 交付物

* 目录 `.spec-workflow/specs/trae-rtl-migration-spec/` 下的：

  * `requirements.md`：按上方需求列出并分模块归档。

  * `design.md`：方案与接口细节。

  * `tasks.md`：原子任务清单，包含每任务的 Prompt 字段与成功标准。

## 后续

* 每个阶段需通过 approvals（请求→状态→删除）获得确认；完成后进入实施阶段。

* 若你希望，我可以在确认后一次性生成并写入上述三个文档到仓库，随后创建审批请求并展示 dashboard。

