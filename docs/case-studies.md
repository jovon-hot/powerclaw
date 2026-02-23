# OpenClaw 实战案例集

真实场景下的 OpenClaw 应用案例，可直接复制使用。

---

## 💼 案例 1: 自动化日报系统

**场景**: 每天早上自动收集信息，生成并发送日报

### 工作流配置
```yaml
# workflows/daily-report.yaml
name: Daily Report
trigger: cron(0 9 * * *)  # 每天 9:00

steps:
  1-search-news:
    skill: web-search
    params:
      query: "科技新闻 AI 人工智能 {{today}}"
      count: 10
  
  2-check-emails:
    skill: email
    action: fetch
    params:
      folder: inbox
      limit: 20
  
  3-analyze-calendar:
    skill: calendar
    action: list
    params:
      date: today
  
  4-generate-report:
    action: llm
    prompt: |
      基于以下信息生成日报：
      
      ## 新闻动态
      {{steps.1-search-news.results}}
      
      ## 邮件摘要
      {{steps.2-check-emails.summary}}
      
      ## 今日日程
      {{steps.3-analyze-calendar.events}}
      
      请生成一份简洁的日报，包含要点和待办事项。
  
  5-send-report:
    skill: email
    action: send
    params:
      to: "{{config.user.email}}"
      subject: "日报 - {{today}}"
      body: "{{steps.4-generate-report.output}}"
```

### 部署命令
```bash
openclaw workflow add workflows/daily-report.yaml
openclaw workflow enable daily-report
```

---

## 📊 案例 2: 智能投资组合监控

**场景**: 自动监控投资组合，生成分析报告并执行再平衡

### 监控脚本
```javascript
// portfolio-monitor.js
const PortfolioMonitor = {
  async checkPortfolio() {
    // 获取当前持仓
    const holdings = await this.getHoldings();
    
    // 分析配置
    const analysis = await openclaw.exec(`
      分析投资组合：
      ${JSON.stringify(holdings)}
      
      检查：
      1. 是否偏离目标配置
      2. 风险敞口变化
      3. 再平衡建议
    `);
    
    // 如果需要再平衡
    if (analysis.needsRebalance) {
      await this.sendAlert(analysis);
    }
    
    return analysis;
  },
  
  async getHoldings() {
    // 从各个平台获取持仓
    const sources = [
      { name: 'Aave', type: 'lending' },
      { name: 'Uniswap', type: 'lp' },
      { name: 'Wallet', type: 'token' }
    ];
    
    // 聚合数据
    return aggregatedData;
  }
};
```

### 使用
```bash
# 添加到定时任务
openclaw cron add "0 */4 * * *" "node portfolio-monitor.js"
```

---

## 📝 案例 3: 内容创作流水线

**场景**: 从选题到发布的全自动内容创作

### 流程
```bash
#!/bin/bash
# content-pipeline.sh

# 1. 选题研究
echo "🔍 研究热门话题..."
TOPIC=$(openclaw exec "基于今日热点，推荐一个技术博客选题")

# 2. 大纲生成
echo "📝 生成文章大纲..."
OUTLINE=$(openclaw exec "为'${TOPIC}'生成详细的文章大纲")

# 3. 内容创作
echo "✍️ 创作内容..."
CONTENT=$(openclaw exec "基于大纲创作完整文章：${OUTLINE}")

# 4. SEO 优化
echo "🔍 SEO 优化..."
SEO_CONTENT=$(openclaw exec "优化以下内容的关键词和结构：${CONTENT}")

# 5. 生成配图
echo "🎨 生成配图..."
openclaw exec "为文章生成封面图片描述"

# 6. 发布到多平台
echo "📤 发布内容..."
openclaw skills use blog-publish --content "${SEO_CONTENT}" --platforms hashnode,devto

# 7. 社交推广
echo "📱 社交推广..."
TWEET=$(openclaw exec "为文章生成一条 Twitter 推广文案：${TOPIC}")
openclaw skills use twitter --post "${TWEET}"

echo "✅ 内容创作流水线完成！"
```

---

## 🐛 案例 4: 智能 Bug 报告系统

**场景**: 自动收集错误信息，生成详细的 Bug 报告

### 错误处理器
```javascript
// bug-reporter.js
const BugReporter = {
  async handleError(error, context) {
    // 收集上下文
    const debugInfo = {
      error: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString(),
      context: context,
      logs: await this.getRecentLogs()
    };
    
    // AI 分析
    const analysis = await openclaw.exec(`
      分析以下错误：
      ${JSON.stringify(debugInfo, null, 2)}
      
      提供：
      1. 可能的原因
      2. 影响评估
      3. 修复建议
      4. 优先级判断
    `);
    
    // 生成报告
    const report = {
      title: `Bug: ${error.message.substring(0, 50)}`,
      description: analysis,
      priority: analysis.priority,
      labels: analysis.labels
    };
    
    // 创建 GitHub Issue
    await this.createIssue(report);
    
    // 发送告警
    if (analysis.priority === 'high') {
      await this.sendAlert(report);
    }
  }
};
```

