#!/bin/bash
# PowerClaw 持续执行引擎
# 每日自动执行检查点和任务推进

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

DATE=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)
WORKLOG="worklog/daily-${DATE}.md"

echo -e "${BLUE}╔════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     PowerClaw CEO 持续执行引擎 v1.0           ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════╝${NC}"
echo ""
echo "日期: ${DATE} ${TIME}"
echo ""

# 1. 晨会检查
morning_standup() {
    echo -e "${YELLOW}📋 晨会检查${NC}"
    echo "─────────────────────────────────────────"
    
    # 检查昨日日志
    YESTERDAY=$(date -v-1d +%Y-%m-%d 2>/dev/null || date -d "yesterday" +%Y-%m-%d)
    YESTERDAY_LOG="worklog/daily-${YESTERDAY}.md"
    
    if [ -f "$YESTERDAY_LOG" ]; then
        echo -e "${GREEN}✓${NC} 昨日日志已创建"
        COMPLETED=$(grep -c "\[x\]" "$YESTERDAY_LOG" 2>/dev/null || echo "0")
        TOTAL=$(grep -c "\[ \]" "$YESTERDAY_LOG" 2>/dev/null || echo "0")
        echo "  昨日完成: ${COMPLETED} 项"
    else
        echo -e "${YELLOW}⚠${NC} 昨日日志未找到"
    fi
    
    echo ""
}

# 2. 内容检查
content_check() {
    echo -e "${YELLOW}📝 内容资产检查${NC}"
    echo "─────────────────────────────────────────"
    
    # 统计文章数量
    ARTICLE_COUNT=$(find blog/posts -name "*.md" 2>/dev/null | wc -l)
    echo "已发布文章: ${ARTICLE_COUNT} 篇"
    
    # 检查今日文章
    TODAY_ARTICLE=$(find blog/posts -name "*.md" -newer worklog/daily-${DATE}.md 2>/dev/null | wc -l)
    if [ "$TODAY_ARTICLE" -gt 0 ]; then
        echo -e "${GREEN}✓${NC} 今日已发布 ${TODAY_ARTICLE} 篇文章"
    else
        echo -e "${RED}✗${NC} 今日尚未发布文章 (⚠️ 阻塞)"
    fi
    
    echo ""
}

# 3. 代码检查
code_check() {
    echo -e "${YELLOW}💻 代码库检查${NC}"
    echo "─────────────────────────────────────────"
    
    # 检查Git状态
    if [ -d ".git" ]; then
        CHANGES=$(git status --porcelain 2>/dev/null | wc -l)
        if [ "$CHANGES" -gt 0 ]; then
            echo -e "${YELLOW}⚠${NC} 有 ${CHANGES} 个未提交更改"
            echo "  建议: 运行 git add -A && git commit"
        else
            echo -e "${GREEN}✓${NC} 代码库已同步"
        fi
        
        # 检查今日提交
        TODAY_COMMITS=$(git log --since="midnight" --oneline 2>/dev/null | wc -l)
        echo "  今日提交: ${TODAY_COMMITS} 次"
    else
        echo -e "${RED}✗${NC} 非Git仓库"
    fi
    
    echo ""
}

# 4. 创建今日日志
create_daily_log() {
    if [ ! -f "$WORKLOG" ]; then
        echo -e "${YELLOW}📝 创建今日工作日志...${NC}"
        
        cat > "$WORKLOG" << EOF
# ${DATE} 工作日志

**日期**: ${DATE} (周$(date +%u | tr '1234567' '一二三四五六日'))  
**CEO**: PowerClaw CEO  
**状态**: 🟡 进行中

---

## 晨会 (09:00)

### 昨日回顾
- [ ] 检查昨日日志完成度
- [ ] 分析未完成原因

### 今日目标
**内容运营**:
- [ ] 创作今日文章
- [ ] 完成社媒发布

**产品研发**:
- [ ] 推进开发任务
- [ ] 修复已知问题

**运营推广**:
- [ ] 社区互动
- [ ] 数据监控

---

## 执行记录

### 上午 (09:00-12:00)

### 下午 (13:00-18:00)

---

## 晚会 (18:00)

### 今日完成度
- 内容: _/_ 篇
- 代码提交: _ 次
- 社媒发布: _ 条

### 阻塞问题
1. 

### 明日计划
1. 

---

## 数据记录

| 指标 | 今日 | 累计 |
|------|------|------|
| 文章 | 0 | _ |
| 代码提交 | 0 | _ |
| 社媒发布 | 0 | _ |

---

*最后更新: ${TIME}*
EOF
        
        echo -e "${GREEN}✓${NC} 日志已创建: ${WORKLOG}"
    else
        echo -e "${GREEN}✓${NC} 今日日志已存在"
    fi
    echo ""
}

