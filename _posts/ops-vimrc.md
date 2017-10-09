---
title: My Vim Config File
toc: true
date: 2017-10-04 20:16:21
categories: devops
tags: macos
description: vim config file
---

my vim custom config .vimrc file

<!-- more -->

```bash
syntax on        " 自动语法高亮
set number       " 显示行号         " 
"set cursorline  "  突出显示当前行
set ruler        " 打开状态栏标尺    (不错)
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set smartindent
set ts=4         " tabstop=4 设定 tab 长度为4
set nobackup     " 覆盖文件时不备份
set ignorecase smartcase    " 搜索时忽略大小写，但在有一个或以上大写字母时仍大小写敏感
"set nowrapscan             " 禁止在搜索到文件两端时重新搜索
set incsearch               " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本
set noerrorbells            " 关闭错误信息响铃
set novisualbell            " 关闭使用可视响铃代替呼叫
set t_vb=                   " 置空错误铃声的终端代码
set showmatch               " 插入括号时，短暂地跳转到匹配的对应括号
" set matchtime=2             " 短暂跳转到匹配括号的时间
set magic                   " 设置魔术
set hidden                  " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
"set guioptions-=T           " 隐藏工具栏
"set guioptions-=m           " 隐藏菜单栏
set smartindent             " 开启新行时使用智能自动缩进
set backspace=indent,eol,start
                            " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1             " 设定命令行的行数为 1
set laststatus=2            " 显示状态栏 (默认值为 1, 无法显示状态栏)

"set foldenable              " 开始折叠
"set foldmethod=syntax       " 设置语法折叠
"set foldcolumn=0            " 设置折叠区域的宽度
"setlocal foldlevel=1        " 设置折叠层数为
"set foldclose=all           " 设置为自动关闭折叠                            
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                              " 用空格键来开关折叠
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8


" return OS type, eg: windows, or linux, mac, et.st..
function! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
       return "windows"
    elseif has("unix")
       return "linux"
    endif
endfunction

" 用户目录变量$VIMFILES
if MySys() == "windows"
    let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
    let $VIMFILES = $HOME.'/.vim'
endif

" 设定doc文档目录
let helptags=$VIMFILES.'/doc'

" 配置多语言环境
if has("multi_byte")
   " UTF-8 编码
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" Buffers操作快捷方式!
nnoremap <C-RETURN> :bnext<CR>
nnoremap <C-S-RETURN> :bprevious<CR>
" Tab操作快捷方式!
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>
"关于tab的快捷键
" map tn :tabnext<cr>
" map tp :tabprevious<cr>
" map td :tabnew .<cr>
" map te :tabedit
" map tc :tabclose<cr>
"窗口分割时,进行切换的按键热键需要连接两次,比如从下方窗口移动
"光标到上方窗口,需要<c-w><c-w>k,非常麻烦,现在重映射为<c-k>,切换的
"时候会变得非常方便.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
nnoremap <leader>1 :set filetype=xhtml<CR>
nnoremap <leader>2 :set filetype=css<CR>
nnoremap <leader>3 :set filetype=javascript<CR>
nnoremap <leader>4 :set filetype=php<CR>
" set fileformats=unix,dos,mac
" nmap <leader>fd :se fileformat=dos<CR>
" nmap <leader>fu :se fileformat=unix<CR>
" use Ctrl+[l|n|p|cc] to list|next|previous|jump to count the result
" map <C-x>l <ESC>:cl<CR>
" map <C-x>n <ESC>:cn<CR>
" map <C-x>p <ESC>:cp<CR>
" map <C-x>c <ESC>:cc<CR>

" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python map <F12> :!python %<CR>

"-----------------------------------------------------------------
 " plugin - bufexplorer.vim Buffers切换
 " \be 全屏方式查看全部打开的文件列表
 " \bv 左右方式查看   \bs 上下方式查看
"-----------------------------------------------------------------

"-----------------------------------------------------------------
 " plugin - taglist.vim  查看函数列表，需要ctags程序
 " F4 打开隐藏taglist窗口
"-----------------------------------------------------------------
if MySys() == "linux"
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
nnoremap <silent><F4> :TlistToggle<CR>
let Tlist_Show_One_File = 1            " 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         " 在右侧窗口中显示taglist窗口
let Tlist_File_Fold_Auto_Close=1       " 自动折叠当前非编辑文件的方法列表
                      let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1


"-----------------------------------------------------------------
" plugin - mark.vim 给各种tags标记不同的颜色，便于观看调式的插件。
" \m  mark or unmark the word under (or before) the cursor
" \r  manually input a regular expression. 用于搜索.
" \n  clear this mark (i.e. the mark under the cursor), or clear all highlighted marks .
" \*  当前MarkWord的下一个     \#  当前MarkWord的上一个
" \/  所有MarkWords的下一个    \?  所有MarkWords的上一个
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :ERDtree 打开NERD_tree         :NERDtreeClose    关闭NERD_tree
" o 打开关闭文件或者目录         t 在标签页中打开
" T 在后台标签页中打开           ! 执行此文件
" p 到上层目录                   P 到根目录
" K 到第一个节点                 J 到最后一个节点
" u 打开上层目录                 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录             R 递归刷新当前根目录
                      "-----------------------------------------------------------------
" F3 NERDTree 切换
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>


"-----------------------------------------------------------------
" plugin - NERD_commenter.vim   注释代码用的，
" [count],cc 光标以下count行逐行添加注释(7,cc)
" [count],cu 光标以下count行逐行取消注释(7,cu)
" [count],cm 光标以下count行尝试添加块注释(7,cm)
" ,cA 在行尾插入 /* */,并且进入插入模式。 这个命令方便写注释。
" 注：count参数可选，无则默认为选中行或当前行
"-----------------------------------------------------------------
let NERDSpaceDelims=1       " 让注释符与语句之间留一个空格
let NERDCompactSexyComs=1   " 多行注释时样子更好看


"-----------------------------------------------------------------
" plugin - DoxygenToolkit.vim  由注释生成文档，并且能够快速生成函数标准注释
"-----------------------------------------------------------------
let g:DoxygenToolkit_authorName="Asins - asinsimple AT gmail DOT com"
let g:DoxygenToolkit_briefTag_funcName="yes"
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /*  */<LEFT><LEFT><LEFT>


"-----------------------------------------------------------------
" plugin - matchit.vim   对%命令进行扩展使得能在嵌套标签和语句之间跳转
" % 正向匹配      g% 反向匹配
" [% 定位块首     ]% 定位块尾
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin - vcscommand.vim   对%命令进行扩展使得能在嵌套标签和语句之间跳转
" SVN/git管理工具
"-----------------------------------------------------------------

"---------------------------------------------
"定义函数SetTitle，自动插入文件头
func SetTitle()
    if &filetype == 'c'
        call setline(1, "#include <stdio.h>")
        call setline(2, "#include <string.h>")
        call setline(3, "")
        call setline(4, "int main() {")
    elseif &filetype == 'cpp'
        call setline(1, "#include <iostream>")
        call setline(2, "")
        call setline(3, "using namespace std;")
        call setline(4, "")
        call setline(5, "int main() {")
    endif
endfunc

 set completeopt=longest,menu 
 "新建.c,.h,.sh,.java文件，自动插入文件头
 autocmd BufNewFile *.[ch],*.sh,*.cpp,*.java exec ":call SetTitle()"
 "--------------------------------------------- 

"定义CompileRun函数，用来调用进行编译和运行
func! CompileRun()
    exec "w"
    "C程序
    if &filetype == 'c'
        exec "!gcc % -g -o %<.exe"
        exec "! ./%<.exe"
    elseif &filetype == 'cpp'
        exec "!g++ % -g -o %<"
        exec "! ./%<"
    "Java程序
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    endif
endfunc
"结束定义CompileRun

" ======= 编译 && 运行 ======= "
" 编译源文件
func! CompileCode()
    exec "w"
    if &filetype == "c"
        exec "!gcc -Wall -std=c99 %<.c -o %<"
    elseif &filetype == "cpp"
        exec "!g++ -Wall -std=c++98 %<.cpp -o %<"
    elseif &filetype == "java"
        exec "!javac %<.java"
    endif
endfunc

" 运行可执行文件
func! RunCode()
    exec "w"
    if &filetype == "c" || &filetype == "cpp" || &filetype == "haskell"
        exec "! ./%<" 
    elseif &filetype == "java"
        exec "!java %<"
    endif
endfunc

"--------------------------------------------- 
" Ctrl + F9   一键保存, 编译
" Ctrl + F10  一键保存，运行
" F9  编译 + 运行
" F10 Debug
map<C-F9>:call CompileCode()<CR>
imap<C-F9> <ESC>:call CompileCode()<CR>
vmap<C-F9> <ESC>:call CompileCode()<CR>
map<C-F10>:call RunCode()<CR>
imap<C-F10> <ESC>:call RunCode()<CR>
vmap<C-F10> <ESC>:call RunCode()<CR>
map<F9>:call CompileRun()<CR>
imap<F9> <ESC>:call CompileRun()<CR>
vmap <F9> <ESC>:call CompileRun()<CR>

set mouse=v " 鼠标支持
```