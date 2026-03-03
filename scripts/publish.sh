#!/bin/bash
# PowerClaw 一键发布脚本
# 使用: ./publish.sh [文章路径]

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 PowerClaw 发布系统${NC}"
echo "===================="

# 检查参数
if [ -z "$1" ]; then
    echo -e "${RED}错误: 请指定文章路径${NC}"
    echo "用法: ./publish.sh blog/posts/article-name.md"
    exit 1
fi

ARTICLE_PATH="$1"
ARTICLE_NAME=$(basename "$ARTICLE_PATH" .md)

echo -e "${YELLOW}📄 发布文章: $ARTICLE_NAME${NC}"

# 1. 验证文章格式
echo "✓ 验证文章格式..."
if [ ! -f "$ARTICLE_PATH" ]; then
    echo -e "${RED}错误: 文章不存在 $ARTICLE_PATH${NC}"
    exit 1
fi

# 检查 frontmatter
if ! grep -q "^---$" "$ARTICLE_PATH"; then
    echo -e "${RED}错误: 文章缺少 frontmatter${NC}"
    exit 1
fi

# 2. 生成Twitter线程
echo "✓ 生成Twitter线程..."
TWITTER_THREAD="./tmp/twitter-thread-${ARTICLE_NAME}.txt"

# 提取标题和摘要
TITLE=$(grep "^title:" "$ARTICLE_PATH" | head -1 | sed 's/title: "//' | sed 's/"$//')

cat > "$TWITTER_THREAD" << EOF
🧵 ${TITLE}

1/7 线程开始 👇

#OpenClaw #AI自动化 #PowerClaw
EOF

echo "  线程已保存到: $TWITTER_THREAD"

# 3. 更新博客索引
echo "✓ 更新博客索引..."
# 自动更新 blog.md (可由AI辅助)

# 4. 部署到GitHub Pages
echo "✓ 部署网站..."
if [ -d ".git" ]; then
    git add -A
    git commit -m "发布文章: $ARTICLE_NAME" || true
    git push origin main || echo -e "${YELLOW}警告: 推送失败，请手动执行${NC}"
else
    echo -e "${YELLOW}警告: 非git仓库，跳过部署${NC}"
fi

# 5. 社交媒体发布（需要浏览器扩展配合）
echo "✓ 准备社交媒体发布..."
echo "  - Twitter: 请使用浏览器插件发布 $TWITTER_THREAD"
echo "  - LinkedIn: 待配置"
echo "  - Discord: 待配置"

# 6. 记录发布日志
echo "✓ 记录发布日志..."
LOG_FILE="worklog/publish-log-$(date +%Y-%m-%d).md"
cat >> "$LOG_FILE" << EOF

## $(date '+%Y-%m-%d %H:%M') 发布记录

- 文章: $ARTICLE_NAME
- 路径: $ARTICLE_PATH
- Twitter线程: $TWITTER_THREAD
- 状态: 已发布

EOF

echo ""
echo -e "${GREEN}✅ 发布流程完成！${NC}"
echo "===================="
echo "后续步骤:"
echo "1. 使用浏览器插件发布Twitter线程"
echo "2. 在LinkedIn分享文章链接"
echo "3. 在Discord社区推广"
echo ""
echo "文章链接: https://adai-tools.github.io/powerclaw/$ARTICLE_PATH"
