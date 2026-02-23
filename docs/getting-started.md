# OpenClaw 快速开始指南

5 分钟上手 OpenClaw，让 AI 开始为你工作。

## 1. 安装 OpenClaw

### macOS (Homebrew)

```bash
brew tap openclaw/tap
brew install openclaw
```

### 验证安装

```bash
openclaw --version
```

## 2. 初始配置

```bash
# 启动配置向导
openclaw configure

# 设置工作目录
openclaw config set workspace /path/to/your/workspace
```

## 3. 基础命令

### 查看状态
```bash
openclaw status
```

### 使用 AI 助手
```bash
# 直接提问
openclaw ask "如何自动化我的邮件回复？"

# 执行文件
openclaw run script.js
```

### 管理技能
```bash
# 列出已安装技能
openclaw skills list

# 安装新技能
openclaw skills install web-search

# 使用技能
openclaw skills use web-search "搜索最新的 AI 新闻"
```

## 4. 第一个自动化任务

创建一个简单的自动化脚本：

```bash
# 创建文件
cat > hello.txt <> 'EOF'
你好，我是 OpenClaw！
EOF

# 让 AI 处理
openclaw ask "读取 hello.txt 并总结内容"
```

## 5. 进阶配置

### 设置 API Key

```bash
# OpenAI
openclaw config set openai.api_key sk-...

# 其他服务
openclaw config set serpapi.api_key ...
```

### 配置模型

```bash
# 使用 GPT-4
openclaw config set model gpt-4

# 使用 Claude
openclaw config set model claude-3-opus
```

## 6. 常用技巧

### 技巧 1: 使用管道
```bash
echo "分析这段代码" | openclaw ask
```

### 技巧 2: 批量处理
```bash
openclaw batch process *.md --action "翻译为英文"
```

### 技巧 3: 定时任务
```bash
# 添加定时任务
openclaw cron add "0 9 * * *" "分析今日新闻"
```

## 7. 故障排除

### 问题 1: 命令未找到
```bash
# 检查安装
which openclaw

# 重新安装
brew reinstall openclaw
```

### 问题 2: API 错误
```bash
# 验证 API Key
openclaw config validate

# 查看日志
openclaw logs
```

### 问题 3: 权限问题
```bash
# 修复权限
openclaw fix-permissions
```

## 8. 下一步

- 📖 阅读 [完整文档](docs/)
- 🎯 查看 [实战案例](examples/)
- 🤝 加入 [社区讨论](https://github.com/openclaw/openclaw/discussions)

---

**恭喜！你已经完成了 OpenClaw 的入门配置。** 🎉
