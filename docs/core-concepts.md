# OpenClaw 核心概念

理解这些核心概念，帮助你更好地使用 OpenClaw。

## 1. 代理 (Agent)

**什么是代理**

代理是 OpenClaw 的核心执行单元。每个代理都有：
- 独立的记忆
- 特定的能力
- 可配置的行为

**创建代理**

```bash
# 创建新代理
openclaw agent create my-assistant

# 配置代理
openclaw agent config my-assistant --model gpt-4
```

**代理类型**

| 类型 | 用途 | 示例 |
|------|------|------|
| **通用代理** | 日常任务 | 问答、写作、分析 |
| **专业代理** | 特定领域 | 代码审查、数据分析 |
| **工作流代理** | 自动化 | 定时任务、批量处理 |

## 2. 技能 (Skills)

**什么是技能**

技能是 OpenClaw 的扩展模块，让 AI 能够使用外部工具。

**技能架构**

```
用户请求 → 代理 → 技能系统 → 外部工具
                ↑
            技能选择
            参数填充
            结果处理
```

**内置技能**

| 技能 | 功能 | 使用场景 |
|------|------|----------|
| `web-search` | 网络搜索 | 信息查询 |
| `browser` | 浏览器控制 | 网页操作 |
| `file-system` | 文件操作 | 读写文件 |
| `messaging` | 消息发送 | 邮件、Slack |
| `code-exec` | 代码执行 | 运行脚本 |

**技能调用示例**

```javascript
// 在脚本中使用技能
const result = await skills.use('web-search', {
  query: 'OpenClaw 最新版本'
});
```

## 3. 记忆系统 (Memory)

**短期记忆**
- 当前对话上下文
- 临时变量
- 会话状态

**长期记忆**
- 用户偏好
- 历史决策
- 学习到的知识

**记忆类型**

```javascript
// 保存到长期记忆
memory.save({
  key: 'user_preference',
  value: { theme: 'dark', language: 'zh' }
});

// 读取记忆
const pref = memory.get('user_preference');
```

## 4. 工作流 (Workflows)

**什么是工作流**

工作流是一系列自动化任务的组合。

**创建工作流**

```yaml
# workflow.yaml
name: 每日报告
steps:
  - name: 收集数据
    skill: web-search
    params:
      query: "今日科技新闻"
  
  - name: 分析总结
    agent: analyst
    prompt: "总结新闻要点"
  
  - name: 发送邮件
    skill: email-send
    params:
      to: "user@example.com"
```

**工作流触发器**

- **定时触发**: 每天 9:00 执行
- **事件触发**: 文件修改时执行
- **手动触发**: 用户命令触发

## 5. MCP 服务器

**什么是 MCP**

MCP (Model Context Protocol) 是一种标准化的 AI 工具接口。

**MCP 架构**

```
┌─────────┐     ┌─────────┐     ┌─────────┐
│  AI 模型 │────▶│ MCP 客户端│────▶│ MCP 服务器│
└─────────┘     └─────────┘     └─────────┘
                                      │
                                      ▼
                                ┌─────────┐
                                │ 外部工具 │
                                └─────────┘
```

**使用 MCP**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"]
    }
  }
}
```

## 6. 配置文件

**全局配置**

位置: `~/.openclaw/config.json`

```json
{
  "defaultModel": "gpt-4",
  "workspace": "/Users/user/openclaw",
  "skills": {
    "autoInstall": true
  },
  "logging": {
    "level": "info"
  }
}
```

**代理配置**

位置: `workspace/agents/[name]/config.json`

```json
{
  "name": "my-agent",
  "model": "claude-3-opus",
  "skills": ["web-search", "file-system"],
  "memory": {
    "type": "persistent"
  }
}
```

## 7. 安全模型

**权限控制**

```yaml
permissions:
  filesystem:
    read: ["~/documents"]
    write: ["~/workspace"]
  network:
    allowed: ["*.openai.com", "*.google.com"]
  execution:
    shell: false
    sandbox: true
```

**数据隐私**
- 本地优先存储
- 可选云同步
- 端到端加密

## 8. 最佳实践

### 1. 代理设计
- 单一职责原则
- 明确的输入输出
- 可复用的技能

### 2. 错误处理
```javascript
try {
  const result = await riskyOperation();
} catch (error) {
  // 自动重试
  await retry(operation, { maxAttempts: 3 });
}
```

### 3. 性能优化
- 缓存常用数据
- 批量处理请求
- 异步执行

### 4. 可观测性
- 记录所有操作
- 监控执行时间
- 追踪错误率

---

理解这些概念后，你可以构建复杂的 AI 自动化系统！
