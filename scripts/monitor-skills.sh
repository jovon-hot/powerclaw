#!/bin/bash
# PowerClaw Skill 监控脚本
# 用途: 监控 awesome-openclaw-skills 更新，发现新skill时自动生成内容

REPO_URL="https://github.com/VoltAgent/awesome-openclaw-skills"
LAST_CHECK_FILE="/Users/adai/Desktop/memlib/Workspace/powerclaw/.last_skill_check"
CONTENT_DIR="/Users/adai/Desktop/memlib/Workspace/powerclaw/content"
DOCS_DIR="/Users/adai/Desktop/memlib/Workspace/powerclaw/docs"

# 获取当前日期
TODAY=$(date +%Y-%m-%d)
NOW=$(date +%Y-%m-%d_%H:%M)

# 检查上次运行时间
if [ -f "$LAST_CHECK_FILE" ]; then
    LAST_CHECK=$(cat "$LAST_CHECK_FILE")
else
    LAST_CHECK="1970-01-01"
fi

echo "🔍 开始检查 awesome-openclaw-skills 更新..."
echo "📅 上次检查: $LAST_CHECK"
echo "📅 本次检查: $TODAY"

# 获取最新commit时间 (需要git或API)
# 这里使用GitHub API获取最新commit
LATEST_COMMIT=$(curl -s "https://api.github.com/repos/VoltAgent/awesome-openclaw-skills/commits/main" | grep -o '"date": "[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$LATEST_COMMIT" ]; then
    echo "❌ 无法获取最新commit信息，跳过本次检查"
    exit 1
fi

echo "📝 最新Commit: $LATEST_COMMIT"

# 比较时间 (简化处理：比较日期)
LATEST_DATE=$(echo $LATEST_COMMIT | cut -d'T' -f1)

if [[ "$LATEST_DATE" > "$LAST_CHECK" ]] || [[ "$LATEST_DATE" == "$LAST_CHECK" ]]; then
    echo "✅ 发现更新!"
    
    # 获取更新的文件列表
    UPDATED_FILES=$(curl -s "https://api.github.com/repos/VoltAgent/awesome-openclaw-skills/commits/main" | grep -o '"filename": "[^"]*"' | cut -d'"' -f4)
    
    if echo "$UPDATED_FILES" | grep -q "categories/"; then
        echo "🆕 有新的Skill分类文件更新!"
        
        # 生成新内容提醒
        echo "" >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        echo "# 🆕 新Skill发现 - $NOW" >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        echo "" >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        echo "检测到 awesome-openclaw-skills 有更新:" >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        echo "- 更新时间: $LATEST_COMMIT" >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        echo "- 更新文件:" >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        echo "$UPDATED_FILES" | grep "categories/" | sed 's/^/- /' >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        echo "" >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        echo "👉 需要人工分析并生成介绍文案" >> "$CONTENT_DIR/new-skills-alert-$NOW.md"
        
        echo "📝 已生成提醒文档: $CONTENT_DIR/new-skills-alert-$NOW.md"
        
        # 可以在这里添加通知逻辑 (邮件/Slack/等)
        # echo "新Skill更新: $UPDATED_FILES" | mail -s "PowerClaw Skill更新提醒" admin@powerclaw.io
    fi
else
    echo "😴 没有新更新"
fi

# 更新检查时间
echo "$TODAY" > "$LAST_CHECK_FILE"

echo "✅ 检查完成"
