# TRAE_RTL 项目迁移设计方案

## 1. 仓库结构设计

### 1.1 分支策略
采用 Git Flow 工作流，定义以下分支类型：

- **main 分支**：主干分支，存放稳定版本代码
- **develop 分支**：开发分支，集成所有功能开发
- **feature/*** 分支**：功能分支，用于新功能开发
- **hotfix/*** 分支**：热修复分支，用于紧急问题修复
- **release/*** 分支**：发布分支，用于版本发布准备

### 1.2 目录结构
```
trae-rtl/
├── .gitignore              # Git 忽略规则
├── .gitattributes          # Git LFS 属性配置
├── README.md               # 项目说明文档
├── requirements.txt        # Python 依赖
├── rtl/                    # RTL 代码目录
│   ├── *.sv               # SystemVerilog 文件
│   └── *.v                # Verilog 文件
├── scripts/                # 脚本工具目录
│   ├── *.py               # Python 工具脚本
│   └── *.sh               # Shell 脚本
├── configs/                # 配置文件目录
│   └── *.xlsx             # Excel 配置表
├── docs/                   # 文档目录
│   └── *.md               # Markdown 文档
└── tests/                  # 测试目录
    └── test_*.py          # 测试脚本
```

## 2. Git 忽略规则

### 2.1 忽略文件类型
```gitignore
# 仿真和波形文件
*.vcd
*.fsdb
*.wlf
*.vpd

# 日志和临时文件
*.log
*.tmp
*.swp
*~

# 构建输出
build/
out/
work/

# IDE 配置
.vscode/
.idea/
*.suo
*.ntvs*
*.njsproj
*.sln

# 操作系统文件
.DS_Store
Thumbs.db
desktop.ini

# Python 缓存
__pycache__/
*.pyc
*.pyo
*.pyd
.Python

# 工具特定文件
*.bak
*.backup
*.save
```

### 2.2 Git LFS 配置
对大文件使用 Git LFS 管理：
```
*.vcd filter=lfs diff=lfs merge=lfs -text
*.fsdb filter=lfs diff=lfs merge=lfs -text
*.xlsx filter=lfs diff=lfs merge=lfs -text
*.zip filter=lfs diff=lfs merge=lfs -text
```

## 3. 远端平台配置

### 3.1 GitHub 仓库设置
- **仓库名称**：trae-rtl
- **可见性**：Private（私有仓库）
- **描述**：TRAE RTL 项目代码和配置管理
- **初始化选项**：不创建 README，不添加 .gitignore

### 3.2 认证配置
- **认证方式**：SSH Key 认证
- **密钥生成**：`ssh-keygen -t ed25519 -C "your_email@example.com"`
- **公钥配置**：将公钥添加到 GitHub 账户
- **SSH 配置**：配置 ~/.ssh/config 文件

### 3.3 协作者设置
- **权限级别**：Write（写入权限）
- **分支保护**：main 分支需要 Pull Request 审查
- **审查要求**：至少 1 人审查通过
- **状态检查**：必须通过 CI 检查

## 4. 迁移实施步骤

### 4.1 本地仓库初始化
```bash
# 1. 进入项目目录
cd /Users/bytedance/Documents/workspace/TRAE_RTL

# 2. 初始化 Git 仓库
git init

# 3. 添加远端仓库
git remote add origin git@github.com:username/trae-rtl.git

# 4. 创建 .gitignore 文件
cat > .gitignore << EOF
*.vcd
*.fsdb
*.log
build/
out/
.vscode/
.DS_Store
EOF

# 5. 添加所有文件
git add .

# 6. 提交初始版本
git commit -m "Initial commit: TRAE RTL project setup"

# 7. 推送到远端
git push -u origin main
```

### 4.2 新电脑环境设置
```bash
# 1. 安装 Git LFS
git lfs install

# 2. 克隆仓库
git clone git@github.com:username/trae-rtl.git

# 3. 进入项目目录
cd trae-rtl

# 4. 安装 Python 依赖
pip install -r requirements.txt

# 5. 验证 RTL 生成脚本
python generate_rtl_from_excel.py

# 6. 运行验证流程
bash verify_rtl.sh
```

### 4.3 分支管理流程
```bash
# 创建功能分支
git checkout -b feature/add-ci-pipeline

# 开发完成后提交
git add .
git commit -m "Add CI pipeline for RTL verification"

# 推送分支
git push origin feature/add-ci-pipeline

# 创建 Pull Request
git request-pull origin/main origin/feature/add-ci-pipeline

# 代码审查通过后合并
git checkout main
git merge feature/add-ci-pipeline
git push origin main
```

## 5. 可选增强功能

### 5.1 Git LFS 集成
```bash
# 安装 Git LFS
git lfs install

# 跟踪大文件类型
git lfs track "*.vcd"
git lfs track "*.fsdb"
git lfs track "*.xlsx"

# 提交 LFS 配置
git add .gitattributes
git commit -m "Configure Git LFS for large files"
```

### 5.2 GitHub Actions CI/CD
创建 `.github/workflows/rtl-verification.yml`：
```yaml
name: RTL Verification

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  verify:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        pip install -r requirements.txt
    
    - name: Run RTL verification
      run: |
        bash verify_rtl.sh
    
    - name: Check syntax
      run: |
        python check_excel.py
```

### 5.3 分支保护规则
在 GitHub 设置中配置：
- **main 分支保护**：
  - 需要 Pull Request 审查
  - 需要状态检查通过
  - 限制推送权限
  - 需要线性历史

- **develop 分支保护**：
  - 需要代码审查
  - 需要 CI 检查通过

### 5.4 Issue 和项目管理
- **Issue 模板**：功能请求、Bug 报告、任务跟踪
- **项目看板**：使用 GitHub Projects 管理开发进度
- **里程碑**：按版本规划功能发布
- **标签系统**：分类管理 Issue 和 Pull Request

## 6. 回滚和恢复策略

### 6.1 本地回滚
```bash
# 查看提交历史
git log --oneline

# 回退到指定版本
git reset --hard commit_hash

# 强制推送到远端（谨慎使用）
git push origin main --force
```

### 6.2 远端恢复
```bash
# 从远端克隆最新版本
git clone git@github.com:username/trae-rtl.git

# 获取所有分支
git fetch --all

# 恢复到指定标签
git checkout v1.0.0
```

### 6.3 灾难恢复
- **定期备份**：设置自动化备份脚本
- **多地存储**：重要版本创建多个远端仓库
- **文档记录**：维护详细的迁移和操作文档