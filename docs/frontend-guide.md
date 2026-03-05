# PowerClaw 前端开发指南

> 基于现代CSS的组件系统、响应式设计和模块化架构

---

## 设计系统概述

### 设计原则

1. **暗黑优先** - 专为深色主题优化的视觉层次
2. **极简主义** - 去除不必要的装饰，专注内容
3. **一致性** - 统一的间距、颜色和交互模式
4. **响应式** - 移动端优先的自适应布局

### 色彩系统

```css
:root {
  /* 背景层级 */
  --bg-primary: #0a0a0a;
  --bg-secondary: #111111;
  --bg-card: #161616;
  --bg-hover: #1c1c1c;
  --bg-elevated: #222222;
  
  /* 文字颜色 */
  --text-primary: #ffffff;
  --text-secondary: #999999;
  --text-muted: #666666;
  --text-disabled: #444444;
  
  /* 边框系统 */
  --border: #2a2a2a;
  --border-light: #333333;
  --border-focus: #555555;
  
  /* 强调色 */
  --accent: #ffffff;
  --accent-secondary: #3b82f6;
  --accent-success: #22c55e;
  --accent-warning: #f59e0b;
  --accent-error: #ef4444;
}
```

### 间距系统

```css
:root {
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 20px;
  --space-6: 24px;
  --space-8: 32px;
  --space-10: 40px;
  --space-12: 48px;
  --space-16: 64px;
  
  --container-max: 1400px;
  --container-padding: 40px;
  --container-padding-mobile: 20px;
}
```

### 字体系统

```css
:root {
  --font-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 
               'Helvetica Neue', Arial, 'Noto Sans SC', sans-serif;
  --font-mono: 'SF Mono', Monaco, 'Cascadia Code', 'Roboto Mono', monospace;
  
  --text-xs: 0.75rem;
  --text-sm: 0.875rem;
  --text-base: 1rem;
  --text-lg: 1.125rem;
  --text-xl: 1.25rem;
  --text-2xl: 1.5rem;
  --text-3xl: 2rem;
  --text-4xl: 2.5rem;
  --text-5xl: 3.5rem;
  
  --font-normal: 400;
  --font-medium: 500;
  --font-semibold: 600;
  --font-bold: 700;
  
  --leading-tight: 1.1;
  --leading-snug: 1.4;
  --leading-normal: 1.6;
  --leading-relaxed: 1.75;
}
```

---

## 组件系统

### 1. 按钮组件 (Button)

```html
<button class="btn btn-primary">主要按钮</button>
<button class="btn btn-secondary">次要按钮</button>
<button class="btn btn-ghost">幽灵按钮</button>
```

```css
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-2);
  padding: var(--space-3) var(--space-5);
  font-size: var(--text-sm);
  font-weight: var(--font-medium);
  border-radius: 0;
  border: 1px solid transparent;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  white-space: nowrap;
}

.btn-primary {
  background: var(--text-primary);
  color: var(--bg-primary);
  border-color: var(--text-primary);
}

.btn-primary:hover {
  background: var(--text-secondary);
  border-color: var(--text-secondary);
  transform: translateY(-1px);
}

.btn-secondary {
  background: var(--bg-card);
  color: var(--text-primary);
  border-color: var(--border);
}

.btn-secondary:hover {
  background: var(--bg-hover);
  border-color: var(--border-light);
}
```

### 2. 卡片组件 (Card)

```html
<div class="card">
  <span class="card-tag">标签</span>
  <h3 class="card-title">卡片标题</h3>
  <p class="card-text">卡片内容描述...</p>
  <div class="card-footer">
    <span class="card-meta">元信息</span>
    <a href="#" class="card-link">查看 →</a>
  </div>
</div>
```

```css
.card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  padding: var(--space-6);
  display: flex;
  flex-direction: column;
  transition: all 0.2s ease;
}

.card:hover {
  border-color: var(--border-light);
  background: var(--bg-hover);
  transform: translateY(-2px);
}

.card-tag {
  display: inline-block;
  padding: var(--space-1) var(--space-2);
  background: var(--bg-primary);
  border: 1px solid var(--border);
  font-size: var(--text-xs);
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: var(--space-4);
  align-self: flex-start;
}

.card-title {
  font-size: var(--text-lg);
  font-weight: var(--font-semibold);
  margin-bottom: var(--space-3);
  line-height: var(--leading-snug);
}

.card-text {
  color: var(--text-secondary);
  font-size: var(--text-sm);
  line-height: var(--leading-relaxed);
  flex: 1;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: var(--space-5);
  padding-top: var(--space-4);
  border-top: 1px solid var(--border);
}
```

### 3. 导航组件

