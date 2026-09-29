# AGENTS.md — ~/.emacs.d

个人 Emacs 配置，**literate configuration**：`config.org` 是唯一手写信源，启动时
`init.el` 用 `org-babel-load-file` 把它 tangle 成 `config.el` 再加载。
目标版本 **Emacs 31.x**（版本闸门写在 `config.org` 的 Preface）。

本文件只写这个仓库特有的东西。

## 文件角色

| 路径 | 说明 |
| --- | --- |
| `config.org` | **唯一手写源头**，配置改动都改这里 |
| `config.el` | 由 config.org 生成，gitignore，**不要手改** |
| `init.el` | bootstrap：gc 设置、`package-initialize`、加载 config.org |
| `settings.el` | 机器相关参数（`my/use-lsp-frontend`、`my/enabled-lang`、`my/enabled-feat` …），gitignore |
| `settings.example.el` | 上面那份的模板，git 跟踪 |
| `custom.el` | Customize 生成，gitignore |
| `simple.el` | 无网络环境的极简备用配置，不参与正常启动 |
| `readme.org` | 面向使用者的安装/致谢说明，非必要不改 |
| `elpa/` | 已安装包（gitignore）——**实际生效的版本** |
| `deps/` | submodule：lsp-bridge / color-rg / flymake-bridge / typst-ts-mode |
| `.pi/tasks/` | pi 后台任务输出 |

## 写 config.org 的规则

- **说明写「这个配置做什么、为什么」，不写改动史。** 不要出现
  "changed / now / previously"、日期、"曾经 X 现在 Y" 这类表述，也不要写
  bug 的来龙去脉。
- **简明：一个小节的说明最多一两行。** 细节交给代码注释，不要铺成三段。
- 代码块是配置本身，prose 是它的说明书。沿用现有 org 约定：`*`/`**`/`***`
  层级、`#+begin_src emacs-lisp|elisp`、`=verbatim=`、`+` 列表、必要的上游链接。
- **一个包的全部配置都收在它的 `use-package` 里**，自己写的 helper 和 advice
  也一样：`:init` 放包加载前就得生效的（自定义选项、要绑的命令），`:config`
  放依赖包内部符号的（advice、替换私有函数）。
- 不参与加载的内容用 `COMMENT` 子树或 `#+begin_src … :tangle no`。
  ⚠️ **`COMMENT` 子树整块不会被 tangle**，要生效的代码别放进去。
- 备选/示例写法放注释，不要留大段 dead code。

## 硬性约定与已知坑

- 只改 `config.org`；不用手动重新 tangle，下次启动会重生成。
- 手写 elisp 文件（`init.el`、`settings.el`、`custom.el`、`settings.example.el`）
  **第 1 行必须是** `;;; -*- lexical-binding: t -*-`，其余内容整体下移。
- 版本兼容分支只保留 Preface 那一处（`< 31` 报错、`> 31` 只 message）。
  **不要再写 `(version<= …)` 之类的判断。**
- 带 `:set` 函数的 user option 必须用 `setopt`——**`setq` 不触发 setter**
  （例：`treesit-enabled-modes`、`recentf-autosave-interval`）。
- 启用某个 tree-sitter 模式 = 把 `*-ts-mode` 加进 `treesit-enabled-modes`；
  不要手写 `auto-mode-alist` / `major-mode-remap-alist`。原因：第三方包的
  autoloads 会把 `auto-mode-alist` 条目**前置**、压过内置条目，而
  `major-mode-remap-alist` 的重映射最后生效。
- 内置的包/库一律 `:ensure nil`（`use-package`、`which-key`、`editorconfig`、
  `flymake`、`eglot`、`hideshow`、`recentf` …）。
- 大量 `use-package` 被 `my/use-lsp-frontend` / `my/enabled-lang` /
  `my/enabled-feat` 门控。**动手前先读 `settings.el`**，否则容易以为某段配置
  生效了其实没有。
- 新增第三方依赖前先问；能用内置的就用内置。
- **window parameter 不能当"这个窗口是我的"的标记**：persp-mode / winner-mode
  会保存并恢复整套 window state，恢复时把参数复制到无关窗口上。要认自己的
  窗口就记**窗口对象身份**。（`split-window` 本身**不**继承参数，实测如此。）
