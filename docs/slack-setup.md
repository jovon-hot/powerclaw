# Slack 配置指南

## 1. 创建 Slack App
1. 访问 https://api.slack.com/apps
2. 点击 "Create New App" → "From scratch"
3. 输入 App 名称: OpenClaw
4. 选择你的工作区

## 2. 配置 OAuth 权限
在左侧菜单点击 "OAuth & Permissions"

添加以下 Bot Token Scopes:
- chat:write (发送消息)
- im:write (私信)
- im:history (读取私信历史)
- groups:write (群组)
- mpim:write (多人私信)

## 3. 获取 Token
1. 点击 "Install to Workspace"
2. 授权应用
3. 复制 "Bot User OAuth Token" (以 xoxb- 开头)

## 4. 配置 OpenClaw

编辑配置文件:
```bash
openclaw configure
```

添加以下内容:
```json
{
  "channels": {
    "slack": {
      "token": "xoxb-your-token-here",
      "enabled": true
    }
  }
}
```

## 5. 获取 Channel ID

### 方法 A: 通过 Slack 网页版
1. 在浏览器中打开 Slack
2. 进入你想聊天的频道或私信
3. 查看 URL，格式如: `https://app.slack.com/client/T123/C123`
4. `C123` 或 `D123` 就是 Channel ID

### 方法 B: 在 Slack 中查看
1. 右键点击频道名称
2. 选择 "View channel details"
3. 复制 Channel ID

## 6. 开始聊天

现在你可以:
- 在 Slack 频道中 @OpenClaw 与我对话
- 或者直接私信 OpenClaw App

我会自动回复你的消息！

## 测试命令

发送消息给我:
```
@OpenClaw 你好，测试一下连接
```

我应该会回复确认消息。

---

## 故障排除

**问题**: 收不到回复
- 检查 Token 是否正确
- 确认 App 已安装到工作区
- 查看 OpenClaw 日志: `openclaw logs`

**问题**: 权限错误
- 重新检查 OAuth Scopes
- 重新安装 App

**问题**: 找不到 Channel ID
- 确保在正确的频道
- 使用网页版 Slack 查看 URL

---

## 进阶配置

### 多工作区支持
```json
{
  "channels": {
    "slack": {
      "accounts": [
        {
          "id": "work",
          "token": "xoxb-work-token",
          "enabled": true
        },
        {
          "id": "personal",
          "token": "xoxb-personal-token",
          "enabled": true
        }
      ]
    }
  }
}
```

### 指定默认频道
```json
{
  "channels": {
    "slack": {
      "token": "xoxb-your-token",
      "defaultChannel": "C1234567890",
      "enabled": true
    }
  }
}
```

---

配置完成后，你就可以在 Slack 中随时随地与我聊天了！
