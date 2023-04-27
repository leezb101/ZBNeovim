vim.g.encoding = "utf-8"
vim.g.fileencoding = "utf-8"

-- jkhl移动时光标保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 使用相对行号
vim.o.relativenumber = true
vim.o.number = true
-- 高亮所在行
vim.o.cursorline = true
-- 所在行行号高亮
vim.o.cursorlineopt = "number"
-- 显示左侧图标指示列
vim.o.signcolumn = "yes"
-- 右侧参考线，超过100字符时显示
vim.o.colorcolumn = "100"
-- 缩进2个空格表示一个tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << 时移动2个空格
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- 新行对齐当前行
vim.o.smartindent = true
vim.o.autoindent = true
vim.bo.autoindent = true
-- 搜索时忽略大小写，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索不要高亮
vim.o.hlsearch = false
-- 边输入边搜索
vim.o.incsearch = true
-- 命令行高为3
vim.o.cmdheight = 3
-- 当文件被外部修改时自动读取
vim.o.autoread = true
vim.bo.autoread = true
-- 禁用/启用折行
vim.o.wrap = true
-- 光标在行首尾时<Left><Right>跳转到上下行
vim.o.whichwrap = "<,>,[,]"
-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- 鼠标支持
vim.o.mouse = "a"
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- smaller updatetime
vim.o.updatetime = 300
-- 设置 timeoutlen 为等待键盘快捷键连击时间800毫秒，可根据需要设置
vim.o.timeoutlen = 800
-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true
-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = true
vim.o.listchars = "space:·"
-- 补全增强
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'
-- 补全最多显示10行
vim.o.pumheight = 10
-- 永远显示 tabline
vim.o.showtabline = 2
-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.o.showmode = false