# 5. 今日任务推荐
task_recommendation() {
    echo -e "${YELLOW}🎯 今日任务推荐${NC}"
    echo "─────────────────────────────────────────"
    
    # 基于内容日历推荐
    WEEKDAY=$(date +%u)
    case $WEEKDAY in
        1)
            echo "📅 周一任务: 热点快讯类文章"
            echo "   建议选题: OpenClaw安全/行业动态"
            ;;
        2)
            echo "📅 周二任务: 实战技巧类文章"
            echo "   建议选题: 工具使用/技能教程"
            ;;
        3)
            echo "📅 周三任务: 资源导航类文章"
            echo "   建议选题: 技能盘点/工具推荐"
            ;;
        4)
            echo "📅 周四任务: 深度教程类文章"
            echo "   建议选题: 系统搭建/架构设计"
            ;;
        5)
            echo "📅 周五任务: 案例分享类文章"
            echo "   建议选题: 用户案例/实战经验"
            ;;
        6|7)
            echo "📅 周末任务: 轻松内容/周回顾"
            echo "   建议选题: 热点解读/生态观察"
            ;;
    esac
    
    echo ""
    echo "🔥 高优先级任务:"
    echo "  1. 完成今日文章创作 (阻塞项)"
    echo "  2. 推进产研任务"
    echo "  3. 社媒推广"
    echo ""
}

# 6. 数据看板
data_dashboard() {
    echo -e "${YELLOW}📊 数据看板${NC}"
    echo "─────────────────────────────────────────"
    
    # 内容统计
    TOTAL_ARTICLES=$(find blog/posts -name "*.md" 2>/dev/null | wc -l)
    TOTAL_WORDS=$(find blog/posts -name "*.md" -exec wc -c {} + 2>/dev/null | tail -1 | awk '{print $1}')
    TOTAL_WORDS=$((TOTAL_WORDS / 1000))
    
    echo "内容资产:"
    echo "  文章总数: ${TOTAL_ARTICLES} 篇"
    echo "  累计字数: ~${TOTAL_WORDS}K 字"
    
    # 本月进度
    MONTH_TARGET=30
    MONTH_PROGRESS=$TOTAL_ARTICLES
    MONTH_PERCENT=$((MONTH_PROGRESS * 100 / MONTH_TARGET))
    
    echo ""
    echo "3月进度: ${MONTH_PROGRESS}/${MONTH_TARGET} 篇 (${MONTH_PERCENT}%)"
    
    # 进度条
    PROGRESS_BAR=""
    FILLED=$((MONTH_PERCENT / 5))
    EMPTY=$((20 - FILLED))
    for i in $(seq 1 $FILLED); do PROGRESS_BAR="${PROGRESS_BAR}█"; done
    for i in $(seq 1 $EMPTY); do PROGRESS_BAR="${PROGRESS_BAR}░"; done
    echo "  [${PROGRESS_BAR}]"
    
    echo ""
}

# 7. 阻塞检查
blocker_check() {
    echo -e "${YELLOW}🚨 阻塞检查${NC}"
    echo "─────────────────────────────────────────"
    
    BLOCKERS=0
    
    # 检查今日文章
    if [ ! -f "blog/posts/$(date +%Y-%m-%d)*.md" 2>/dev/null ]; then
        echo -e "${RED}⚠${NC} 今日文章尚未发布"
        BLOCKERS=$((BLOCKERS + 1))
    fi
    
    # 检查Git提交
    if [ -d ".git" ]; then
        TODAY_COMMITS=$(git log --since="midnight" --oneline 2>/dev/null | wc -l)
        if [ "$TODAY_COMMITS" -eq 0 ]; then
            echo -e "${YELLOW}⚠${NC} 今日尚无代码提交"
        fi
    fi
    
    if [ "$BLOCKERS" -eq 0 ]; then
        echo -e "${GREEN}✓${NC} 无阻塞问题，继续推进！"
    else
        echo ""
        echo -e "${RED}共有 ${BLOCKERS} 个阻塞项需要解决${NC}"
    fi
    
    echo ""
}

# 8. 执行建议
execution_advice() {
    echo -e "${YELLOW}💡 执行建议${NC}"
    echo "─────────────────────────────────────────"
    echo "1. 优先完成阻塞项（今日文章）"
    echo "2. 使用 ./scripts/publish.sh 发布文章"
    echo "3. 每完成一项立即更新工作日志"
    echo "4. 晚会前完成Git提交"
    echo ""
    echo -e "${GREEN}🚀 开始执行！${NC}"
}

# 主流程
main() {
    morning_standup
    content_check
    code_check
    create_daily_log
    task_recommendation
    data_dashboard
    blocker_check
    execution_advice
}

main "$@"
