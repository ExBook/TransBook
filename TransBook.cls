\def\fileversion{2.0}
\def\filedate{2026/05/17}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{TransBook}[\filedate\space Version \fileversion\space by MA WEI JIAN]

% ============================================================
% TransBook —— 考研英语阅读手译本 LaTeX 文档类
%
% 核心功能：输入英文句子，自动根据长度生成空白翻译横线。
% 右侧留出「词汇手记」区域用于生词笔记。
% ============================================================

% ============================================================
% Section 1 : 文档类选项
% ============================================================

% --- 字体集 ---
\newcommand\@fontset{fandol}
\DeclareOption{adobe}{\renewcommand\@fontset{adobe}}
\DeclareOption{ubuntu}{\renewcommand\@fontset{ubuntu}}
\DeclareOption{mac}{\renewcommand\@fontset{mac}}
\DeclareOption{windows}{\renewcommand\@fontset{windows}}
\DeclareOption{fandol}{\renewcommand\@fontset{fandol}}

% --- 布尔选项 ---
\newif\if@printmode  \@printmodefalse
\DeclareOption{printmode}{\@printmodetrue}

\newif\if@online  \@onlinefalse
\DeclareOption{online}{\@onlinetrue}

\newif\if@water  \@waterfalse
\DeclareOption{water}{\@watertrue}

\newif\if@darkmode  \@darkmodefalse
\DeclareOption{darkmode}{\@darkmodetrue}

\newif\if@showtrans  \@showtransfalse
\DeclareOption{showtrans}{\@showtranstrue}

% --- 纸张 ---
\newcommand\@papersize{a4paper}
\DeclareOption{a4paper}{\def\@papersize{a4paper}}
\DeclareOption{b5paper}{\def\@papersize{b5paper}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

% ============================================================
% Section 2 : 加载宏包
% ============================================================
\RequirePackage[fontset=\@fontset, punct=kaiming]{ctex}
\RequirePackage{xcolor,graphicx}
\RequirePackage{geometry,fancyhdr}
\RequirePackage{calc}
\RequirePackage{setspace}
\RequirePackage{tikz}
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable,skins}
\RequirePackage{environ}
\RequirePackage{titletoc,titlesec}
\RequirePackage{pifont}
\RequirePackage{ifthen}
\RequirePackage{lastpage}
\RequirePackage{fontspec}
\RequirePackage{hyperref}
\RequirePackage{pgfmath}
\RequirePackage{xkeyval}

\usetikzlibrary{fadings,shapes,positioning}

% ============================================================
% Section 3 : 深色模式基础设置
% ============================================================
\definecolor{bg}{HTML}{212121}

\if@darkmode
    \hypersetup{colorlinks=true, linkcolor=white, urlcolor=white!61.8, citecolor=white!61.8}
\else
    \hypersetup{colorlinks=true, linkcolor=black, urlcolor=themeColor, citecolor=red}
\fi

% ============================================================
% Section 4 : 主题颜色系统（12 色查表法）
% ============================================================
\newcommand{\blue}{blue}
\newcommand{\green}{green}
\newcommand{\purple}{purple}
\newcommand{\orange}{orange}
\newcommand{\infj}{infj}
\newcommand{\enfp}{enfp}
\newcommand{\infp}{infp}
\newcommand{\esfp}{esfp}
\newcommand{\intj}{intj}
\newcommand{\entp}{entp}
\newcommand{\isfj}{isfj}
\newcommand{\enfj}{enfj}

\def\themeColor@blue{015697}
\def\themeColor@green{01847c}
\def\themeColor@purple{61589b}
\def\themeColor@orange{EA4C0E}
\def\themeColor@infj{3b4676}
\def\themeColor@enfp{d58a05}
\def\themeColor@infp{3b6079}
\def\themeColor@esfp{d86b09}
\def\themeColor@intj{38558f}
\def\themeColor@entp{8c2b2b}
\def\themeColor@isfj{4d417e}
\def\themeColor@enfj{e15715}

