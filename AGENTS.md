# AGENTS.md — TransBook

## 项目概述

TransBook 是一个 LaTeX 文档类（`.cls`），用于制作英语阅读手译本。输入英文句子，自动根据句子长度生成对应数量的翻译横线，页面右侧配有「词汇手记」区域。

## 文件结构

```
TransBook/
├── TransBook.cls            # 文档类文件（核心）
├── config.tex               # 用户配置文件
├── .latexmkrc               # latexmk 编译配置
├── main.tex                 # 示例主文档
├── main.pdf                 # 编译结果预览
└── img/                     # 封面图、水印图（可选）
```

## 文档类选项

调用方式：`\documentclass[选项1, 选项2]{TransBook}`

| 类别 | 选项 | 说明 |
|------|------|------|
| 纸张 | `a4paper`（默认）, `b5paper` | 纸张尺寸 |
| 字体 | `fandol`（推荐）, `adobe`, `ubuntu`, `windows`, `mac` | 中文字体集 |
| 功能 | `darkmode`, `printmode`, `water`, `online`, `showtrans` | 深色模式、打印、水印、显示译文 |

## 核心环境与命令

### 段落与句子
```latex
\begin{Paragraph}[reset]        % reset 可选：重置该段落内句子编号
    \Sentence{English sentence to translate.}
    \Sentence{Another sentence.}
\end{Paragraph}
```

- `Paragraph` 环境 — 自动标注「第一段」「第二段」……
- `\Sentence{...}` — 自动测量句子宽度，生成对应行数的翻译横线
- 每句前自动生成主题色圆形编号

### 参考译文
```latex
\begin{translation}[参考译文：]   % 可选参数：标题前缀
    此处填写译文内容...
\end{translation}
```

- 由 `showtrans` 文档类选项控制全局显示/隐藏
- 隐藏时零输出（box0 吞咽技术，不影响页面布局）

## 封面配置（config.tex）

```latex
\Title{英语阅读手译本}           % 主标题
\Subtitle{阅读逐句翻译练习}      % 副标题
\Author{研小布}                  % 作者/品牌
\Motto{Practice makes perfect.}  % 座右铭
\UpdateTime{2026.05}             % 日期
```

封面为「稿纸手写」风格：左侧 12% 窄主题色竖条 + 右侧英文例句与翻译横线装饰。

## 品牌文字（config.tex）

```latex
\FooterText{此手译本由公众号【研小布】排版制作}
\SidebarTitle{词汇手记}
\BrandName{研小布}
```

- 页面右侧约 60mm 宽的「词汇手记」区域
- 浅色填充 + 主题色左边界线

## 颜色主题（config.tex）

```latex
\setThemeColor{\purple}  % 12 色可选（4 经典 + 8 MBTI）
```

封面、句子编号、侧边栏全部跟随主题色。

## 工具命令

- `\blankbox` / `\eblankbox` — 中/英文空括号
- `\blankline` — 空白下划线
- `\textwater` — 渲染水印文字
- `\noreftitle{标题}` — 无索引标题

## 编译

```bash
latexmk main.tex    # 编译
latexmk -c          # 清理
```

## AI 辅助用户的常见任务

1. **帮用户录入文章** — 将英语阅读文章按句子拆分为 `\Sentence{}` 格式
2. **添加参考译文** — 为每个句子或段落添加 `translation` 环境
3. **配置品牌和封面** — 编辑 config.tex 设置品牌文字、标题、主题色
4. **调整译文显示** — 切换 `showtrans` 选项控制译文显隐
5. **切换纸张格式** — A4 ↔ B5
