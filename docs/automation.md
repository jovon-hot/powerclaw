# 自动化工作流实战

学习如何使用 OpenClaw 创建全自动化的工作流。

## 工作流 1: 每日新闻摘要

**目标**: 每天早上自动获取科技新闻并发送邮件

### 配置

```yaml
# workflows/daily-news.yaml
name: Daily Tech News
schedule: "0 9 * * *"  # 每天 9:00

steps:
  - name: search-news
    skill: web-search
    params:
      query: "科技新闻 AI 人工智能 2025"
      count: 10
  
  - name: summarize
    action: llm
    prompt: |
      总结以下新闻的要点，用中文输出：
      {{steps.search-news.results}}
  
  - name: send-email
    skill: email
    params:
      to: "{{config.user.email}}"
      subject: "每日科技新闻 - {{date}}"
      body: "{{steps.summarize.output}}"
```

### 部署

```bash
# 添加工作流
openclaw workflow add workflows/daily-news.yaml

# 启用自动运行
openclaw workflow enable daily-news
```

## 工作流 2: 代码自动审查

**目标**: Git 提交前自动检查代码质量

### 配置

```yaml
# workflows/code-review.yaml
name: Auto Code Review
trigger: pre-commit

steps:
  - name: analyze-code
    action: llm
    prompt: |
      审查以下代码变更：
      {{git.diff}}
      
      检查：
      1. 潜在 bug
      2. 代码风格
      3. 性能问题
      4. 安全漏洞
  
  - name: check-secrets
    skill: security-scan
    params:
      check: ["api_keys", "passwords", "tokens"]
  
  - name: generate-report
    action: llm
    prompt: |
      生成代码审查报告：
      {{steps.analyze-code.output}}
      {{steps.check-secrets.findings}}
```

### Git Hook 集成

```bash
# 安装 git hook
openclaw hook install pre-commit code-review
```

## 工作流 3: 社交媒体自动发布

**目标**: 自动从 RSS 读取内容并发布到社交媒体

### 配置

```yaml
# workflows/social-post.yaml
name: Auto Social Post
schedule: "0 */4 * * *"  # 每 4 小时

steps:
  - name: fetch-rss
    skill: rss-reader
    params:
      url: "https://example.com/feed.xml"
      limit: 5
  
  - name: rewrite-content
    action: llm
    prompt: |
      将以下内容改写为适合社交媒体的短文（不超过 280 字）：
      {{steps.fetch-rss.items[0].title}}
      {{steps.fetch-rss.items[0].summary}}
  
  - name: post-twitter
    skill: twitter
    params:
      text: "{{steps.rewrite-content.output}}"
      
  - name: post-linkedin
    skill: linkedin
    params:
      text: "{{steps.rewrite-content.output}}"
      link: "{{steps.fetch-rss.items[0].link}}"
```

## 工作流 4: 数据备份自动化

**目标**: 定期备份重要数据到云端

### 配置

```yaml
# workflows/backup.yaml
name: Data Backup
schedule: "0 2 * * *"  # 每天凌晨 2:00

steps:
  - name: compress-data
    shell: |
      tar -czf backup-{{date}}.tar.gz ~/Documents ~/Projects
  
  - name: upload-s3
    skill: aws-s3
    params:
      bucket: "my-backups"
      key: "openclaw/backup-{{date}}.tar.gz"
      file: "backup-{{date}}.tar.gz"
  
  - name: cleanup-old
    shell: |
      # 删除 30 天前的备份
      find . -name "backup-*.tar.gz" -mtime +30 -delete
  
  - name: notify
    skill: slack
    params:
      message: "✅ 每日备份完成 - {{date}}"
```

## 工作流 5: 智能投资决策

**目标**: 监控市场并自动执行投资策略

### 配置

```yaml
# workflows/trading.yaml
name: Smart Trading
schedule: "0 */1 * * *"  # 每小时检查

steps:
  - name: fetch-prices
    skill: crypto-api
    params:
      symbols: ["BTC", "ETH", "SOL"]
  
  - name: analyze-trend
    action: llm
    prompt: |
      分析以下价格数据，判断趋势：
      {{steps.fetch-prices.data}}
      
      输出：
      - 趋势方向（上涨/下跌/震荡）
      - 置信度（0-1）
      - 建议操作（买入/卖出/持有）
  
  - name: execute-trade
    condition: "{{steps.analyze-trend.confidence}} > 0.8"
    skill: trading-api
    params:
      action: "{{steps.analyze-trend.recommendation}}"
      symbol: "{{steps.analyze-trend.best-opportunity}}"
      amount: "{{config.trading.default-amount}}"
  
  - name: log-decision
    action: log
    params:
      level: "info"
      message: "交易执行：{{steps.execute-trade.result}}"
```

## 高级技巧

### 条件执行

```yaml
steps:
  - name: check-condition
    action: evaluate
    expression: "{{data.price}} > {{config.threshold}}"
  
  - name: conditional-action
    condition: "{{steps.check-condition.result}} == true"
    action: send-alert
```

### 错误处理

```yaml
steps:
  - name: risky-operation
    action: api-call
    retry:
      max-attempts: 3
      delay: 5s
    on-error:
      action: send-notification
      params:
        message: "操作失败，已重试 3 次"
```

### 并行执行

```yaml
steps:
  - name: parallel-tasks
    parallel:
      - name: task-1
        action: fetch-data
        params: { source: "api1" }
      - name: task-2
        action: fetch-data
        params: { source: "api2" }
      - name: task-3
        action: fetch-data
        params: { source: "api3" }
  
  - name: merge-results
    action: combine
    inputs: ["{{steps.parallel-tasks.task-1}}", "{{steps.parallel-tasks.task-2}}", "{{steps.parallel-tasks.task-3}}"]
```

## 调试工作流

### 测试运行

```bash
# 手动触发工作流
openclaw workflow run daily-news --dry-run

# 查看详细日志
openclaw workflow logs daily-news --verbose
```

### 监控状态

```bash
# 查看工作流状态
openclaw workflow status

# 查看执行历史
openclaw workflow history
```

## 最佳实践

1. **从小做起** - 先创建简单的工作流，逐步增加复杂度
2. **充分测试** - 使用 dry-run 模式测试后再启用
3. **错误处理** - 为每个可能失败的步骤添加错误处理
4. **监控告警** - 设置失败通知，及时了解问题
5. **版本控制** - 将工作流文件纳入 Git 管理

---

**现在你可以创建自己的自动化工作流了！** 🚀