---

## 🎯 案例 5: 客户支持自动化

**场景**: 自动回复客户邮件，分类问题，生成 FAQ

### 邮件处理工作流
```yaml
name: Customer Support Auto-Reply
trigger: email-received

steps:
  1-classify:
    action: llm
    prompt: |
      分类这封客户邮件的意图：
      Subject: {{email.subject}}
      Body: {{email.body}}
      
      分类：咨询/投诉/技术问题/账单/其他
  
  2-generate-reply:
    action: llm
    prompt: |
      为以下邮件生成专业回复：
      分类：{{steps.1-classify.category}}
      
      Original: {{email.body}}
      
      回复应该：
      1. 专业礼貌
      2. 直接回答或请求更多信息
      3. 提供相关资源链接
  
  3-send-reply:
    skill: email
    action: send
    params:
      to: "{{email.from}}"
      subject: "Re: {{email.subject}}"
      body: "{{steps.2-generate-reply.output}}"
  
  4-update-faq:
    condition: "{{steps.1-classify.isCommon}}"
    action: append
    params:
      file: "faq.md"
      content: "{{steps.2-generate-reply.question_answer}}"
```

---

## 📈 案例 6: 竞品监控系统

**场景**: 自动监控竞争对手动态，生成分析报告

### 监控脚本
```bash
#!/bin/bash
# competitor-monitor.sh

COMPETITORS=("competitor1.com" "competitor2.com" "competitor3.com")

for competitor in "${COMPETITORS[@]}"; do
  echo "🔍 监控 ${competitor}..."
  
  # 获取网站变化
  CHANGES=$(openclaw skills use browser --action diff --url "https://${competitor}")
  
  # 分析社交媒体
  SOCIAL=$(openclaw exec "搜索 ${competitor} 最近一周的社交媒体动态")
  
  # 生成洞察
  INSIGHT=$(openclaw exec "
    基于以下信息，分析 ${competitor} 的最新动向：
    网站变化：${CHANGES}
    社交媒体：${SOCIAL}
  ")
  
  echo "${INSIGHT}" >> "reports/${competitor}-$(date +%Y%m%d).md"
done

# 生成汇总报告
openclaw exec "基于所有竞品报告，生成周汇总分析"

# 发送给团队
openclaw skills use email --send-report "reports/summary-$(date +%Y%m%d).md"
```

---

## 🔍 案例 7: 代码审查助手

**场景**: 自动审查代码提交，发现问题并提供建议

### Git Hook 集成
```bash
#!/bin/bash
# .git/hooks/pre-commit

# 获取变更文件
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.(js|ts|py)$')

for file in $FILES; do
  echo "🔍 审查 ${file}..."
  
  # 代码分析
  REVIEW=$(openclaw exec "
    审查以下代码变更：
    $(git diff --cached "${file}")
    
    检查：
    1. 代码质量
    2. 潜在 Bug
    3. 安全漏洞
    4. 性能问题
    5. 最佳实践
  ")
  
  # 如果发现问题，阻止提交
  if echo "$REVIEW" | grep -q "CRITICAL\|BLOCKER"; then
    echo "❌ 发现严重问题，提交被阻止："
    echo "$REVIEW"
    exit 1
  fi
  
  echo "${REVIEW}" >> ".code-reviews/${file}-$(date +%s).md"
done
```

---

## 🎓 案例 8: 个性化学习助手

**场景**: 根据用户进度，自动生成学习计划和测验

### 学习系统
```javascript
// learning-assistant.js
const LearningAssistant = {
  async createPlan(topic, userLevel) {
    // 分析用户水平
    const assessment = await openclaw.exec(`
      基于用户水平 "${userLevel}"，评估学习 "${topic}" 的前提知识
    `);
    
    // 生成学习路径
    const plan = await openclaw.exec(`
      为学习 "${topic}" 创建一个 30 天学习计划：
      当前水平：${userLevel}
      知识差距：${assessment.gaps}
      
      包括：
      1. 每日学习目标
      2. 推荐资源
      3. 练习任务
      4. 里程碑检查点
    `);
    
    return plan;
  },
  
  async generateQuiz(topic, difficulty) {
    return openclaw.exec(`
      为 "${topic}" 生成 10 道 ${difficulty} 难度测验题：
      - 混合题型（选择、填空、简答）
      - 附带答案和解析
    `);
  }
};
```

---

## 🚀 快速部署

### 一键安装所有案例
```bash
# 克隆案例库
git clone https://github.com/openclaw/examples

# 安装依赖
cd examples && npm install

# 运行案例
openclaw example run daily-report
```

### 贡献你的案例
```bash
# 创建新案例
openclaw example create my-awesome-case

# 提交 PR
git push origin my-case
```

---

**更多案例持续更新中...**

**有创意？分享你的 OpenClaw 使用案例！**
