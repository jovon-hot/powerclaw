# PowerClaw CMS系统技术设计方案

**文档版本**: v1.0  
**日期**: 2026-03-02  
**设计人**: 技术负责人  
**状态**: 待审批

---

## 1. 方案选型

### 1.1 选型结论: Headless CMS

经过综合评估，推荐采用 **Headless CMS + 自研发布管道** 的混合架构。

**决策依据**:
- ✅ 开发周期短 (2-4周上线)
- ✅ 功能完善，开箱即用
- ✅ 支持API驱动，便于自动发布集成
- ✅ 成本可控 (免费-低费用)
- ✅ 未来可平滑迁移到自研系统

### 1.2 CMS选型对比

| CMS | 类型 | 成本 | 自托管 | API | 推荐度 |
|-----|------|------|--------|-----|--------|
| **Strapi** | Node.js | 免费 | ✅ | REST/GraphQL | ⭐⭐⭐⭐⭐ |
| **Directus** | Node.js | 免费 | ✅ | REST/GraphQL | ⭐⭐⭐⭐⭐ |
| **KeystoneJS** | Node.js | 免费 | ✅ | GraphQL | ⭐⭐⭐⭐ |
| **Ghost** | Node.js | $9/月 | ❌ | REST | ⭐⭐⭐ |
| **Sanity** | SaaS | $99/月 | ❌ | REST | ⭐⭐⭐ |
| **Contentful** | SaaS | $489/月 | ❌ | REST | ⭐⭐ |

### 1.3 最终推荐: Directus

**选择理由**:
1. **完全开源免费** - Apache 2.0协议，无功能限制
2. **现代化技术栈** - Vue3 + Node.js + TypeScript
3. **强大API** - REST和GraphQL双支持
4. **直观界面** - 非技术人员友好
5. **灵活数据模型** - 支持复杂内容结构
6. **活跃社区** - 持续更新维护

---

## 2. 技术栈选择

### 2.1 整体架构

```
┌─────────────────────────────────────────────────────────────┐
│                     内容消费层                               │
├─────────────┬─────────────┬─────────────┬───────────────────┤
│  GitHub     │   Twitter   │   Mirror    │     Reddit        │
│   Pages     │      X      │             │                   │
└──────┬──────┴──────┬──────┴──────┬──────┴─────────┬─────────┘
       │             │             │                │
       └─────────────┴─────────────┴────────────────┘
                              │
                    ┌─────────▼──────────┐
                    │   发布管道(Pipeline) │
                    │   (自研Node.js)     │
                    └─────────┬──────────┘
                              │
                    ┌─────────▼──────────┐
                    │   Directus CMS     │
                    │   (内容管理中心)    │
                    └────────────────────┘
```

### 2.2 核心技术栈

| 层级 | 技术 | 版本 | 说明 |
|------|------|------|------|
| **CMS核心** | Directus | v10+ | 开源Headless CMS |
| **数据库** | PostgreSQL | 15+ | 主数据库 |
| **缓存** | Redis | 7+ | 会话缓存、API缓存 |
| **前端(可选)** | Next.js | 14+ | 如需自建前端 |
| **发布管道** | Node.js | 20+ | 自动发布服务 |
| **部署** | Docker + Coolify | - | 容器化部署 |
| **托管** | Hetzner/Vultr | - | VPS服务器 |

### 2.3 部署架构

```yaml
# docker-compose.yml 概览
services:
  directus:
    image: directus/directus:latest
    ports:
      - "8055:8055"
    environment:
      - DB_CLIENT=pg
      - DB_HOST=database
      - CACHE_ENABLED=true
      - CACHE_STORE=redis
    
  database:
    image: postgres:15-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data
      
  redis:
    image: redis:7-alpine
    
  publish-pipeline:
    build: ./publish-pipeline
    environment:
      - DIRECTUS_URL=http://directus:8055
      - TWITTER_API_KEY=${TWITTER_API_KEY}
      - MIRROR_API_KEY=${MIRROR_API_KEY}
```

---

## 3. 数据模型设计

### 3.1 内容类型定义