```css
.site-header {
  position: sticky;
  top: 0;
  background: rgba(10, 10, 10, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid var(--border);
  z-index: 100;
}

.main-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 70px;
  max-width: var(--container-max);
  margin: 0 auto;
  padding: 0 var(--container-padding);
}

.nav-menu {
  display: flex;
  gap: var(--space-8);
  list-style: none;
}

.nav-link {
  color: var(--text-secondary);
  text-decoration: none;
  font-size: var(--text-sm);
  font-weight: var(--font-medium);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  transition: color 0.2s;
}

.nav-link:hover,
.nav-link.active {
  color: var(--text-primary);
}
```

### 4. 搜索组件

```css
.search-box {
  position: relative;
  max-width: 700px;
  margin: 0 auto;
}

.search-input {
  width: 100%;
  padding: var(--space-4) var(--space-5);
  padding-left: 50px;
  background: var(--bg-card);
  border: 1px solid var(--border);
  color: var(--text-primary);
  font-size: var(--text-base);
  outline: none;
  transition: all 0.2s;
}

.search-input:focus {
  border-color: var(--border-focus);
}
```

### 5. 标签页组件

```css
.tab-list {
  display: flex;
  gap: var(--space-2);
  flex-wrap: wrap;
  margin-bottom: var(--space-6);
}

.tab {
  padding: var(--space-2) var(--space-4);
  background: transparent;
  border: 1px solid var(--border);
  color: var(--text-secondary);
  font-size: var(--text-sm);
  cursor: pointer;
  transition: all 0.2s;
}

.tab.active {
  background: var(--text-primary);
  color: var(--bg-primary);
  border-color: var(--text-primary);
}
```

---

## 响应式设计

### 断点定义

```css
/* 移动端优先 */
/* 默认: < 640px (手机) */

@media (min-width: 640px) { /* 小屏2列 */ }
@media (min-width: 768px) { /* 平板 */ }
@media (min-width: 1024px) { /* 平板3列 */ }
@media (min-width: 1280px) { /* 桌面4列 */ }
```

### 网格系统

```css
.resource-grid {
  display: grid;
  gap: var(--space-5);
  grid-template-columns: 1fr;
}

@media (min-width: 640px) {
  .resource-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .resource-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (min-width: 1280px) {
  .resource-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}
```

### 移动端优化

```css
@media (pointer: coarse) {
  .btn, .card, .nav-link {
    min-height: 44px;
    min-width: 44px;
  }
}

@media screen and (max-width: 768px) {
  input, select, textarea {
    font-size: 16px;
  }
}
```

---

## 热点展示模块

### 热点卡片组件

```css
.hot-topics {
  margin: var(--space-16) 0;
}

.hot-grid {
  display: grid;
  gap: var(--space-5);
  grid-template-columns: 1fr;
}

@media (min-width: 1024px) {
  .hot-grid {
    grid-template-columns: 1.5fr 1fr;
  }
}

.hot-card {
  background: var(--bg-card);
  border: 1px solid var(--border);
  padding: var(--space-6);
  position: relative;
}

.hot-card-featured::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, #f59e0b, #ef4444, #8b5cf6);
}

.hot-rank {
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-mono);
  font-weight: var(--font-bold);
}

.hot-rank-1 {
  background: linear-gradient(135deg, #f59e0b, #ef4444);
  color: white;
}

.hot-trend.up {
  background: rgba(34, 197, 94, 0.1);
  color: var(--accent-success);
}
```

### 轮播组件

```css
.carousel {
  position: relative;
  overflow: hidden;
  background: var(--bg-card);
  border: 1px solid var(--border);
}

.carousel-track {
  display: flex;
  transition: transform 0.5s ease;
}

.carousel-slide {
  flex: 0 0 100%;
  position: relative;
}

.carousel-caption {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: var(--space-6);
  background: linear-gradient(transparent, rgba(0,0,0,0.9));
}
```

---

## 变现组件

### 变现机会卡片

```css
.monetization {
  margin: var(--space-16) 0;
}

.monetization-grid {
  display: grid;
  gap: var(--space-5);
  grid-template-columns: 1fr;
}

@media (min-width: 1024px) {
  .monetization-grid {
    grid-template-columns: 1.2fr 1fr;
  }
}

.opp-card-featured::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: linear-gradient(90deg, #22c55e, #3b82f6);
}

.opp-metrics {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-4);
  padding: var(--space-4);
  background: var(--bg-secondary);
}

.metric-value {
  color: var(--accent-success);
  font-size: var(--text-lg);
  font-weight: var(--font-bold);
}
```

### 收益计算器

