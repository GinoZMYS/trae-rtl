## 前提准备
- 安装 Git（macOS 可用 `brew install git`）。
- 配置身份：`git config --global user.name "<你的名字>" && git config --global user.email "<你的邮箱>"`
- 认证方式二选一：
  - SSH：生成密钥 `ssh-keygen -t ed25519 -C "<你的邮箱>"`；将 `~/.ssh/id_ed25519.pub` 添加到平台（GitHub/GitLab）的 SSH keys。
  - PAT：在平台账户中创建 Personal Access Token（至少包含 repo 权限）。

## 在账号上创建远端仓库
- GitHub（浏览器）：
  - 进入 GitHub → New repository → 名称建议：`trae-rtl` → 勾选私有或公开 → 不勾选自动生成 README → Create。
- GitHub（API，PAT）：
  - `curl -H "Authorization: token <PAT>" -d '{"name":"trae-rtl","private":true}' https://api.github.com/user/repos`
- GitLab（浏览器）：
  - New project → Name `trae-rtl` → Visibility → Create。
- GitLab（API，PAT）：
  - `curl --header "PRIVATE-TOKEN: <PAT>" -X POST https://gitlab.com/api/v4/projects -d name=trae-rtl -d visibility=private`

## 在本地初始化并推送（保留全部文件与历史）
- 进入本地目录：`cd /Users/bytedance/Documents/workspace/TRAE_RTL`
- 若尚未初始化：
  - `git init`
  - 建议添加 `.gitignore`（忽略编译输出/仿真波形/临时文件）：
    - `*.log`, `*.vcd`, `*.fsdb`, `*.out`, `*.jou`, `*.tmp`, `*.dmp`
    - `build/`, `out/`, `.DS_Store`, `.vscode/`
    - 保留 `.spec-workflow/`、`rtl/`、`scripts/` 等源码与规范目录
  - `git add -A && git commit -m "bootstrap: import current RTL and spec workflow"`
- 绑定远端（替换为你的远端地址）：
  - GitHub/SSH：`git remote add origin git@github.com:<your-username>/trae-rtl.git`
  - GitHub/HTTPS+PAT：`git remote add origin https://github.com/<your-username>/trae-rtl.git`
  - GitLab/SSH：`git remote add origin git@gitlab.com:<your-username>/trae-rtl.git`
- 设置默认分支并推送：
  - `git branch -M main`
  - `git push -u origin main`

## 已有远端 README 的情况
- 如果远端仓库已含初始化提交：
  - `git pull origin main --allow-unrelated-histories`
  - 解决冲突后 `git push`
- 若想覆盖远端：`git push -u origin main --force-with-lease`（谨慎使用）

## 分支与标签策略（建议）
- 主分支：`main`（稳定）
- 特性分支：按模块命名：
  - `feature/function-arbiter-lock-and-mask`
  - `feature/pre-all-phase-and-intent`
  - `feature/command-arbiter-pb-grant`
- 合并采用 PR/MR，启用代码评审；里程碑打标签：`v0.1-preall-sync`、`v0.2-pb-grant-unified`。

## 大文件与CI建议
- 大文件：如仿真波形（`*.vcd/fsdb`）使用 Git LFS：`git lfs install && git lfs track "*.vcd" "*.fsdb"`
- CI（可选）：在 GitHub Actions/GitLab CI 中运行语法检查/编译：
  - 安装 xmvlog/仿真器容器或本地 runner；
  - 基础流水线：checkout → 安装依赖 → 运行 `xmvlog` 编译 → 保存日志。

## 迁移到新电脑后
- `git clone git@github.com:<your-username>/trae-rtl.git`
- 验证编译与运行脚本；继续用分支/PR 的方式迭代。
- 将 `.spec-workflow/specs/` 规范文档随仓库管理，后续在新机按规范执行任务与记录实现日志。

## 我将为你执行的事项（确认后）
- 在仓库中写入 `.gitignore`（忽略编译/临时文件，保留规范与源码）。
- 如你提供 GitHub/GitLab 选择与访问令牌，我可按 API 创建远端仓库并绑定。
- 初始化远端推送与基本分支策略；若已有远端，则处理历史合并或保护推送。