```typescript
// Content Model - 文章
interface Article {
  id: string;
  status: 'draft' | 'published' | 'archived';
  title: string;
  slug: string;
  summary: string;
  content: string;           // Markdown
  cover_image: string;       // Directus file ID
  author: Author;            // 关系字段
  tags: Tag[];              // 多对多关系
  category: Category;        // 一对多关系
  
  // SEO字段
  meta_title: string;
  meta_description: string;
  keywords: string[];
  
  // 发布控制
  publish_at: Date;
  unpublish_at: Date | null;
  
  // 分发配置
  distribution: {
    github_pages: boolean;
    twitter: boolean;
    mirror: boolean;
    reddit: boolean;
    reddit_subreddit?: string;
  };
  
  // 统计
  view_count: number;
  created_at: Date;
  updated_at: Date;
}

// Author Model - 作者
interface Author {
  id: string;
  name: string;
  bio: string;
  avatar: string;
  social: {
    twitter?: string;
    github?: string;
    mirror?: string;
  };
}

// Tag Model - 标签
interface Tag {
  id: string;
  name: string;
  slug: string;
  color: string;
}

// Category Model - 分类
interface Category {
  id: string;
  name: string;
  slug: string;
  description: string;
  sort_order: number;
}
```

### 3.2 Directus Collection结构

```
collections/
├── articles/              # 文章
│   ├── fields/
│   │   ├── title (string)
│   │   ├── slug (string, unique)
│   │   ├── content (wysiwyg/markdown)
│   │   ├── status (dropdown)
│   │   ├── author (M2O -> authors)
│   │   ├── tags (M2M -> tags)
│   │   ├── category (M2O -> categories)
│   │   ├── cover_image (file)
│   │   ├── publish_at (datetime)
│   │   └── distribution (json)
│   └── permissions/
│       ├── admin: full
│       ├── editor: create, read, update
│       └── viewer: read
│
├── authors/               # 作者
├── categories/            # 分类
├── tags/                  # 标签
└── publish_logs/          # 发布日志
    ├── article (M2O)
    ├── platform (string)
    ├── status (string)
    ├── published_url (string)
    └── published_at (datetime)
```

---

## 4. 开发工作量评估

### 4.1 任务分解

| 阶段 | 任务 | 工作量 | 负责人 |
|------|------|--------|--------|
| **Phase 1** | **基础设施搭建** | **1周** | |
| | VPS服务器采购和配置 | 0.5天 | DevOps |
| | Docker环境搭建 | 1天 | DevOps |
| | Directus安装和配置 | 1天 | 后端 |
| | 数据库和Redis配置 | 0.5天 | DevOps |
| | 域名和SSL配置 | 1天 | DevOps |
| | CI/CD流水线 | 1天 | DevOps |
| **Phase 2** | **CMS配置** | **1周** | |
| | Collection设计实现 | 2天 | 后端 |
| | 字段和关系配置 | 1天 | 后端 |
| | 权限角色配置 | 1天 | 后端 |
| | 界面定制(Logo/主题) | 1天 | 前端 |
| | 数据迁移脚本 | 2天 | 后端 |
| **Phase 3** | **发布管道开发** | **2周** | |
| | 发布服务框架搭建 | 2天 | 后端 |
| | GitHub Pages发布模块 | 2天 | 后端 |
| | Twitter/X API集成 | 2天 | 后端 |
| | Mirror.xyz API集成 | 2天 | 后端 |
| | Reddit API集成 | 2天 | 后端 |
| | 发布日志和监控 | 2天 | 后端 |
| | Webhook触发机制 | 2天 | 后端 |
| **Phase 4** | **测试和上线** | **1周** | |
| | 功能测试 | 2天 | QA |
| | 性能测试 | 1天 | QA |
| | 安全审计 | 1天 | 后端 |
| | 文档编写 | 2天 | 全员 |
| | 团队培训 | 1天 | 全员 |
| | 正式上线 | 1天 | DevOps |

### 4.2 工作量汇总

```
总工期: 5周 (25工作日)
人力投入:
  - 后端开发: 15天
  - DevOps: 7天
  - 前端: 1天
  - QA: 3天

总工时: 26人天
并行人数: 2-3人
```

### 4.3 成本估算

| 项目 | 月费用 | 年费用 | 说明 |
|------|--------|--------|------|
| **VPS服务器** | $12 | $144 | Hetzner CX21 (4GB RAM) |
| **对象存储** | $5 | $60 | 图片/文件存储 |
| **备份存储** | $2 | $24 | 数据库备份 |
| **域名** | - | $12 | 如需要独立域名 |
| **监控服务** | $0 | $0 | Uptime Kuma (开源) |
| **Directus** | $0 | $0 | 开源免费 |
| **总计** | **~$19** | **~$240** | |

**一次性开发成本**:
- 内部开发: 26人天 × $500/天 = $13,000
- 外包开发: $8,000 - $15,000

---

## 5. 部署方案

### 5.1 服务器规格