```html
<div class="earnings-calculator">
  <h3 class="calc-title">收益估算器</h3>
  <div class="calc-form">
    <div class="calc-field">
      <label>每日投入时间</label>
      <input type="range" min="0.5" max="8" step="0.5" value="2" id="timeRange">
      <span id="timeValue">2</span> 小时
    </div>
  </div>
  <div class="calc-result">
    <div class="result-item">
      <span>预估月收益</span>
      <span id="monthlyEarnings">$1,000</span>
    </div>
  </div>
</div>
```

```javascript
class EarningsCalculator {
  constructor() {
    this.timeRange = document.getElementById('timeRange');
    this.rateRange = document.getElementById('rateRange');
    this.daysRange = document.getElementById('daysRange');
    this.init();
  }
  
  init() {
    [this.timeRange, this.rateRange, this.daysRange].forEach(input => {
      input.addEventListener('input', () => this.calculate());
    });
  }
  
  calculate() {
    const hours = parseFloat(this.timeRange.value);
    const rate = parseFloat(this.rateRange.value);
    const days = parseFloat(this.daysRange.value);
    const monthly = hours * rate * days;
    document.getElementById('monthlyEarnings').textContent = `$${monthly.toLocaleString()}`;
  }
}
```

---

## JavaScript 交互

### 搜索功能

```javascript
class SearchComponent {
  constructor() {
    this.input = document.querySelector('.search-input');
    this.dropdown = document.querySelector('.search-dropdown');
    this.init();
  }
  
  init() {
    document.addEventListener('keydown', (e) => {
      if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
        e.preventDefault();
        this.input.focus();
      }
    });
    
    this.input.addEventListener('input', (e) => {
      this.handleSearch(e.target.value);
    });
  }
  
  handleSearch(query) {
    if (!query) {
      this.dropdown.classList.remove('active');
      return;
    }
    this.dropdown.classList.add('active');
  }
}
```

### 标签页切换

```javascript
class TabsComponent {
  constructor(container) {
    this.container = container;
    this.tabs = container.querySelectorAll('.tab');
    this.panels = container.querySelectorAll('.tab-panel');
    this.init();
  }
  
  init() {
    this.tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        const targetTab = tab.dataset.tab;
        this.tabs.forEach(t => t.classList.toggle('active', t.dataset.tab === targetTab));
        this.panels.forEach(p => p.classList.toggle('active', p.dataset.panel === targetTab));
      });
    });
  }
}
```

### 轮播组件

```javascript
class Carousel {
  constructor(element) {
    this.carousel = element;
    this.track = element.querySelector('.carousel-track');
    this.slides = element.querySelectorAll('.carousel-slide');
    this.currentSlide = 0;
    this.autoplayDelay = parseInt(element.dataset.autoplay) || 5000;
    this.init();
  }
  
  init() {
    this.startAutoplay();
    this.carousel.addEventListener('mouseenter', () => this.stopAutoplay());
    this.carousel.addEventListener('mouseleave', () => this.startAutoplay());
  }
  
  goTo(index) {
    this.slides[this.currentSlide].classList.remove('active');
    this.currentSlide = index;
    this.slides[this.currentSlide].classList.add('active');
    this.track.style.transform = `translateX(-${this.currentSlide * 100}%)`;
  }
  
  startAutoplay() {
    this.autoplayTimer = setInterval(() => {
      this.goTo((this.currentSlide + 1) % this.slides.length);
    }, this.autoplayDelay);
  }
  
  stopAutoplay() {
    clearInterval(this.autoplayTimer);
  }
}
```

---

## 文件结构

```
powerclaw/
├── index.html              # 主页
├── css/
│   ├── variables.css       # CSS 变量
│   ├── base.css           # 基础样式
│   ├── components.css     # 组件样式
│   ├── sections.css       # 页面区块样式
│   └── responsive.css     # 响应式样式
├── js/
│   ├── components/
│   │   ├── search.js      # 搜索组件
│   │   ├── tabs.js        # 标签页组件
│   │   ├── carousel.js    # 轮播组件
│   │   └── calculator.js  # 计算器组件
│   └── app.js             # 主入口
└── docs/
    └── frontend-guide.md  # 本指南
```

---

## 性能优化

```css
/* 使用 content-visibility 优化长列表 */
.resource-grid > * {
  content-visibility: auto;
  contain-intrinsic-size: 0 200px;
}

/* 减少重绘 */
.card {
  will-change: transform;
  transform: translateZ(0);
}

/* prefers-reduced-motion */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

---

## 更新日志

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0  | 2025-03-01 | 初始版本，包含完整组件系统和响应式设计规范 |

---

> 本文档持续更新，如有问题请联系开发团队。
