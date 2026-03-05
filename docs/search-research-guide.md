# 🔍 OpenClaw 搜索研究完全指南

> **PowerClaw内容团队出品** | 一份面向信息搜集、学术研究、趋势监控、竞品分析的全能工具手册

---

## 📋 目录

1. [核心能力矩阵](#核心能力矩阵)
2. [信息搜集工具](#信息搜集工具)
3. [学术研究利器](#学术研究利器)
4. [趋势监控方案](#趋势监控方案)
5. [竞品分析武器库](#竞品分析武器库)
6. [实战工作流](#实战工作流)
7. [快速参考卡](#快速参考卡)

---

## 核心能力矩阵

| 技能 | 类别 | 核心用途 | 难度 | 输出价值 |
|------|------|----------|------|----------|
| `web_search` | 搜索 | 网络信息检索 | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| `web_fetch` | 采集 | 网页内容提取 | ⭐⭐ | ⭐⭐⭐⭐ |
| `browser` | 自动化 | 深度网页交互 | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| `agent-browser` | 自动化 | AI浏览器代理 | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| `summarize` | 处理 | 内容摘要翻译 | ⭐ | ⭐⭐⭐⭐ |
| `blogwatcher` | 监控 | RSS/博客追踪 | ⭐⭐ | ⭐⭐⭐⭐ |
| `github` | 分析 | 代码库研究 | ⭐⭐ | ⭐⭐⭐⭐ |
| `gh-issues` | 自动化 | 批量issue处理 | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| `oracle` | 分析 | 代码库分析 | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| `pdf` | 处理 | PDF分析 | ⭐ | ⭐⭐⭐⭐ |
| `nano-pdf` | 处理 | PDF编辑 | ⭐⭐ | ⭐⭐⭐ |
| `image` | 处理 | 图像分析 | ⭐ | ⭐⭐⭐⭐ |
| `openai-whisper` | 处理 | 音频转录 | ⭐⭐ | ⭐⭐⭐⭐ |
| `twitter-automation` | 监控 | 社媒趋势追踪 | ⭐⭐ | ⭐⭐⭐⭐ |
| `obsidian` | 管理 | 知识库管理 | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| `bear-notes` | 管理 | 笔记管理 | ⭐ | ⭐⭐⭐ |
| `clawhub` | 管理 | 技能生态管理 | ⭐ | ⭐⭐⭐ |
| `gemini` | 处理 | AI问答生成 | ⭐ | ⭐⭐⭐⭐ |

---

## 信息搜集工具

### 1. 🌐 Web Search — 网络搜索基石

**技能ID**: `web_search`  
**核心能力**: Brave Search API驱动的网络搜索，支持区域化和本地化结果

```yaml
适用场景:
  - 快速事实查证
  - 竞品信息搜集
  - 行业趋势调研
  - 新闻事件追踪

关键参数:
  query: 搜索关键词
  count: 结果数量 (1-10)
  country: 区域代码 (US, DE, ALL)
  freshness: 时效筛选 (pd=今日, pw=本周, pm=本月)
  search_lang: 搜索语言
```

**最佳实践**:
```bash
# 今日最新科技新闻
web_search "AI agent trends" freshness=pd count=10

# 德语区竞品分析
web_search "German SaaS CRM" country=DE search_lang=de
```

---

### 2. 📄 Web Fetch — 网页内容提取

**技能ID**: `web_fetch`  
**核心能力**: 从URL提取可读内容，HTML转Markdown/Text

```yaml
适用场景:
  - 文章全文抓取
  - 竞品文档下载
  - 研究报告采集
  - 博客内容归档

关键参数:
  url: 目标网址
  extractMode: 提取模式 (markdown/text)
  maxChars: 最大字符数
```

**最佳实践**:
```bash
# 抓取竞品博客文章
web_fetch "https://competitor.com/blog/launch" --extract markdown

# 提取技术文档
web_fetch "https://docs.api.com/guide" --maxChars 50000
```

---

### 3. 🔧 Browser — 浏览器自动化

**技能ID**: `browser`  
**核心能力**: 通过OpenClaw Browser Control Server控制浏览器

```yaml
适用场景:
  - 需要登录的页面抓取
  - 动态内容获取
  - 表单填写提交
  - 截图存档

关键操作:
  - open: 打开页面
  - snapshot: 页面快照
  - click/type/fill: 交互操作
  - screenshot: 截图
  - pdf: 导出PDF
```

**最佳实践**:
```bash
# 截图竞品着陆页
browser action=screenshot url="https://competitor.com" fullPage=true

# 登录后抓取数据
browser action=open url="https://dashboard.com"
browser action=fill selector="#email" text="user@example.com"
browser action=click selector="#submit"
```

---

### 4. 🤖 Agent Browser — AI浏览器代理

**技能ID**: `agent-browser`  
**核心能力**: inference.sh提供的高级浏览器自动化，支持@e引用系统

```yaml
适用场景:
  - 复杂多步骤网页任务
  - 需要智能决策的浏览
  - 表单自动化测试
  - 数据提取工作流

核心特性:
  - @e引用系统定位元素
  - 视频录制记录过程
  - JavaScript执行能力
  - 拖拽/上传支持
```

**最佳实践**:
```bash
# 打开页面获取元素引用
infsh app run agent-browser --function open --input '{"url": "https://example.com"}'
# 返回: @e1 [input] "Email", @e2 [button] "Submit"

# 基于引用执行操作
infsh app run agent-browser --function interact --input '{"action": "fill", "ref": "@e1", "text": "data@example.com"}'
infsh app run agent-browser --function interact --input '{"action": "click", "ref": "@e2"}'
```

---

## 学术研究利器

### 5. 🧾 Summarize — 内容摘要神器

**技能ID**: `summarize`  
**核心能力**: URL/文件/YouTube快速摘要，支持多模型

```yaml
适用场景:
  - 论文快速概览
  - 长文核心提取
  - 播客/视频转录摘要
  - 研究报告速读

支持模型:
  - google/gemini-3-flash-preview (默认)
  - openai/gpt-5.2
  - anthropic/claude-sonnet-4-20250514

关键参数:
  --length: short/medium/long/xl/xxl
  --youtube: YouTube视频处理
  --extract-only: 仅提取不摘要
  --firecrawl: 被屏蔽站点处理
```

**最佳实践**:
```bash
# 学术论文速读
summarize "https://arxiv.org/abs/2401.xxxxx" --length long

# YouTube教程转录
summarize "https://youtu.be/xxxxx" --youtube auto --extract-only

# PDF研究报告
summarize "/path/to/report.pdf" --model openai/gpt-5.2
```

---

### 6. 🔮 Oracle — 代码库深度分析

**技能ID**: `oracle`  
**核心能力**: 将提示+文件打包发送给大模型进行深度分析

```yaml
适用场景:
  - 开源项目代码审查
  - 架构设计分析
  - 技术债务评估
  - 竞品代码研究

核心特性:
  - 智能文件选择打包
  - 浏览器模式GPT-5.2 Pro
  - API模式多模型支持
  - 会话持久化
  - 文件附件支持
```

**最佳实践**:
```bash
# 预览token消耗
oracle --dry-run summary -p "分析这个项目的架构" --file "src/**"

# 浏览器模式深度分析
oracle --engine browser --model gpt-5.2-pro -p "分析竞品的API设计" --file "api/**"

# 多文件对比分析
oracle -p "对比前后端架构差异" --file "frontend/**" --file "backend/**"
```

---

### 7. 📑 PDF分析 — 文档智能处理

**技能ID**: `pdf`  
**核心能力**: 使用视觉模型分析PDF文档

```yaml
适用场景:
  - 学术论文解析
  - 财报数据提取
  - 合同条款分析
  - 研究报告处理

支持模型:
  - anthropic/claude-sonnet-4-20250514 (原生PDF)
  - google/gemini-3-flash-preview
  - 其他模型通过文本提取
```

**最佳实践**:
```bash
# 分析学术论文
pdf pdf="/path/to/paper.pdf" prompt="提取研究方法和主要发现"

# 多PDF对比分析
pdf pdfs=["/path/to/report1.pdf", "/path/to/report2.pdf"] prompt="对比两份报告的市场预测"

# 指定页面分析
pdf pdf="/path/to/doc.pdf" pages="10-20" prompt="分析第10-20页的技术细节"
```

---

### 8. 🖼️ Image — 图像智能分析

**技能ID**: `image`  
**核心能力**: 使用视觉模型分析图像内容

```yaml
适用场景:
  - 竞品界面分析
  - 数据图表解读
  - 设计稿审查
  - 截图信息提取

支持模型:
  - anthropic/claude-sonnet-4-20250514
  - google/gemini-3-flash-preview
```

**最佳实践**:
```bash
# 分析竞品UI截图
image image="/path/to/screenshot.png" prompt="分析这个界面的用户流程和设计模式"

# 多图对比
image images=["v1.png", "v2.png"] prompt="对比两个版本的设计变化"

# 数据图表分析
image image="/path/to/chart.png" prompt="提取图表中的关键数据和趋势"
```

---

## 趋势监控方案

### 9. 📰 Blogwatcher — RSS/博客监控

**技能ID**: `blogwatcher`  
**核心能力**: 监控博客和RSS/Atom订阅源更新

```yaml
适用场景:
  - 竞品博客追踪
  - 行业新闻监控
  - 技术博客订阅
  - 内容聚合

核心功能:
  - add: 添加博客
  - scan: 扫描更新
  - articles: 列出文章
  - read: 标记已读
```

**最佳实践**:
```bash
# 添加竞品博客
blogwatcher add "Competitor Blog" https://competitor.com/feed.xml

# 每日扫描更新
blogwatcher scan

# 查看新文章列表
blogwatcher articles

# 批量标记已读
blogwatcher read-all
```

---

### 10. 🐦 Twitter Automation — 社媒趋势追踪

**技能ID**: `twitter-automation`  
**核心能力**: 通过inference.sh自动化Twitter/X操作

```yaml
适用场景:
  - 竞品社媒监控
  - 行业话题追踪
  - KOL动态关注
  - 趋势话题分析

可用应用:
  - x/post-get: 获取推文详情
  - x/user-get: 获取用户资料
  - x/user-follow: 关注用户
  - x/post-search: 搜索推文 (需API权限)
```

**最佳实践**:
```bash
# 获取竞品最新推文
infsh app run x/user-get --input '{"username": "competitor"}'

# 追踪KOL动态
infsh app run x/user-get --input '{"username": "industry_leader"}'

# 分析推文表现
infsh app run x/post-get --input '{"tweet_id": "1234567890"}'
```

---

### 11. 🐙 GitHub — 开源生态监控

**技能ID**: `github`  
**核心能力**: GitHub CLI操作，issue/PR/CI管理

```yaml
适用场景:
  - 开源竞品追踪
  - 技术趋势分析
  - 开发者生态研究
  - 代码库健康度评估

核心功能:
  - issue list: 问题追踪
  - pr list: PR监控
  - run list: CI状态
  - api: 自定义API查询
```

**最佳实践**:
```bash
# 监控竞品开源项目
github issue list --repo competitor/product --state open
github pr list --repo competitor/product --json number,title,state

# 获取项目统计数据
github api repos/competitor/product --jq '{stars: .stargazers_count, forks: .forks_count}'

# 追踪发布动态
github api repos/competitor/product/releases/latest --jq '.tag_name, .published_at'
```

---

### 12. 🎙️ OpenAI Whisper — 音频内容转录

**技能ID**: `openai-whisper`  
**核心能力**: 本地语音转文字，无需API Key

```yaml
适用场景:
  - 播客内容转录
  - 会议录音整理
  - 视频音频提取
  - 访谈内容记录

模型选择:
  - tiny: 最快，准确度一般
  - base: 平衡选择
  - medium: 较好准确度
  - large-v3: 最佳准确度
  - turbo: 默认，速度与质量平衡
```

**最佳实践**:
```bash
# 播客转录
whisper /path/to/podcast.mp3 --model medium --output_format txt

# 生成字幕文件
whisper /path/to/video.mp4 --model turbo --output_format srt

# 多语言翻译
whisper /path/to/audio.mp3 --task translate --output_format json
```

---

## 竞品分析武器库

### 13. 🎞️ Video Frames — 视频帧提取

**技能ID**: `video-frames`  
**核心能力**: 使用ffmpeg提取视频帧和片段

```yaml
适用场景:
  - 竞品视频分析
  - 教程截图提取
  - UI动效分析
  - 演示视频拆解

关键参数:
  --time: 时间戳定位
  --out: 输出路径
```

**最佳实践**:
```bash
# 提取首帧作为封面
frame.sh /path/to/video.mp4 --out /tmp/cover.jpg

# 提取特定时间点
frame.sh /path/to/demo.mp4 --time 00:01:30 --out /tmp/feature.jpg

# 分析竞品演示视频
frame.sh /path/to/competitor-demo.mp4 --time 00:00:45 --out /tmp/onboarding.png
```

---

### 14. 🌊 Songsee — 音频可视化

**技能ID**: `songsee`  
**核心能力**: 生成音频频谱图和特征面板

```yaml
适用场景:
  - 竞品音频产品分析
  - 播客质量评估
  - 音乐特征分析
  - 音频内容研究

可视化类型:
  - spectrogram: 频谱图
  - mel: Mel频谱
  - chroma: 色度图
  - mfcc: 梅尔频率倒谱系数
  - tempo: 节拍图
```

**最佳实践**:
```bash
# 生成完整分析面板
songsee track.mp3 --viz spectrogram,mel,chroma,mfcc,tempo

# 提取特定时间段
songsee track.mp3 --start 30 --duration 10 -o segment.jpg

# 高质量输出
songsee track.mp3 --style inferno --width 1920 --height 1080
```

---

### 15. ♊️ Gemini CLI — AI问答引擎

**技能ID**: `gemini`  
**核心能力**: Google Gemini one-shot问答

```yaml
适用场景:
  - 快速概念解释
  - 技术问题解答
  - 内容生成辅助
  - 多语言翻译

核心特性:
  - 无需交互模式
  - JSON格式输出
  - 扩展插件支持
```

**最佳实践**:
```bash
# 技术概念解释
gemini "解释什么是向量数据库及其应用场景"

# JSON格式输出
gemini --output-format json "列出5个AI Agent框架，包含名称和特点"

# 内容生成
gemini "写一段竞品分析报告的引言，针对SaaS行业"
```

---

## 知识管理工具

### 16. 💎 Obsidian — 知识库管理

**技能ID**: `obsidian`  
**核心能力**: 通过CLI管理Obsidian Vault

```yaml
适用场景:
  - 研究资料归档
  - 竞品分析笔记
  - 知识库构建
  - 团队知识共享

核心功能:
  - search: 搜索笔记
  - search-content: 内容搜索
  - create: 创建笔记
  - move: 安全重命名
```

**最佳实践**:
```bash
# 搜索相关研究
obsidian-cli search "竞品分析"
obsidian-cli search-content "AI Agent"

# 创建研究报告
obsidian-cli create "Research/Competitor-Analysis-2024" --content "# 竞品分析..."

# 安全移动笔记
obsidian-cli move "Drafts/Note" "Research/Note"
```

---

### 17. 🐻 Bear Notes — 苹果生态笔记

**技能ID**: `bear-notes`  
**核心能力**: macOS Bear应用CLI管理

```yaml
适用场景:
  - 快速笔记记录
  - 标签管理
  - 灵感收集
  - 个人知识管理

核心功能:
  - create: 创建笔记
  - add-text: 追加内容
  - tags: 标签列表
  - open-tag: 标签浏览
```

**最佳实践**:
```bash
# 快速记录想法
echo "竞品新功能洞察..." | grizzly create --title "Insight $(date +%Y-%m-%d)" --tag research

# 查看研究标签
 grizzly open-tag --name "research" --enable-callback --json
```

---

## 工作流编排工具

### 18. 🛠️ gh-issues — 批量Issue处理

**技能ID**: `gh-issues`  
**核心能力**: 自动获取GitHub issue并派生子代理修复

```yaml
适用场景:
  - 开源项目批量分析
  - 竞品问题追踪
  - 技术债务扫描
  - 功能需求调研

核心特性:
  - 自动子代理派发
  - PR自动创建
  - 评论自动处理
  - 监控模式支持
```

**最佳实践**:
```bash
# 分析开源项目待解决问题
gh-issues facebook/react --label "good first issue" --limit 5

# 监控新项目问题
gh-issues vercel/next.js --watch --interval 10

# 仅分析PR评论
gh-issues microsoft/vscode --reviews-only
```

---

### 19. 📄 nano-pdf — PDF编辑

**技能ID**: `nano-pdf`  
**核心能力**: 自然语言指令编辑PDF

```yaml
适用场景:
  - 报告内容修改
  - PDF批注添加
  - 文档格式调整
  - 快速内容修正
```

**最佳实践**:
```bash
# 修改PDF标题
nano-pdf edit report.pdf 1 "Change the title to 'Q3 Results'"

# 批量修正	nano-pdf edit deck.pdf 3 "Fix typo 'recieve' to 'receive'"
```

---

### 20. 🔧 ClawHub — 技能生态管理

**技能ID**: `clawhub`  
**核心能力**: 搜索、安装、更新、发布agent skills

```yaml
适用场景:
  - 技能发现
  - 技能版本管理
  - 自定义技能发布
  - 团队协作同步

核心功能:
  - search: 技能搜索
  - install: 安装技能
  - update: 更新技能
  - publish: 发布技能
```

**最佳实践**:
```bash
# 搜索研究相关技能
clawhub search "research"
clawhub search "web scraping"

# 安装特定版本
clawhub install data-analyzer --version 1.2.3

# 批量更新
clawhub update --all
```

---

## 实战工作流

### 工作流1: 竞品全面调研

```mermaid
1. web_search "竞品名称" → 获取官方信息
2. web_fetch 竞品官网 → 提取产品描述
3. browser 截图竞品着陆页 → 视觉分析
4. github 获取开源项目数据 → 技术评估
5. blogwatcher 添加竞品博客 → 持续监控
6. obsidian 创建竞品档案 → 知识归档
```

**完整命令链**:
```bash
# Step 1: 基础信息搜集
web_search "CompetitorX pricing features"
web_fetch "https://competitorx.com"

# Step 2: 深度分析
browser action=screenshot url="https://competitorx.com" fullPage=true
image image="screenshot.png" prompt="分析这个产品的价值主张和用户定位"

# Step 3: 技术评估
github api repos/competitorx/product --jq '.stargazers_count, .forks_count, .language'

# Step 4: 持续监控
blogwatcher add "CompetitorX Blog" https://competitorx.com/blog/feed.xml

# Step 5: 归档整理
obsidian-cli create "Competitors/CompetitorX-Analysis" --content "# CompetitorX Analysis\n\n## Overview\n..."
```

---

### 工作流2: 行业趋势周报

```mermaid
1. blogwatcher scan → 获取RSS更新
2. web_search freshness=pw → 本周新闻
3. summarize 长文 → 生成摘要
4. twitter-automation user-get → KOL动态
5. obsidian create → 生成周报
```

**完整命令链**:
```bash
# Step 1: RSS监控扫描
blogwatcher scan
blogwatcher articles > /tmp/new_articles.txt

# Step 2: 新闻搜索
web_search "AI industry news" freshness=pw count=10

# Step 3: 内容摘要
summarize "https://techcrunch.com/ai-news" --length medium

# Step 4: 社媒监控
infsh app run x/user-get --input '{"username": "sama"}'

# Step 5: 生成周报
cat /tmp/insights.txt | obsidian-cli create "Weekly/Trend-Report-$(date +%Y-W%U)"
```

---

### 工作流3: 学术论文速览

```mermaid
1. web_search site:arxiv.org → 发现论文
2. web_fetch 论文PDF → 获取全文
3. pdf analyze → 深度分析
4. summarize --length short → 生成摘要
5. obsidian create → 知识归档
```

**完整命令链**:
```bash
# Step 1: 发现论文
web_search "site:arxiv.org transformer efficiency" freshness=pm count=5

# Step 2: 获取分析
pdf pdf="/path/to/paper.pdf" prompt="提取：1)核心贡献 2)方法 3)实验结果 4)局限性"

# Step 3: 生成摘要
summarize "/path/to/paper.pdf" --length short

# Step 4: 归档
obsidian-cli create "Papers/Transformer-Efficiency-2024" --content "# 论文笔记\n\n## 核心贡献\n..."
```

---

### 工作流4: 开源项目技术评估

```mermaid
1. github api → 获取项目元数据
2. oracle --file → 代码库深度分析
3. gh-issues → 问题生态扫描
4. web_search → 社区评价
5. summarize → 生成评估报告
```

**完整命令链**:
```bash
# Step 1: 基础数据
github api repos/langchain-ai/langchain --jq '{stars: .stargazers_count, forks: .forks_count, issues: .open_issues_count}'

# Step 2: 代码分析 (克隆后)
oracle --engine browser --model gpt-5.2-pro -p "分析这个项目的架构设计和核心模块" --file "libs/**"

# Step 3: 问题扫描
gh-issues langchain-ai/langchain --label bug --limit 10 --dry-run

# Step 4: 社区评价
web_search "LangChain review experience" freshness=py
```

---

## 快速参考卡

### 搜索类速查

| 需求 | 首选技能 | 备用方案 |
|------|----------|----------|
| 快速搜索 | web_search | browser + Google |
| 网页内容 | web_fetch | browser snapshot |
| 动态页面 | agent-browser | browser |
| 批量监控 | blogwatcher | cron + web_search |

### 分析类速查

| 内容类型 | 推荐技能 | 输出格式 |
|----------|----------|----------|
| 网页/文章 | summarize | markdown |
| PDF文档 | pdf | 结构化分析 |
| 代码库 | oracle | 深度报告 |
| 图像 | image | 描述+分析 |
| 音频 | openai-whisper | 转录文本 |
| 视频 | video-frames | 关键帧 |

### 监控类速查

| 监控目标 | 推荐技能 | 频率建议 |
|----------|----------|----------|
| RSS/博客 | blogwatcher | 每日扫描 |
| GitHub | github | 实时/按需 |
| Twitter | twitter-automation | 按需查询 |
| 行业新闻 | web_search freshness=pw | 每周 |

---

## 🎯 使用建议

### 效率最大化原则

1. **组合优于单用**: 大多数任务需要2-3个技能组合完成
2. **自动化优先**: 使用blogwatcher等监控技能减少重复劳动
3. **质量检查**: AI生成的摘要和分析需要人工验证
4. **版本控制**: 重要研究资料使用obsidian/git管理

### 成本控制

| 技能 | 成本类型 | 控制建议 |
|------|----------|----------|
| web_search | API调用 | 合理设置count参数 |
| summarize | LLM tokens | 使用--length控制长度 |
| oracle | LLM tokens | 先用--dry-run预览 |
| agent-browser | 服务调用 | 及时关闭session |
| pdf/image | LLM tokens | 指定pages减少处理量 |

### 数据安全

- ⚠️ 敏感数据避免上传至第三方API
- ✅ 优先使用本地处理技能(whisper, oracle本地模式)
- ✅ API Key妥善保管，使用环境变量注入

---

## 📚 延伸阅读

- [OpenClaw官方文档](https://openclaw.com/docs)
- [inference.sh平台](https://inference.sh)
- [clawhub技能市场](https://clawhub.com)

---

> 🚀 **PowerClaw团队使命**: 让AI代理成为你的超级研究助手
> 
> 本文档由Power内容呆生成 | 字数统计: ~6500字 | 覆盖技能: 20个
