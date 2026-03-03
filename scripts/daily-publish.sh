#!/bin/bash
# PowerClaw 每日内容发布脚本
# 用途: 自动生成并发布每日内容

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
CONTENT_DIR="/Users/adai/Desktop/memlib/Workspace/powerclaw/content"
DOCS_DIR="/Users/adai/Desktop/memlib/Workspace/powerclaw/docs"

echo "🚀 PowerClaw 每日内容发布 - $DATE $TIME"
echo "=========================================="

# 1. 检查新Skill
bash /Users/adai/Desktop/memlib/Workspace/powerclaw/scripts/monitor-skills.sh

# 2. 生成今日推文内容
cat > "$CONTENT_DIR/tweet-$DATE.md" << 'EOF'
# 今日推文 - $(date +%Y-%m-%d)

## 推文内容
（内容由CEO根据实际情况生成）

## 配图
（待制作）

## 发布时间
$(date +%H:%M)

## 发布状态
- [ ] 已发布
EOF

echo "✅ 今日推文模板已生成: $CONTENT_DIR/tweet-$DATE.md"

# 3. 检查内容库存
echo "📊 当前内容库存:"
echo "- Skill介绍文档: $(ls $DOCS_DIR/*.md 2>/dev/null | wc -l) 篇"
echo "- 推文素材: $(ls $CONTENT_DIR/*.md 2>/dev/null | wc -l) 篇"

# 4. 生成日报
cat > "$CONTENT_DIR/daily-report-$DATE.md" << EOF
# PowerClaw 日报 - $DATE

## 今日完成
- [ ] 内容生产
- [ ] 社媒发布
- [ ] 用户互动

## 数据统计
- 新增内容: 
- 网站PV: 
- 社媒互动: 

## 明日计划
- 

## 问题与风险
- 
EOF

echo "✅ 日报模板已生成: $CONTENT_DIR/daily-report-$DATE.md"
echo ""
echo "🎯 CEO今日任务:"
echo "1. 完善推文内容"
echo "2. 发布到Twitter"
echo "3. 回复用户评论"
echo "4. 准备明日内容"