- **不要用 `:bind` 绑自己定义的命令**：`use-package` 的 `:bind` 会给被绑命令
  生成 autoload（指向被配置的包），自己的命令不在那个包里就得到假 autoload，
  第一次触发报 `Autoloading file X failed to define function …`。用 `:init` +
  `keymap-global-set`。
- `use-package` 的 `:custom` 在包加载**之前**求值没问题（`defcustom` 会采纳，
  但必须验证实际值）；`:bind` / `:defer t` 会让包按需加载，这不影响 `:config`
  里的 advice 随包加载装上。
- **override 第三方包私有函数的 advice 必须带 `fboundp` 守卫**（上游改内部
  实现时失效也只退回上游行为，不会让 config 加载崩）。目前两处都在
  `*** Pilish`：扩展对话框的 `C-g` 行为、右列窗口——**升级 pilish 后要复查**。

## 验证

改完必须跑一次全量加载：

```bash
cd ~/.emacs.d && emacs -Q --batch -l init.el
```

- 期望：没有任何 warning/error，只有正常的 `Loading` / `Tangled` 消息。
- 出现 `Missing 'lexical-binding' cookie` 或任何 warning/error 就是回归。
- 行为验证：临时脚本放 `.pi/`，`emacs -Q --batch -l init.el -l .pi/foo.el`
  （或 `--eval` 一段），**用完删掉**，否则它自己会报缺 cookie。
- batch 里不要做 `custom-save-all`、`package-install` / `package-delete`
  这类有副作用的操作。
- batch 验证不了 GUI 行为（LSP 是否真的连上、face/字体观感、按键手感）。
  这类结论要写明"未验证"并请用户自己确认。
- **窗口行为可以在这套 batch 里验**：造 scratch buffer、调函数、打印
  `window-list` / `window-edges` / `window-parameters` 就行。但 batch 的 tty
  frame 改不了尺寸（`set-frame-size` 无效），所以依赖 frame 尺寸的行为
  （宽度保持、随缩放重排）只能标注"未验证"。
- 顺带验"配置真的生效"：user option 用 `--eval '(princ VAR)'`，advice 用
  `--eval '(advice-member-p #'F #'G)'`。
- `.pi/` 里的临时脚本用 `cl-*` 系列函数前要 `(require 'cl-lib)`。

## 调试运行中的 Emacs

本机 Emacs 开着 server（socket `/run/user/1000/emacs`），GUI 现象不要靠猜：

```bash
emacsclient --eval '(mapcar (lambda (w) (list (buffer-name (window-buffer w)) (window-parameters w) (window-edges w))) (window-list))'
```

- 只读表达式：窗口树、window 参数、`window-prev-buffers`、哪些 minor mode 开着，
  都能直接问出来。
- Emacs 卡在 minibuffer 读入（比如权限提示）时这个调用会挂住，调用方要给超时。

## 查资料：先本地，再上游

1. **本机实际生效的版本**：`elpa/<包>-<版本>/`（源码、README、NEWS）。
   它才是运行中的那份，比上游 master 可信。另外
   `elpa/archives/*/archive-contents` 里的版本**可能过期**（别拿它推版本，
   要先 `package-refresh-contents`），而 `package-archive-priorities` 让
   melpa-stable 优先 → 装到的版本可能落后于 master，读上游代码时注意区分。
2. **Emacs 自带**：`/usr/share/emacs/31.1/lisp/**`（`.el.gz`）、
   `etc/NEWS`、`etc/NEWS.30`、`etc/EGLOT-NEWS`。
   ⚠️ 在 cwd 之外，bash 首行要按全局约定写 `# why: …`。
3. **上游**：MELPA / GNU ELPA 的包页面 → 对应仓库主页
   （GitHub / Codeberg / SourceHut）的 README、NEWS、issue；用 web 搜索或抓取。
4. **submodule**：看 `deps/` 下的实际代码与 README。
5. 别靠猜——能用 Emacs 自己问就别推理：

```bash
emacs -Q --batch --eval '(progn (require (quote X)) (princ (documentation-property (quote VAR) (quote variable-documentation))))'
```
