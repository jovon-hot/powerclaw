# PowerClaw 自动内容发布系统

> 一键发布到多渠道，持续对外推广

---

## 系统架构

```
内容创作
    ↓
内容审核
    ↓
[发布引擎]
    ├─→ GitHub Pages (网站)
    ├─→ Twitter/X (线程)
    ├─→ LinkedIn (长文)
    ├─→ Discord (社区)
    └─→ Telegram (频道)
    ↓
数据追踪
```

---

## 发布流程

### 1. 内容准备

```bash
# 创建文章
./scripts/create-article.sh "文章标题"

# 自动生成
- 文章模板
- Twitter线程草稿
- LinkedIn摘要
- 标签推荐
```

### 2. 内容审核

**自检清单**:
- [ ] 标题吸引人吗？
- [ ] 结构清晰吗？
- [ ] 代码可运行吗？
- [ ] 有错别字吗？
- [ ] SEO关键词布局了吗？

### 3. 一键发布

```bash
# 发布到所有渠道
./scripts/publish-all.sh blog/posts/article-name.md

# 或单独发布
./scripts/publish-web.sh    # 网站
./scripts/publish-twitter.sh # Twitter
./scripts/publish-linkedin.sh # LinkedIn
```

---

## 渠道策略

### Twitter/X
**策略**: 线程式发布，每篇内容拆成5-7条推文
**频率**: 每日1-2个线程
**时间**: 北京时间 08:00, 20:00 (用户活跃时段)

### LinkedIn
**策略**: 专业长文，适合B端用户
**频率**: 每周3-4篇
**时间**: 工作日 12:00-13:00

### Discord
**策略**: 社区讨论，问答互动
**频率**: 实时
**内容**: 新文章通知、问答、讨论

### Telegram
**策略**: 频道广播，快速触达
**频率**: 每日1篇
**内容**: 文章摘要+链接

---

## 自动化脚本

### 发布脚本模板

```bash
#!/bin/bash
# publish-all.sh

ARTICLE=$1
echo "🚀 开始多渠道发布: $ARTICLE"

# 1. 发布到网站
./scripts/publish-web.sh "$ARTICLE"

# 2. 生成社媒内容
./scripts/generate-social.sh "$ARTICLE"

# 3. 发布到Twitter (需要浏览器插件配合)
echo "📱 请在Twitter发布线程"

# 4. 发布到LinkedIn
echo "💼 请在LinkedIn发布"

# 5. 记录数据
echo "$(date): 发布 $ARTICLE" >> worklog/publish-log.txt

echo "✅ 发布完成"
```

---

## 推广策略

### 冷启动 (当前阶段)
- 利用个人社交网络
- 参与相关话题讨论
- 在相关社区分享

### 增长阶段 (流量>1000/天)
- SEO优化
- 内容合作
- 嘉宾投稿

### 规模化阶段 (流量>10000/天)
- 付费广告
- 品牌合作
- 线下活动

---

## 数据追踪

### 核心指标
- 网站访问量 (Google Analytics)
- 社媒互动数 (Twitter API)
- 邮件订阅数 (ConvertKit)
- 文章分享数

### 追踪工具
```bash
# 每日数据报告
./scripts/daily-report.sh

# 周报生成
./scripts/weekly-report.sh
```

---

*持续优化中...*
