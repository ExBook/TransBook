<div align="center">
  <img src="./logo.svg" alt="TransBook" width="400">
</div>

# TransBook — 考研英语阅读手译本 LaTeX 文档类

**输入英文句子，自动生成翻译空白横线。右侧「词汇手记」区域，边译边记生词。**

---

## 功能特点

1. **智能横线生成**：输入一句英文，自动根据句子长度计算所需翻译横线数量
2. **段落分组**：`Paragraph` 环境自动标注「第一段」「第二段」...
3. **带圈编号**：每句前面自动生成主题色圆形编号
4. **词汇手记区**：页面右侧约 60mm 宽的笔记区域，用于记录生词和短语
5. **参考译文**：可选的译文对照功能，一键显示/隐藏
6. **「稿纸手写」风格封面**：左侧主题色竖条 + 右侧英文句与横线装饰
7. **12 种颜色主题**：4 种经典 + 8 种 MBTI 个性色
8. **支持 A4 / B5**：文档类选项切换
9. **深色模式**：全局暗色主题
10. **外部配置**：`config.tex` 一键修改品牌文字、主题色、水印等

---

## 快速开始

```bash
# 编译
latexmk main.tex

# 或直接使用 xelatex
xelatex main.tex

# 清理
latexmk -c
```

---

## 文档类选项

| 选项 | 默认 | 说明 |
|------|------|------|
| `a4paper` / `b5paper` | a4paper | 纸张尺寸 |
| `adobe` / `ubuntu` / `mac` / `windows` / `fandol` | fandol | 中文字体集 |
| `printmode` | false | 双面打印 + 装订边距 |
| `online` | false | 封面显示勘误链接 |
| `water` | false | 页面水印 |
| `darkmode` | false | 深色模式 |
| `showtrans` | false | 显示参考译文 |

---

## 配置说明

所有配置在 `config.tex` 中完成：

```latex
% 封面
\Title{考研英语手译本}
\Subtitle{阅读逐句翻译练习}
\Author{研小布}

% 主题色（12 种可选）
\setThemeColor{\orange}

% 品牌文字
\FooterText{此手译本由公众号【研小布】排版制作}
\SidebarTitle{词汇手记}
\BrandName{研小布}
```

---

## 命令参考

### 段落与句子

```latex
\begin{Paragraph}[reset]       % reset 可选：重置该段落句子编号
    \Sentence{English sentence to translate.}
    \Sentence{Another sentence.}
\end{Paragraph}
```

### 参考译文

```latex
\begin{translation}[参考译文：]   % 可选参数：标题前缀
    此处填写译文内容...
\end{translation}
```

用 `showtrans` 文档类选项控制全局显示/隐藏。

### 工具命令

| 命令 | 说明 |
|------|------|
| `\blankbox` / `\eblankbox` | 中文/英文空括号 |
| `\blankline` | 空白下划线 |
| `\textwater` | 渲染水印文字 |
| `\noreftitle{标题}` | 无索引标题 |

---

## 项目结构

```
TransBook/
├── TransBook.cls          # 类文件
├── config.tex             # 用户配置
├── .latexmkrc             # 编译配置
├── README.md              # 本文档
├── main.tex               # 示例文档
└── img/                   # 图片（可选）
    ├── cover.jpg
    └── water.png
```

---

## 许可证

MIT License