\newcommand{\setThemeColor}[1]{%
    \ifcsname themeColor@#1\endcsname
        \definecolor{themeColor}{HTML}{\csname themeColor@#1\endcsname}%
    \else
        \definecolor{themeColor}{HTML}{015697}%
    \fi
}

% 应用默认主题色
\setThemeColor{\orange}

% 二级色：句子编号圆圈用色（themeColor 加深变体）
\colorlet{scolor}{themeColor!80!black}

% ============================================================
% Section 5 : 页面几何
% ============================================================
\if@printmode
    \geometry{\@papersize, twoside, left=18mm, right=60mm, top=25mm, bottom=20mm, headsep=5mm, bindingoffset=8mm}
\else
    \geometry{\@papersize, left=18mm, right=60mm, top=25mm, bottom=20mm, headsep=5mm}
\fi

\setstretch{1.8}
\setlength{\parindent}{0pt}

% ============================================================
% Section 6 : 用户配置项存储
% ============================================================
\def\TransBook@value@PreTitle{\textbf{TransBook · 英语阅读手译本}}
\def\TransBook@value@Title{\heiti 考研英语手译本}
\def\TransBook@value@Subtitle{\textbf{阅读逐句翻译练习}}
\def\TransBook@value@Author{\textbf{研小布}}
\def\TransBook@value@Motto{\kaishu "Practice makes perfect."}
\def\TransBook@value@CoverImg{}
\def\TransBook@value@UpdateTime{\textbf{最后更新：\today}}

\def\TransBook@value@FooterText{\kaishu 此手译本由公众号【研小布】排版制作}
\def\TransBook@value@SidebarTitle{词汇手记}
\def\TransBook@value@BrandName{研小布}

\def\TransBook@value@TextWater{\textcolor{black!38}{\selectfont [水印文字]}}
\def\TransBook@value@WaterImg{img/water.png}
\def\TransBook@value@OnlineCheckUrl{https://github.com/ExBook/TransBook}

% --- 设置命令 ---
\newcommand\PreTitle[1]{\def\TransBook@value@PreTitle{\textbf{#1}}}
\newcommand\Title[1]{\def\TransBook@value@Title{\heiti \textbf{#1}}}
\newcommand\Subtitle[1]{\def\TransBook@value@Subtitle{\textbf{#1}}}
\newcommand\Author[1]{\def\TransBook@value@Author{\textbf{#1}}}
\newcommand\Motto[1]{\def\TransBook@value@Motto{\kaishu "#1"}}
\newcommand\CoverImg[1]{\def\TransBook@value@CoverImg{#1}}
\newcommand\UpdateTime[1]{\def\TransBook@value@UpdateTime{\textbf{最后更新：#1}}}
\newcommand\FooterText[1]{\def\TransBook@value@FooterText{\kaishu #1}}
\newcommand\SidebarTitle[1]{\def\TransBook@value@SidebarTitle{#1}}
\newcommand\BrandName[1]{\def\TransBook@value@BrandName{#1}}
\newcommand\TextWater[1]{\def\TransBook@value@TextWater{\textcolor{black!38}{\selectfont #1}}}
\newcommand{\textwater}{\TransBook@value@TextWater}
\newcommand\WaterImg[1]{\def\TransBook@value@WaterImg{#1}}
\newcommand\OnlineCheckUrl[1]{\def\TransBook@value@OnlineCheckUrl{#1}}

% ============================================================
% Section 7 : 工具命令
% ============================================================
\newcommand{\blankbox}{（\hspace{1.5em}）}
\newcommand{\eblankbox}{(\hspace{1.5em})}
\newcommand{\blankline}{\underline{\hspace{3em}}}
\newcommand{\noreftitle}[1]{\par \textbf{#1} \par}

% 带圆角矩形的标签
\newcommand{\trinum}[2][themeColor]{%
    \tikz[baseline]{\node[fill=#1, text=white, rounded corners=1mm, inner sep=2pt, yshift=1.5mm] {#2};}%
}

% 带圈数字标签（句子编号用）
\newcommand{\circlednum}[1]{%
    \tikz[baseline]{%
        \node[shape=circle, font=\fontsize{10pt}{12pt}\selectfont,
              fill=scolor, draw=white, inner sep=2pt, yshift=1.8mm] (char) {\color{white}{#1}};%
    }%
}

% ============================================================

% ============================================================
% Section 8 : 封面设计 ——「稿纸手写」风格
%
% 左侧 38% 宽主题色竖条承载所有标题文字（白字），
% 右侧 62% 稿纸区放置英文例句和翻译横线装饰。
% 所有文字位于色块范围内，确保白字/深底的对比度。
% ============================================================

\renewcommand{\maketitle}{%
    \begin{titlepage}
        \begin{tikzpicture}[remember picture, overlay]

            % --- 右侧背景：温暖稿纸色 ---
            \fill[black!3] ([xshift=0.38\paperwidth]current page.north west)
                rectangle ++(0.62\paperwidth, -\paperheight);

            % --- 左侧主题色竖条（38% 页宽）---
            \fill[themeColor] (current page.north west)
                rectangle ++(0.38\paperwidth, -\paperheight);

            % --- 竖条右侧渐变过渡带 ---
            \fill[themeColor, opacity=0.12]
                ([xshift=0.38\paperwidth]current page.north west)
                rectangle ++(0.04\paperwidth, -\paperheight);

            % --- 右侧「稿纸区」：两句英文 + 翻译横线装饰 ---
            \node[anchor=north west, text width=0.48\paperwidth]
                at ([xshift=0.45\paperwidth, yshift=-0.20\paperheight]current page.north west)
                {\fontsize{11pt}{16pt}\selectfont\rmfamily\color{black!35}
                 \textit{The only way to do great work}
                 \par
                 \textit{is to love what you do.}
                 \par\vspace{8pt}
                 \textcolor{black!15}{\rule{\linewidth}{0.4pt}}\par\vspace{2pt}
                 \textcolor{black!12}{\rule{\linewidth}{0.4pt}}\par\vspace{2pt}
                 \textcolor{black!10}{\rule{\linewidth}{0.4pt}}%
                };

            \node[anchor=north west, text width=0.48\paperwidth]
                at ([xshift=0.45\paperwidth, yshift=-0.48\paperheight]current page.north west)
                {\fontsize{11pt}{16pt}\selectfont\rmfamily\color{black!20}
                 \textit{Stay hungry, stay foolish.}
                 \par\vspace{8pt}
                 \textcolor{black!12}{\rule{\linewidth}{0.4pt}}\par\vspace{2pt}
                 \textcolor{black!08}{\rule{\linewidth}{0.4pt}}%
                };

            % --- 头部装饰横线（色块内顶部）---
            \draw[line width=0.3pt, white!25]
                ([xshift=1.8cm, yshift=-2cm]current page.north west)
                -- ++(0.35\paperwidth-2.8cm, 0);

            % --- 前置标题 ---
            \node[anchor=north west, align=left]
                at ([xshift=1.8cm, yshift=-0.30\paperheight]current page.north west)
                {\fontsize{12pt}{16pt}\selectfont\color{white!60} \TransBook@value@PreTitle};

            % --- 主标题（大字白字，完全在色块内）---
            \node[anchor=north west, align=left, text width=0.34\paperwidth]
                at ([xshift=1.8cm, yshift=-0.36\paperheight]current page.north west)
                {\fontsize{32pt}{38pt}\selectfont\bfseries\color{white} \TransBook@value@Title};

            % --- 装饰短线（主标题下方，白色半透明）---
            \draw[line width=1.5pt, white!40]
                ([xshift=1.8cm, yshift=-0.56\paperheight]current page.north west)
                -- ++(3cm, 0);

            % --- 副标题 ---
            \node[anchor=north west, align=left, text width=0.34\paperwidth]
                at ([xshift=1.8cm, yshift=-0.60\paperheight]current page.north west)
                {\fontsize{14pt}{20pt}\selectfont\color{white!55} \TransBook@value@Subtitle};

            % --- 底部装饰横线（色块内）---
            \draw[line width=0.3pt, white!20]
                ([xshift=1.8cm, yshift=0.20\paperheight]current page.south west)
                -- ++(0.35\paperwidth-2.8cm, 0);

            % --- 作者（底部，色块内）---
            \node[anchor=south west, align=left]
                at ([xshift=1.8cm, yshift=0.13\paperheight]current page.south west)
                {\fontsize{11pt}{15pt}\selectfont\color{white!65} \TransBook@value@Author};

            % --- 更新时间 ---
            \node[anchor=south west, align=left]
                at ([xshift=1.8cm, yshift=0.08\paperheight]current page.south west)
                {\fontsize{8pt}{10pt}\selectfont\color{white!35} \TransBook@value@UpdateTime};

            % --- 座右铭（右侧稿纸区底部）---
            \node[anchor=south east, align=right]
                at ([xshift=-1.5cm, yshift=0.06\paperheight]current page.south east)
                {\fontsize{9pt}{13pt}\selectfont\color{black!25}\itshape \TransBook@value@Motto};

            % --- 封面图片叠加（可选，覆盖在色块上）---
            \ifx\TransBook@value@CoverImg\empty
            \else
                \node[anchor=north west, inner sep=0pt]
                    at (current page.north west)
                    {\includegraphics[width=0.38\paperwidth, height=\paperheight,
                        keepaspectratio=false]{\TransBook@value@CoverImg}};
                \fill[themeColor, opacity=0.85]
                    (current page.north west) rectangle ++(0.38\paperwidth, -\paperheight);
            \fi

            % --- 在线勘误链接（可选）---
            \if@online
                \node[anchor=south east, align=right]
                    at ([xshift=-1.5cm, yshift=0.02\paperheight]current page.south east)
                    {\fontsize{7pt}{9pt}\selectfont\color{themeColor!40}
                     \href{\TransBook@value@OnlineCheckUrl}{在线勘误 →}};
            \fi

        \end{tikzpicture}
    \end{titlepage}
    \if@printmode
        \clearpage\null\thispagestyle{empty}\clearpage
    \fi
}

% Section 9 : 页眉页脚
% ============================================================
\pagestyle{fancy}
\fancyhf{}

\fancyfoot[L]{\fontsize{10pt}{0}{\thepage/\pageref{LastPage}}}
\fancyfoot[C]{\fontsize{10pt}{0}{\TransBook@value@FooterText}}

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% ============================================================
% Section 10 : 章/节标题格式化
% ============================================================
\titlecontents{section}[0em]
    {\setcounter{ParagraphCounter}{0}\heiti}
    {}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

\titlecontents{subsection}[2em]
    {\bfseries}
    {}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

\titlecontents{subsubsection}[4em]
    {}
    {}
    {}
    {\titlerule*[0.4pc]{.}\contentspage}

\titlespacing{\section}{0pt}{2pt plus 2pt minus 2pt}{4pt plus 2pt minus 2pt}
\titlespacing{\subsection}{0pt}{2pt plus 2pt minus 2pt}{2pt plus 2pt minus 2pt}

\titleformat{\section}[block]
    {\newpage\centering\heiti\normalsize}
    {}
    {0em}
    {}

\titleformat{\subsection}
    {\normalsize\bfseries\centering}
    {}
    {0em}
    {}

\renewcommand{\sectionmark}[1]{\markboth{\heiti\fontsize{10}{0}{\textbf{#1}}}{}}
\renewcommand{\subsectionmark}[1]{\markright{\fontsize{10}{0}{\textbf{#1}}}{}}

% ============================================================
% Section 11 : 段落与句子系统
% ============================================================

\newcounter{ParagraphCounter}
\newcounter{SentenceCounter}

\newif\if@resetcounter
\@resetcounterfalse

% Paragraph 环境：支持可选参数 reset 重置句子编号
\define@key{Paragraph}{reset}[true]{\@resetcountertrue}

\newenvironment{Paragraph}[1][]{%
    \setkeys{Paragraph}{#1}%
    \if@resetcounter
        \setcounter{SentenceCounter}{0}%
        \@resetcounterfalse
    \fi
    \stepcounter{ParagraphCounter}%
    \trinum{\fontsize{10pt}{0}{\heiti{第\chinese{ParagraphCounter}段}}}%
}{%
    \par\medskip
}

% Sentence 命令：自动测量句子宽度，生成对应数量的翻译横线
\newlength{\sentenceLength}
\newfontface\SentenceFont{Times New Roman}

\newcommand\Sentence[1]{%
    \stepcounter{SentenceCounter}%
    \begin{spacing}{1.3}%
        \noindent
        \circlednum{\arabic{SentenceCounter}} \begingroup \SentenceFont #1 \endgroup
    \end{spacing}%
    \par
    \vspace*{0.3cm}%
    % 测量句子宽度，计算所需横线数
    \settowidth{\sentenceLength}{\arabic{SentenceCounter}.\quad #1}%
    \@tempdimb=\dimexpr\sentenceLength\relax
    \@tempcnta=\numexpr\@tempdimb/\linewidth\relax
    \advance\@tempcnta by 1
    % 绘制横线（最少 1 条）
    \loop
        \noindent\textcolor{black!30}{\rule[0.5ex]{\linewidth}{0.5pt}}%
        \par
        \advance\@tempcnta by -1
    \ifnum\@tempcnta>0
    \repeat
}

% ============================================================
% Section 12 : 参考译文环境（吞咽技术，同 ExBook analysis）
% ============================================================
\newenvironment{translation}[1][参考译文：]{%
    \par
    \if@showtrans
        \vspace{2mm}
        \if@darkmode
            \begin{tcolorbox}[
                left=2mm, right=2mm, top=2mm, bottom=1mm,
                boxrule=0mm, leftrule=2pt,
                colframe=themeColor!60, arc=2mm, outer arc=2mm,
                opacityback=0.05, opacityframe=0.05, nobeforeafter
            ]
            \fontsize{11}{0}\textbf{\color{white}\kaishu#1}
            \kaishu\color{white!80}\ignorespaces
        \else
            \begin{tcolorbox}[
                left=2mm, right=2mm, top=2mm, bottom=1mm,
                boxrule=0mm, leftrule=2pt,
                colback=themeColor!5, colframe=themeColor,
                arc=2mm, outer arc=2mm, nobeforeafter
            ]
            \fontsize{11}{0}\textbf{\color{themeColor}\kaishu #1}
            \kaishu\ignorespaces
        \fi
    \else
        \setbox0=\vbox\bgroup
    \fi
}{%
    \if@showtrans
        \end{tcolorbox}\par
    \else
        \egroup
    \fi
}

% ============================================================
% Section 13 : 边栏系统（词汇手记区域）
% ============================================================
\newcommand{\drawSidebarRectangle}{%
    \ifthenelse{\equal{\thepage}{\pageref{TOC}}}{%
    }{%
        \begin{tikzpicture}[remember picture, overlay]
            % 右侧笔记区域：浅色填充 + 左侧实线
            \draw[fill=themeColor!6.2, draw=none]
                (current page.north east) ++(-5.4cm, -2.5cm)
                rectangle ++(\textwidth/2.4, -\textheight);
            \draw[themeColor, line width=1.5pt]
                (current page.north east) ++(-5.4cm, -2.5cm)
                -- ++(0, -\textheight);

            % 标题「词汇手记」
            \node[anchor=north east, xshift=-3.0cm, yshift=-2.7cm, align=center]
                at (current page.north east)
                {\heiti\color{themeColor}\fontsize{10pt}{0}{\ding{45} \TransBook@value@SidebarTitle}};

            % 章节标记
            \node[anchor=south west, xshift=-5.6cm, yshift=0.9cm, align=center]
                at (current page.south east)
                {\trinum[themeColor]{\heiti\leftmark}};
            \node[anchor=south west, xshift=-5.6cm, yshift=0.4cm, align=center]
                at (current page.south east)
                {\trinum[themeColor]{\heiti\rightmark}};

            % 左下角品牌标识
            \draw[fill=themeColor!6.2, draw=none]
                (current page.south west) ++(0cm, 2cm)
                rectangle ++(0.8cm, 2.4cm);
            \node[anchor=south west, xshift=0.8cm, yshift=2.25cm, align=center, rotate=90]
                at (current page.south west)
                {\heiti\color{white}\TransBook@value@BrandName};
        \end{tikzpicture}%
    }%
}

\AddToHook{shipout/background}{\drawSidebarRectangle}

% ============================================================
% Section 14 : 水印系统
% ============================================================
% （水印在边栏中已渲染，此处保留 \textwater 行内水印命令）
% \textwater 已在 Section 6 中定义

% ============================================================
% Section 15 : AtBeginDocument 钩子
% ============================================================
\AtBeginDocument{%
    \pagenumbering{gobble}%
    \pagenumbering{arabic}%
}

\endinput
