# OpenClaw 生产力工具完全指南

> 🚀 用AI Agent打造你的超级生产力工作流

---

## 目录

1. [快速入门](#快速入门)
2. [密码与安全管理](#1-密码与安全管理)
3. [笔记与知识管理](#2-笔记与知识管理)
4. [任务与项目管理](#3-任务与项目管理)
5. [邮件与沟通管理](#4-邮件与沟通管理)
6. [开发工作流自动化](#5-开发工作流自动化)
7. [内容处理与总结](#6-内容处理与总结)
8. [Google Workspace集成](#7-google-workspace集成)
9. [终端与Session管理](#8-终端与session管理)
10. [MCP生态与扩展](#9-mcp生态与扩展)
11. [实战工作流组合](#10-实战工作流组合)

---

## 快速入门

### 什么是OpenClaw生产力工具集？

OpenClaw提供了一套完整的CLI工具，让你能够用自然语言指挥AI Agent完成各种生产力任务。从密码管理到项目协作，从邮件处理到内容总结，所有操作都可以在终端完成。

### 核心优势

| 优势 | 说明 |
|------|------|
| 🎯 统一接口 | 所有工具通过OpenClaw调用，一致的交互体验 |
| 🤖 AI驱动 | 自然语言描述任务，AI自动执行 |
| 🔗 无缝集成 | 工具之间可以组合，形成自动化工作流 |
| 🔒 本地优先 | 敏感数据本地处理，保护隐私 |
| ⚡ 高效快捷 | 终端操作，比GUI快10倍 |

---

## 1. 密码与安全管理

### 1Password CLI (`1password`)

**用途**：安全地管理和使用密码、API密钥等敏感信息

**核心场景**：
- 开发时自动注入API密钥
- CI/CD流水线中使用机密
- 团队协作时安全共享凭证

**快速开始**：
```bash
# 安装
brew install 1password-cli

# 登录（必须在tmux会话中）
tmux new -s op-session
op signin

# 读取密码
op item get "GitHub Token" --field password

# 注入到环境变量
op run --env-file=.env -- npm run deploy
```

**最佳实践**：
- ✅ 始终在tmux会话中运行op命令
- ✅ 使用`op inject`而非直接复制密码
- ✅ 为不同项目创建独立的vault

---

## 2. 笔记与知识管理

### 2.1 Apple Notes (`apple-notes`)

**用途**：通过CLI管理Apple Notes，适合快速记录和iCloud同步

**核心场景**：
- 快速创建会议记录
- 批量导出笔记
- 在终端搜索笔记内容

**快速开始**：
```bash
# 安装
brew tap antoniorodr/memo && brew install antoniorodr/memo/memo

# 列出所有笔记
memo notes

# 搜索笔记
memo notes -s "项目计划"

# 创建笔记
memo notes -a "会议记录"

# 导出为Markdown
memo notes -ex -f "Work"
```

### 2.2 Bear Notes (`bear-notes`)

**用途**：优雅的Markdown笔记工具，支持标签和双向链接

**核心场景**：
- 知识库构建
- 写作和笔记整理
- 标签化信息管理

**快速开始**：
```bash
# 安装
go install github.com/tylerwince/grizzly/cmd/grizzly@latest

# 创建笔记并添加标签
echo "项目想法..." | grizzly create --title "新项目" --tag work --tag idea

# 搜索内容
grizzly open-tag --name "work" --enable-callback --json

# 追加内容到现有笔记
grizzly add-text --id "NOTE_ID" --mode append
```

**Bear Token设置**：
1. 打开Bear → Help → API Token → 复制Token
2. `echo "YOUR_TOKEN" > ~/.config/grizzly/token`

### 2.3 Obsidian (`obsidian`)

**用途**：最强大的本地知识库工具，支持双向链接和图谱

**核心场景**：
- 构建个人知识图谱
- Zettelkasten笔记法
- 复杂知识管理

**快速开始**：
```bash
# 安装
brew tap yakitrak/yakitrak && brew install obsidian-cli

# 设置默认vault
obsidian-cli set-default "My Vault"

# 搜索笔记
obsidian-cli search "机器学习"

# 全文搜索
obsidian-cli search-content "神经网络"

# 安全重命名（自动更新链接）
obsidian-cli move "old/note" "new/note"

# 创建新笔记
obsidian-cli create "Projects/新想法" --content "这里是内容" --open
```

**优势对比**：

| 工具 | 最适合 | 同步方式 | 特色功能 |
|------|--------|----------|----------|
| Apple Notes | 快速记录 | iCloud | 原生集成 |
| Bear | 优雅写作 | iCloud | 标签系统 |
| Obsidian | 知识库 | 自托管 | 双向链接、图谱 |

### 2.4 Notion (`notion`)

**用途**：团队协作和结构化数据管理

**核心场景**：
- 团队知识库
- 项目管理数据库
- 文档协作

**快速开始**：
```bash
# 设置API密钥
mkdir -p ~/.config/notion
echo "ntn_your_key" > ~/.config/notion/api_key

# 搜索页面
NOTION_KEY=$(cat ~/.config/notion/api_key)
curl -X POST "https://api.notion.com/v1/search" \
  -H "Authorization: Bearer $NOTION_KEY" \
  -H "Notion-Version: 2025-09-03" \
  -d '{"query": "项目名称"}'

# 创建数据库条目
curl -X POST "https://api.notion.com/v1/pages" \
  -H "Authorization: Bearer $NOTION_KEY" \
  -H "Notion-Version: 2025-09-03" \
  -d '{
    "parent": {"database_id": "xxx"},
    "properties": {
      "Name": {"title": [{"text": {"content": "新任务"}}]},
      "Status": {"select": {"name": "进行中"}}
    }
  }'
```

---

## 3. 任务与项目管理

### 3.1 Things 3 (`things-mac`)

**用途**：优雅的GTD任务管理，适合个人工作流

**核心场景**：
- 个人任务规划
- 项目分解
- 习惯追踪

**快速开始**：
```bash
# 安装
go install github.com/ossianhempel/things3-cli/cmd/things@latest

# 查看今日任务
things today

# 查看收件箱
things inbox --limit 20

# 添加任务
things add "完成报告" --when today --deadline 2024-03-10

# 带检查清单的任务
things add "旅行准备" \
  --checklist-item "护照" \
  --checklist-item "机票" \
  --checklist-item "酒店"

# 搜索任务
things search "会议"

# 查看项目列表
things projects
```

**高级用法**：
```bash
# 批量创建任务
cat <<'EOF' | things add -
整理文档
整理桌面文件
备份重要数据
EOF

# 完成任务（需要auth token）
things update --id <UUID> --auth-token <TOKEN> --completed
```

### 3.2 Apple Reminders (`apple-reminders`)

**用途**：轻量级提醒事项，与iOS深度集成

**核心场景**：
- 快速设置提醒
- 购物清单
- 周期性任务

**快速开始**：
```bash
# 安装
brew install steipete/tap/remindctl

# 今日提醒
remindctl today

# 添加提醒
remindctl add "下午3点开会" --due "15:00"

# 本周所有任务
remindctl week

# JSON输出（用于脚本）
remindctl today --json
```

**与Things的区别**：
- Reminders：轻量、快速、与Siri集成
- Things：功能完整、支持复杂项目

### 3.3 Trello (`trello`)

**用途**：看板式项目管理，适合团队协作

**核心场景**：
- 敏捷开发看板
- 内容发布日历
- 团队协作追踪

**快速开始**：
```bash
# 设置环境变量
export TRELLO_API_KEY="your-key"
export TRELLO_TOKEN="your-token"

# 列出看板
curl -s "https://api.trello.com/1/members/me/boards?key=$TRELLO_API_KEY&token=$TRELLO_TOKEN" | jq '.[] | {name, id}'

# 创建卡片
curl -s -X POST "https://api.trello.com/1/cards?key=$TRELLO_API_KEY&token=$TRELLO_TOKEN" \
  -d "idList={listId}" \
  -d "name=新功能开发" \
  -d "desc=详细描述..."

# 移动卡片
curl -s -X PUT "https://api.trello.com/1/cards/{cardId}?key=$TRELLO_API_KEY&token=$TRELLO_TOKEN" \
  -d "idList={newListId}"
```

---

## 4. 邮件与沟通管理

### 4.1 Himalaya (`himalaya`)

**用途**：终端邮件客户端，支持IMAP/SMTP

**核心场景**：
- 批量处理邮件
- 自动化邮件工作流
- 离线邮件管理

**快速开始**：
```bash
# 安装
brew install himalaya

# 配置账户
himalaya account configure

# 列出收件箱
himalaya envelope list

# 搜索邮件
himalaya envelope list from:boss@company.com subject:urgent

# 阅读邮件
himalaya message read 42

# 回复
himalaya message reply 42 --all

# 移动邮件
himalaya message move 42 "Archive"
```

**配置文件示例** (`~/.config/himalaya/config.toml`)：
```toml
[accounts.personal]
email = "you@example.com"
display-name = "Your Name"
default = true

backend.type = "imap"
backend.host = "imap.gmail.com"
backend.port = 993
backend.encryption.type = "tls"
backend.login = "you@example.com"
backend.auth.type = "password"
backend.auth.cmd = "pass show email/imap"
```

### 4.2 Google Workspace (`gog`)

**用途**：整合Gmail、Calendar、Drive等Google服务

**核心场景**：
- 批量邮件处理
- 日历事件管理
- 表格数据处理

**快速开始**：
```bash
# 安装
brew install steipete/tap/gogcli

# 认证
gog auth credentials /path/to/client_secret.json
gog auth add you@gmail.com --services gmail,calendar,drive,sheets

# Gmail搜索
gog gmail search 'newer_than:7d from:important@company.com' --max 10

# 发送邮件
gog gmail send --to team@company.com \
  --subject "周报" \
  --body-file ./weekly-report.txt

# 查看日历
gog calendar events primary --from 2024-03-01T00:00:00Z --to 2024-03-07T00:00:00Z

# 创建事件
gog calendar create primary \
  --summary "团队会议" \
  --from 2024-03-05T14:00:00Z \
  --to 2024-03-05T15:00:00Z \
  --event-color 7

# 读取Sheets
gog sheets get <sheetId> "Sheet1!A1:D10" --json
```

---

## 5. 开发工作流自动化

### 5.1 GitHub Issues自动修复 (`gh-issues`)

**用途**：AI自动分析GitHub Issue并提交PR修复

**核心场景**：
- 批量处理bug报告
- 自动化代码审查
- 开源项目维护

**快速开始**：
```bash
# 使用OpenClaw调用
/gh-issues owner/repo --label bug --limit 5

# 监控模式（每5分钟检查新Issue）
/gh-issues owner/repo --watch --interval 5

# 只处理代码审查
/gh-issues owner/repo --reviews-only

# 指定模型
/gh-issues owner/repo --model glm-5 --limit 3
```

**工作原理**：
1. 获取匹配的Issue列表
2. AI分析Issue内容
3. 创建修复分支
4. 实现代码修复
5. 运行测试
6. 提交PR

### 5.2 GitHub CLI (`github`)

**用途**：全面的GitHub操作工具

**核心场景**：
- PR管理和审查
- CI/CD监控
- Issue管理

**快速开始**：
```bash
# 安装
brew install gh

# 认证
gh auth login

# PR操作
gh pr list --repo owner/repo
gh pr view 55 --repo owner/repo
gh pr checks 55 --repo owner/repo
gh pr merge 55 --squash

# Issue操作
gh issue list --state open --label bug
gh issue create --title "Bug: ..." --body "描述..."

# CI监控
gh run list --limit 10
gh run view <run-id> --log-failed
gh run rerun <run-id> --failed

# API查询
gh api repos/owner/repo/pulls/55 --jq '.title, .state'
```

---

## 6. 内容处理与总结

### 6.1 智能总结 (`summarize`)

**用途**：自动总结URL、PDF、YouTube视频

**核心场景**：
- 快速了解文章要点
- 会议录音转录
- 视频内容提取

**快速开始**：
```bash
# 安装
brew install steipete/tap/summarize

# 总结网页
summarize "https://example.com/article" --model google/gemini-3-flash-preview

# 总结PDF
summarize "/path/to/document.pdf"

# YouTube视频（提取文字）
summarize "https://youtu.be/xxx" --youtube auto --extract-only

# 指定长度
summarize "https://..." --length medium  # short/medium/long/xl/xxl

# JSON输出（用于脚本）
summarize "https://..." --json
```

**支持的模型**：
- Google Gemini (默认)
- OpenAI GPT
- Anthropic Claude
- xAI Grok

### 6.2 语音转文字 (`openai-whisper`)

**用途**：本地语音转文字，支持多语言

**核心场景**：
- 会议录音转录
- 语音笔记
- 视频字幕生成

**快速开始**：
```bash
# 安装
brew install openai-whisper

# 基本转录
whisper /path/audio.mp3 --model medium --output_format txt

# 生成字幕
whisper /path/audio.m4a --output_format srt

# 翻译为英文
whisper /path/audio.mp3 --task translate --output_format txt
```

**模型选择**：
- `tiny`: 最快，质量一般
- `base`: 平衡选择
- `small`: 较好质量
- `medium`: 高质量
- `large`: 最佳质量
- `turbo` (默认): 优化版本

### 6.3 PDF编辑 (`nano-pdf`)

**用途**：用自然语言编辑PDF文档

**核心场景**：
- 快速修改合同
- 批量更新模板
- 修正PDF错误

**快速开始**：
```bash
# 安装
uv tool install nano-pdf

# 编辑PDF（自然语言指令）
nano-pdf edit document.pdf 1 "Change the date to March 5, 2024"

# 修复错别字
nano-pdf edit report.pdf 3 "Fix the typo 'teh' to 'the' in the title"
```

### 6.4 RSS监控 (`blogwatcher`)

**用途**：监控博客和RSS订阅更新

**核心场景**：
- 追踪行业动态
- 监控竞争对手
- 内容策展

**快速开始**：
```bash
# 安装
go install github.com/Hyaxia/blogwatcher/cmd/blogwatcher@latest

# 添加博客
blogwatcher add "Tech Blog" https://example.com/feed.xml

# 扫描更新
blogwatcher scan

# 查看文章
blogwatcher articles

# 标记已读
blogwatcher read 1
```

---

## 7. Google Workspace集成

### 7.1 完整工作流示例

**场景**：每周五自动生成周报并发送

```bash
#!/bin/bash
# weekly-report.sh

# 1. 从Sheets获取数据
DATA=$(gog sheets get $SHEET_ID "周报!A1:E20" --json)

# 2. 生成报告
REPORT="本周工作总结

$(echo $DATA | jq -r '.[][] | "- \(.[0]): \(.[4])"')

下周计划：
- 完成项目A开发
- 准备季度汇报
"

# 3. 发送邮件
echo "$REPORT" | gog gmail send \
  --to manager@company.com \
  --subject "周报 - $(date +%Y-%m-%d)" \
  --body-file -

# 4. 创建日历事件提醒下周review
gog calendar create primary \
  --summary "周报Review" \
  --from "$(date -v+7d +%Y-%m-%d)T10:00:00Z" \
  --to "$(date -v+7d +%Y-%m-%d)T11:00:00Z"
```

---

## 8. 终端与Session管理

### 8.1 Tmux (`tmux`)

**用途**：终端会话管理，保持长任务运行

**核心场景**：
- 保持SSH会话
- 并行任务管理
- 监控后台任务

**快速开始**：
```bash
# 创建会话
tmux new-session -d -s work

# 列出会话
tmux list-sessions

# 发送命令
tmux send-keys -t work "python long-task.py" Enter

# 捕获输出
tmux capture-pane -t work -p | tail -20

# 多worker管理
for i in {2..8}; do
  tmux new-session -d -s worker-$i
done
```

**实用模式**：
```bash
# 监控所有worker状态
for s in work worker-2 worker-3 worker-4; do
  echo "=== $s ==="
  tmux capture-pane -t $s -p 2>/dev/null | tail -5
done

# 批量发送命令
for s in worker-{2..8}; do
  tmux send-keys -t $s "git pull" Enter
done
```

---

## 9. MCP生态与扩展

### 9.1 MCP管理 (`mcporter`)

**用途**：管理和调用MCP（Model Context Protocol）服务器

**核心场景**：
- 扩展AI Agent能力
- 集成外部API
- 自定义工具链

**快速开始**：
```bash
# 安装
npm i -g mcporter

# 列出可用服务器
mcporter list

# 查看工具详情
mcporter list linear --schema

# 调用工具
mcporter call linear.list_issues team=ENG limit:5

# 调用自定义服务器
mcporter call --stdio "bun run ./my-server.ts" scrape url=https://example.com

# 认证
mcporter auth linear
```

### 9.2 AI提示词管理 (`oracle`)

**用途**：将代码和提示词打包发送给AI进行分析

**核心场景**：
- 复杂代码审查
- 架构设计讨论
- Bug分析

**快速开始**：
```bash
# 安装
npm i -g @steipete/oracle

# 预览（不发送）
oracle --dry-run summary -p "分析这段代码的性能问题" --file "src/**"

# 浏览器模式（推荐）
oracle --engine browser --model gpt-5.2-pro \
  -p "重构这个模块，提高可测试性" \
  --file "src/core/**" \
  --file "!**/*.test.ts"

# 查看历史会话
oracle status --hours 72
```

---

## 10. 实战工作流组合

### 10.1 每日工作计划流

```bash
#!/bin/bash
# daily-plan.sh

echo "🌅 生成今日工作计划..."

# 1. 检查Things今日任务
echo "📋 Things今日任务："
things today

# 2. 检查Apple Reminders
echo "⏰ 今日提醒："
remindctl today

# 3. 检查邮件
echo "📧 未读邮件："
himalaya envelope list --page-size 5

# 4. 检查Trello待办
echo "📊 Trello待办："
# (curl命令获取看板数据)

# 5. 生成今日计划
PLAN="""
# $(date +%Y-%m-%d) 工作计划

## 重点任务
$(things today | head -10)

## 会议安排
$(remindctl today | grep -i "会议\|call\|zoom")

## 待处理邮件
$(himalaya envelope list | wc -l) 封未读

## 备注
- [ ] 检查PR状态
- [ ] 回复重要邮件
- [ ] 代码审查
"""

# 保存到Obsidian
obsidian-cli create "Daily/$(date +%Y-%m-%d)" --content "$PLAN"

echo "✅ 计划已生成并保存到Obsidian"
```

### 10.2 智能会议助手

```bash
#!/bin/bash
# meeting-assistant.sh

# 1. 录音转文字
echo "🎙️ 正在转录音频..."
whisper meeting-recording.m4a --model medium --output_format txt

# 2. 总结会议内容
echo "📝 生成会议纪要..."
summarize meeting-recording.txt --length medium > meeting-summary.md

# 3. 提取行动项
echo "✅ 提取行动项..."
# (使用AI提取TODO)

# 4. 创建Things任务
cat action-items.txt | while read item; do
  things add "$item" --when today --tags "meeting" --list "Work"
done

# 5. 发送会议纪要
gog gmail send \
  --to attendees@company.com \
  --subject "会议纪要 - $(date +%Y-%m-%d)" \
  --body-file meeting-summary.md
```

### 10.3 开源项目维护流

```bash
#!/bin/bash
# oss-maintenance.sh

# 1. 自动修复Issue
/gh-issues my-org/my-repo \
  --label "good first issue" \
  --limit 3 \
  --fork my-fork/my-repo

# 2. 处理代码审查
/gh-issues my-org/my-repo \
  --reviews-only \
  --watch \
  --interval 30

# 3. 生成发布说明
# (收集合并的PR，生成changelog)
```

### 10.4 内容创作工作流

```bash
#!/bin/bash
# content-pipeline.sh

TOPIC="$1"

# 1. 监控相关RSS
echo "📰 收集行业动态..."
blogwatcher scan | grep -i "$TOPIC"

# 2. 总结相关文章
echo "🧾 总结关键文章..."
for url in $(cat article-urls.txt); do
  summarize "$url" --length short >> research.md
done

# 3. 在Obsidian中创建文章大纲
obsidian-cli create "Articles/$TOPIC" --content "$(cat research.md)" --open

# 4. 完成后发布到博客
# (使用API发布到CMS)

# 5. 分享到社交媒体
# (使用twitter-automation等skill)
```

### 10.5 密码轮换工作流

```bash
#!/bin/bash
# rotate-secrets.sh

# 1. 生成新密码
NEW_TOKEN=$(openssl rand -hex 32)

# 2. 更新1Password
echo "$NEW_TOKEN" | op item edit "API Token" --field password

# 3. 更新部署环境
echo "DEPLOY_TOKEN=$NEW_TOKEN" > .env.production
op run --env-file=.env.production -- ./deploy.sh

# 4. 通知团队
gog gmail send \
  --to team@company.com \
  --subject "API Token已轮换" \
  --body "新的API Token已部署到生产环境。"
```

---

## 附录

### Skill安装速查表

| Skill | 安装命令 |
|-------|----------|
| 1password | `brew install 1password-cli` |
| apple-notes | `brew tap antoniorodr/memo && brew install antoniorodr/memo/memo` |
| apple-reminders | `brew install steipete/tap/remindctl` |
| bear-notes | `go install github.com/tylerwince/grizzly/cmd/grizzly@latest` |
| blogwatcher | `go install github.com/Hyaxia/blogwatcher/cmd/blogwatcher@latest` |
| gh-issues | (内置) |
| github | `brew install gh` |
| gog | `brew install steipete/tap/gogcli` |
| himalaya | `brew install himalaya` |
| notion | (API调用，无需安装) |
| obsidian | `brew tap yakitrak/yakitrak && brew install obsidian-cli` |
| things-mac | `go install github.com/ossianhempel/things3-cli/cmd/things@latest` |
| trello | (API调用，无需安装) |
| summarize | `brew install steipete/tap/summarize` |
| tmux | `brew install tmux` |
| mcporter | `npm i -g mcporter` |
| oracle | `npm i -g @steipete/oracle` |
| nano-pdf | `uv tool install nano-pdf` |
| openai-whisper | `brew install openai-whisper` |
| clawhub | `npm i -g clawhub` |

### 环境变量配置模板

```bash
# ~/.zshrc 或 ~/.bashrc

# 1Password
export OP_ACCOUNT="my.1password.com"

# GitHub
export GH_TOKEN="ghp_xxx"

# Notion
export NOTION_API_KEY="ntn_xxx"

# Trello
export TRELLO_API_KEY="xxx"
export TRELLO_TOKEN="xxx"

# Google (gog)
export GOG_ACCOUNT="you@gmail.com"

# Summarize
export GEMINI_API_KEY="xxx"
# 或
export OPENAI_API_KEY="sk-xxx"
export ANTHROPIC_API_KEY="sk-ant-xxx"

# Things (可选)
export THINGS_AUTH_TOKEN="xxx"
```

---

## 结语

OpenClaw生产力工具集将AI Agent的能力延伸到日常工作的方方面面。通过组合这些工具，你可以：

- ⚡ **节省80%的重复性工作**时间
- 🤖 **自动化繁琐的流程**
- 🎯 **专注于高价值创造性工作**
- 🔗 **构建个性化的工作流系统**

开始构建你的AI驱动生产力系统吧！

---

*指南版本: 1.0 | 最后更新: 2026-03-04*
*共覆盖 20 个高价值Productivity Skills*