```yaml
# 推荐配置 - 初期阶段
provider: Hetzner Cloud (欧洲) 或 Vultr (美国)
location: 根据用户分布选择

server:
  type: CX21 (Hetzner) 或 $12/mo (Vultr)
  cpu: 2 vCPU
  ram: 4 GB
  disk: 40 GB SSD
  os: Ubuntu 22.04 LTS

# 扩展路径
scaling:
  stage1: 当前配置 (0-1000日PV)
  stage2: 升级到 8GB RAM (1000-5000日PV)
  stage3: 增加CDN + 数据库分离 (5000+日PV)
```

### 5.2 部署流程

```bash
# 1. 服务器初始化
ssh root@server
apt update && apt upgrade -y
apt install -y docker.io docker-compose git nginx

# 2. 克隆项目
git clone https://github.com/powerclaw/cms-infra.git
cd cms-infra

# 3. 环境配置
cp .env.example .env
# 编辑 .env 填入密钥

# 4. 启动服务
docker-compose up -d

# 5. 初始化Directus
docker-compose exec directus npx directus bootstrap

# 6. 配置Nginx反向代理
# 见 nginx.conf 配置

# 7. 启用SSL (Let's Encrypt)
certbot --nginx -d cms.powerclaw.io
```

### 5.3 备份策略

```yaml
# 每日自动备份
backup:
  database:
    frequency: daily at 2 AM
    retention: 30 days
    destination: S3-compatible storage
    
  files:
    frequency: daily at 3 AM
    retention: 30 days
    includes:
      - uploads/
      - extensions/
      
  disaster_recovery:
    rto: 4 hours    # 恢复时间目标
    rpo: 24 hours   # 恢复点目标
```

### 5.4 监控告警

```yaml
monitoring:
  uptime:
    tool: Uptime Kuma (self-hosted)
    checks:
      - CMS API endpoint
      - Website homepage
      - Database connectivity
    
  alerts:
    channels:
      - Email
      - Telegram (可选)
      - Discord (可选)
    triggers:
      - Service down > 2 minutes
      - Disk usage > 80%
      - Memory usage > 90%
```

---

## 6. 安全方案

### 6.1 访问控制

```
Directus用户角色:
├── Administrator (管理员)
│   └── 所有权限
├── Editor (编辑)
│   ├── articles: create, read, update
│   ├── authors: read
│   └── publish_logs: read
└── Viewer (访客)
    └── articles: read (仅已发布)

安全措施:
├── 强密码策略
├── 2FA双因素认证
├── IP白名单(可选)
├── API速率限制
└── 操作审计日志
```

### 6.2 API安全

```yaml
security:
  authentication: JWT tokens
  token_expiry: 15 minutes (access) / 7 days (refresh)
  
  rate_limiting:
    public: 100 requests/minute
    authenticated: 1000 requests/minute
    
  cors:
    allowed_origins:
      - https://powerclaw.io
      - https://cms.powerclaw.io
```

---

## 7. 迁移计划

### 7.1 内容迁移

```python
# 迁移脚本伪代码
# migrate.py

def migrate_content():
    # 1. 读取现有Markdown文件
    md_files = glob("docs/**/*.md")
    
    # 2. 解析Frontmatter
    for file in md_files:
        content = parse_markdown(file)
        
        # 3. 创建Directus记录
        article = {
            'title': content.frontmatter.title,
            'content': content.body,
            'slug': generate_slug(content.frontmatter.title),
            'status': 'published',
            'publish_at': content.frontmatter.date,
            'tags': migrate_tags(content.frontmatter.tags),
        }
        
        # 4. 上传到Directus
        directus.create('articles', article)
        
    print(f"迁移完成: {len(md_files)} 篇文章")
```

### 7.2 切换计划

```
第1周: 并行运行
├── Directus部署和配置
├── 内容迁移
└── 原有GitHub Pages保持运行

第2周: 灰度测试
├── 内部团队使用Directus
├── 发布管道测试
└── 问题修复

第3周: 正式发布
├── 更新DNS指向新站点(如需要)
├── 停用旧发布流程
└── 团队培训完成
```

---

## 8. 附录

### 8.1 参考链接

- Directus文档: https://docs.directus.io/
- Twitter API: https://developer.twitter.com/en/docs/twitter-api
- Mirror API: https://docs.mirror.xyz/
- Reddit API: https://www.reddit.com/dev/api/

### 8.2 技术决策记录

| 日期 | 决策 | 理由 |
|------|------|------|
| 2026-03-02 | 选择Directus | 开源免费，功能完善，社区活跃 |
| 2026-03-02 | 自研发布管道 | 需要自定义多平台发布逻辑 |
| 2026-03-02 | Hetzner VPS | 性价比最高，欧洲/美国可选 |

---

**下一步**: 等待CEO审批后，立即启动Phase 1基础设施搭建。

---
*PowerClaw 技术团队 | 2026-03-02*
