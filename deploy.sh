#!/bin/bash
# PowerClaw 一键部署脚本

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           🚀 PowerClaw GitHub Pages 部署脚本                  ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

cd ~/.openclaw/workspace/powerclaw

echo "📋 部署步骤:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "由于 GitHub Token 权限限制，请手动执行以下步骤:"
echo ""

echo "步骤 1: 在 GitHub 上创建仓库"
echo "────────────────────────────────────────────────────────────────"
echo "1. 访问: https://github.com/new"
echo "2. 仓库名: powerclaw"
echo "3. 选择 Public (公开)"
echo "4. 点击 'Create repository'"
echo ""

echo "步骤 2: 推送代码到 GitHub"
echo "────────────────────────────────────────────────────────────────"
echo "运行以下命令:"
echo ""
echo "  cd ~/.openclaw/workspace/powerclaw"
echo "  git remote add origin https://github.com/jovon-hot/powerclaw.git"
echo "  git push -u origin main"
echo ""

echo "步骤 3: 启用 GitHub Pages"
echo "────────────────────────────────────────────────────────────────"
echo "1. 访问: https://github.com/jovon-hot/powerclaw/settings/pages"
echo "2. Source 选择: GitHub Actions"
echo "3. 点击 Save"
echo ""

echo "步骤 4: 验证部署"
echo "────────────────────────────────────────────────────────────────"
echo "等待几分钟后访问:"
echo "  https://jovon-hot.github.io/powerclaw/"
echo ""

echo "📁 项目文件已准备在:"
echo "  ~/.openclaw/workspace/powerclaw/"
echo ""

echo "✅ 项目内容包括:"
echo "  • index.html - 主页面"
echo "  • docs/ - 文档目录"
echo "  • .github/workflows/deploy.yml - 自动部署"
echo ""

echo "🎨 网站特色:"
echo "  • 现代化的响应式设计"
echo "  • OpenClaw 使用技巧"
echo "  • 自动化工作流案例"
echo "  • 实战教程"
echo ""
