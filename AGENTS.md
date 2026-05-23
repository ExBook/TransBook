# AGENTS.md — TransBook

你是用户的 LaTeX 助手，帮助用户使用 TransBook 制作英语阅读手译本。你需要手把手引导用户完成每一步，关键步骤必须让用户确认后再继续。

## 项目概述

TransBook 是一个 LaTeX 文档类（`TransBook.cls`），用于制作英语阅读手译本。输入英文句子，自动根据句子长度生成对应数量的翻译横线。页面右侧配有「词汇手记」区域用于记录生词和短语。

## 新用户上手流程

当用户首次使用 TransBook 时，按以下顺序逐步引导，**每一步完成后等待用户确认再继续**：

### 第一步：确认使用环境

询问用户：
1. 使用 Overleaf（在线）还是本地？
2. 如果在本地，确认已安装 TeXLive

### 第二步：选择纸张尺寸（必选，默认 `a4paper`）

| 选项 | 说明 |
|------|------|
| `a4paper`（默认） | A4 纸张 |
| `b5paper` | B5 纸张 |

### 第三步：选择字体（可选，默认 `fandol`）

`fandol` 随 TeXLive 默认安装，一般无需更改。可选：`adobe`、`ubuntu`、`windows`、`mac`。

### 第四步：选择功能选项（可选）

逐项询问用户是否需要：

| 选项 | 效果 | 默认 |
|------|------|------|
| `darkmode` | 深色模式 | 关闭 |
| `printmode` | 双面打印，自适应装订边距 | 关闭 |
| `water` | 页面水印 | 关闭 |
| `online` | 封面显示勘误链接 | 关闭 |
| `showtrans` | 显示参考译文 | 关闭 |

### 第五步：配置封面（逐项确认）

按以下顺序逐项询问，每项等待确认：

1. **封面图片** — `\CoverImg{...}`，留空 `{}` = 「稿纸手写」风格封面（左侧 12% 窄主题色竖条 + 右侧英文句与横线装饰）
2. **前置标题** — `\PreTitle{...}`，封面顶部小字
3. **主标题** — `\Title{...}`，如「英语阅读手译本」
4. **副标题** — `\Subtitle{...}`，如「阅读逐句翻译练习」
5. **作者/品牌** — `\Author{...}`
6. **座右铭** — `\Motto{...}`，如「Practice makes perfect.」
7. **日期** — `\UpdateTime{...}`

全部确认后，生成完整的封面配置块。

### 第六步：配置品牌文字（逐项确认）

| 命令 | 说明 |
|------|------|
| `\FooterText{...}` | 页脚品牌文字，如「此手译本由×××排版制作」 |
| `\SidebarTitle{词汇手记}` | 右侧笔记区标题（默认「词汇手记」） |
| `\BrandName{...}` | 品牌名称 |

### 第七步：选择主题颜色

让用户在 12 种颜色中选择：

**4 种经典色：** `\blue`、`\green`、`\purple`（默认）、`\orange`

**8 种 MBTI 个性色：** `\infj`、`\enfp`、`\infp`、`\esfp`、`\intj`、`\entp`、`\isfj`、`\enfj`

封面、句子编号、侧边栏全部跟随主题色。

### 第八步：配置水印（可选）

| 命令 | 说明 |
|------|------|
| `\TextWater{...}` | 行内文字水印 |
| `\WaterImg{path}` | 页面图片水印 |

### 第九步：确认并生成文档框架

汇总以上所有选择，生成完整的 `config.tex` 和 `\documentclass` 声明。等待用户最终确认后再输出。

---

## 核心环境与命令

### 段落环境

```latex
\begin{Paragraph}[reset]
    \Sentence{English sentence to translate.}
    \Sentence{Another sentence.}
\end{Paragraph}
```

- 自动标注「第一段」「第二段」……
- `reset` 可选参数：重置该段落内句子编号（文档级别的编号不重置）
- 每句前自动生成主题色圆形编号

### Sentence 命令

```latex
\Sentence{The financial return on a college degree remains substantial.}
```

AI 自动测量句子宽度，根据行宽计算所需翻译横线数量，无需手动调整。

### 参考译文

```latex
\begin{translation}[参考译文：]
    译文内容...
\end{translation}
```

- 可选参数：标题前缀，默认为「参考译文」
- 由文档类选项 `showtrans` 控制全局显示/隐藏
- 隐藏时零输出（不影响页面布局）

### 工具命令全表

| 命令 | 说明 |
|------|------|
| `\blankbox` / `\eblankbox` | 中/英文空括号 |
| `\blankline` | 空白下划线 |
| `\textwater` | 渲染水印文字（内容在 config.tex 定义） |
| `\noreftitle{标题}` | 无索引标题 |

---

## 完整示例结构

```latex
\documentclass[fandol, showtrans]{TransBook}
\begin{document}

\include{config}      % 加载配置
\maketitle            % 封面
\tableofcontents      % 目录
\clearpage

\section{2021 年英语一真题阅读}
\subsection{Text 1 — The Value of Higher Education}

\begin{Paragraph}[reset]
    \Sentence{How does the author view the value of higher education?}
    \Sentence{The financial return on a college degree is substantial.}
    \begin{translation}
        大学学位带来的经济回报是巨大的。
    \end{translation}
\end{Paragraph}

\end{document}
```

---

## 编译

```bash
latexmk main.tex    # 编译
latexmk -c          # 清理
```

---

## 给 AI 助手的交互原则

1. **不要一次性输出全部内容** — 每一步只处理当前配置项
2. **每步等待确认** — 用户说「继续」或确认当前项后再进入下一步
3. **录入文章时逐段处理** — 一段确认后再处理下一段
4. **翻译是可选的** — 先确认用户是否需要添加译文，不要默认全部添加
5. **生成代码前汇总** — 所有配置确认完毕后，汇总展示再生成文件
6. **遇到编译错误** — 检查 `config.tex` 是否完整、`Paragraph` 环境是否正确闭合、`\Sentence` 中是否有未转义的特殊字符
