---
layout: default
title: "网站地图 | PowerClaw"
---

# 🗺️ PowerClaw 网站结构

## 导航重构方案

### 顶部导航

```
[Logo] PowerClaw    [首页] [教程] [技能市场] [MCP生态] [博客] [产品] 🔍
```

### 主导航页面

#### 🏠 首页 (/)
- Hero区域 + 核心价值主张
- 最新文章展示（3篇）
- 热门技能推荐（6个）
- 快速开始CTA

#### 📚 教程中心 (/tutorials)
- 新手入门 (/tutorials/beginner)
  - 安装配置指南
  - 第一个Skill
  - 基础命令速查
- 进阶实战 (/tutorials/advanced)
  - 工作流自动化
  - MCP服务器配置
  - 自定义Skill开发
- 企业部署 (/tutorials/enterprise)
  - 集群架构设计
  - 安全加固指南
  - 监控与运维

#### 🛠️ 技能市场 (/skills)
- 技能评测 (/skills/reviews)
- 推荐技能 (/skills/recommended)
- 自建教程 (/skills/create)

#### 🔌 MCP生态 (/mcp)
- MCP入门 (/mcp/intro)
- 服务器推荐 (/mcp/servers)
- 开发指南 (/mcp/develop)

#### 📝 博客 (/blog)
- 全部文章
- 按标签筛选
- 订阅RSS

#### 🚀 产品 (/products)
- DeFi工具套件
  - Auto-Compound Bot
  - Gas Optimizer
  - Airdrop Hunter
- 定价与购买

#### 💼 服务 (/services)
- 企业咨询
- 培训服务
- 定制开发

---

## URL结构

```
/
├── /tutorials
│   ├── /beginner
│   ├── /advanced
│   └── /enterprise
├── /skills
│   ├── /reviews
│   ├── /recommended
│   └── /create
├── /mcp
│   ├── /intro
│   ├── /servers
│   └── /develop
├── /blog
│   └── /posts
│       ├── /ai-workflow-pain-points
│       ├── /openclaw-security-crisis
│       └── ...
├── /products
│   ├── /auto-compound-bot
│   ├── /gas-optimizer
│   └── /airdrop-hunter
└── /services
    ├── /consulting
    ├── /training
    └── /development
```

---

## SEO优化清单

### Meta标签模板

```html
<title>{页面标题} | PowerClaw - OpenClaw实战技巧与AI Agent资源导航站</title>
<meta name="description" content="{页面描述}">
<meta name="keywords" content="OpenClaw, AI Agent, 自动化, {页面关键词}">

<!-- Open Graph -->
<meta property="og:title" content="{页面标题}">
<meta property="og:description" content="{页面描述}">
<meta property="og:image" content="https://adai-tools.github.io/powerclaw/og-image.png">
<meta property="og:url" content="{页面URL}">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{页面标题}">
<meta name="twitter:description" content="{页面描述}">
<meta name="twitter:image" content="https://adai-tools.github.io/powerclaw/twitter-image.png">
```

### 结构化数据 (JSON-LD)

```json
{
  "@context": "https://schema.org",
  "@type": "TechArticle",
  "headline": "{文章标题}",
  "author": {
    "@type": "Organization",
    "name": "PowerClaw Team"
  },
  "publisher": {
    "@type": "Organization",
    "name": "PowerClaw",
    "logo": {
      "@type": "ImageObject",
      "url": "https://adai-tools.github.io/powerclaw/logo.png"
    }
  },
  "datePublished": "{发布日期}",
  "dateModified": "{修改日期}",
  "description": "{文章描述}",
  "keywords": "{关键词}"
}
```

---

## 待实现功能

- [ ] 面包屑导航
- [ ] 文章目录(Table of Contents)
- [ ] 站内搜索
- [ ] 相关文章推荐
- [ ] 暗黑模式切换
- [ ] 阅读进度条
- [ ] 代码复制按钮
- [ ] 社交分享按钮
- [ ] 文章评分/点赞

---

*文档创建: 2026-03-03*
