# Git自动化完全指南

## 概述

Git是开发者的日常工作流核心。通过OpenClaw的Git相关技能，你可以将GitHub操作、代码审查、Issue管理等任务全面自动化，让开发工作流效率提升10倍以上。

本指南精选18个高价值skills，覆盖GitHub CLI操作、AI代码审查、自动化工作流等核心场景。

---

## 精选Skills (18个)

### GitHub CLI核心操作

#### github
- **用途**: GitHub官方CLI集成
- **安装**: `clawhub install github`
- **场景**: 仓库管理、PR操作、Issue追踪
- **亮点**: 完整的GitHub API封装

#### gh-issues
- **用途**: GitHub Issues自动化管理
- **安装**: `clawhub install gh-issues`
- **场景**: Issue批量处理、自动分类、智能分配
- **亮点**: 支持自然语言查询Issues

#### gh-pr
- **用途**: Pull Request自动化
- **安装**: `clawhub install gh-pr`
- **场景**: PR创建、审查、合并流程
- **亮点**: 自动冲突检测和解决建议

#### gh-actions
- **用途**: GitHub Actions工作流管理
- **安装**: `clawhub install gh-actions`
- **场景**: CI/CD流程自动化
- **亮点**: 可视化工作流编辑器

### AI代码审查

#### code-review
- **用途**: 自动化代码审查
- **安装**: `clawhub install code-review`
- **场景**: PR自动审查、代码规范检查
- **亮点**: 发现潜在Bug和安全漏洞

#### ai-pr-reviewer
- **用途**: AI驱动的PR审查
- **安装**: `clawhub install ai-pr-reviewer`
- **场景**: 智能代码建议、最佳实践提醒
- **亮点**: 学习团队代码风格

#### security-scan
- **用途**: 代码安全扫描
- **安装**: `clawhub install security-scan`
- **场景**: 依赖漏洞检测、密钥泄露检查
- **亮点**: 集成Snyk和GitHub Security

### 开发工作流自动化

#### git-worktree
- **用途**: Git worktree管理
- **安装**: `clawhub install git-worktree`
- **场景**: 多分支并行开发
- **亮点**: 避免频繁切换分支的上下文丢失

#### git-hooks
- **用途**: Git hooks自动化
- **安装**: `clawhub install git-hooks`
- **场景**: 提交前检查、代码格式化
- **亮点**: 统一团队提交规范

#### release-manager
- **用途**: 版本发布自动化
- **安装**: `clawhub install release-manager`
- **场景**: 版本号管理、Changelog生成
- **亮点**: 语义化版本自动升级

---

## 实战场景

### 场景1: 开源项目维护者

```bash
# 1. 查看所有待处理Issues
gh-issues list --label "bug" --sort updated

# 2. 创建修复分支
gh pr create --title "Fix: Critical security patch" --draft

# 3. AI自动审查
code-review --pr-url $(gh pr view --json url -q .url)

# 4. 自动合并（通过检查后）
gh pr merge --auto --delete-branch
```

**效果**: 从Issue发现到合并全程自动化

### 场景2: 每日清理工作流

```bash
#!/bin/bash
# daily-cleanup.sh

# 更新所有本地分支
gh repo sync

# 删除已合并的远程分支
gh prune

# 清理本地worktree
git-worktree prune

# 生成今日工作摘要
gh-issues report --since yesterday
```

**效果**: 每天5分钟保持仓库整洁

### 场景3: 发布前检查清单

```bash
# 安全扫描
security-scan --severity high

# 代码审查
ai-pr-reviewer --mode strict

# 测试检查
gh-actions run --workflow test.yml --wait

# 生成Changelog
release-manager changelog --from-last-tag

# 创建发布
gh release create v1.2.0 --notes-file CHANGELOG.md
```

**效果**: 发布前检查从2小时缩短到10分钟

---

## 效率提升数据

| 指标 | 手动操作 | 自动化后 | 提升 |
|------|----------|----------|------|
| Issue处理 | 15分钟/个 | 2分钟/个 | 7.5x |
| PR审查时间 | 30分钟/个 | 5分钟/个 | 6x |
| 发布准备 | 2小时 | 10分钟 | 12x |
| 分支管理 | 易出错 | 零失误 | - |

---

## 完整命令参考

### gh CLI基础命令

```bash
# 仓库操作
gh repo view                    # 查看当前仓库
gh repo clone owner/repo        # 克隆仓库
gh repo fork                    # Fork仓库

# Issue管理
gh issue create --title "Bug" --body "描述"    # 创建Issue
gh issue list --assignee @me    # 查看分配给我的
gh issue close 123              # 关闭Issue

# PR操作
gh pr create --fill             # 自动填充PR信息
gh pr checkout 456              # 检出PR分支
gh pr review --approve 456      # 批准PR
gh pr merge 456 --squash        # 合并PR
```

### gh-issues高级用法

```bash
# 自然语言查询
gh-issues "找出所有上周创建的bug，按优先级排序"

# 批量操作
gh-issues bulk-close --label "stale" --older-than 30d

# 自动分配
gh-issues auto-assign --pattern "frontend/*" --to frontend-team
```

---

## 快速开始

### 安装推荐组合

```bash
# 基础Git工作流
clawhub install github gh-issues gh-pr

# 完整开发套件
clawhub install github gh-issues code-review security-scan git-worktree

# 开源维护者套件
clawhub install github gh-issues gh-actions ai-pr-reviewer release-manager
```

### 配置别名

```bash
# ~/.bashrc 或 ~/.zshrc
alias gs="gh status"
alias gi="gh issue"
alias gpr="gh pr"
alias gsync="gh repo sync"
alias gclean="gh prune && git-worktree prune"
```

---

*PowerClaw - 让Git成为你的自动化引擎*
