" The following is to make <c-[> work for ctags + bib entries
" E.g., \cite{chen.hu.ea:17:space-time}
setlocal iskeyword+=- iskeyword+=.

" Set status line display
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Define my command for pdflatex
command! Pdflatax :update|lcd %:p:h|!pdflatex -synctex=1 %
command! Lualatax :update| !lualatex --shell-escape -synctex=1 -interaction=nonstopmode %
autocmd FileType tex noremap <leader>c :Pdflatax <CR>
" autocmd FileType tex noremap <leader><leader> :Lualatax <CR>
" autocmd FileType tex noremap <leader><leader> :update<bar>:call VimuxRunCommandInDir('lualatex --shell-escape -synctex=1 ',1)<CR>

function! RunLuaLatex(TexFileName)
  let g:asyncrun_exit = 'silent :lua require("notify")("Lualatex has done~! -- Le", "info")'
  " normal! :w!<cr>
  exec "w!"
  " echom "Run Lualatex now..."
  let execstr="AsyncRun! lualatex --shell-escape --synctex=1 -interaction=nonstopmode " . a:TexFileName
  " echom execstr
  silent exec execstr
  let bibfile=split(a:TexFileName,"\\.")[0] . "_biber.bib"
  " echom bibfile
  if filereadable(bibfile)
    let execstr = "!ctags -R --options=" . stdpath('config') . "/tags/ctags_latex" . " *.tex " . bibfile
    silent exec execstr
  elseif filereadable("All.bib")
    let execstr = "!ctags -R --options=" . stdpath('config') . "/tags/ctags_latex *.tex All.bib"
    silent exec execstr
  else
    echom "No bib files and ctags has not run~! -- Le Chen"
  endif
  " echom execstr
  let g:asyncrun_exit = 'silent :lua require("notify")("Asyncrun has done~!", "info")'
endfunction

autocmd FileType tex noremap <silent> \\ :call RunLuaLatex(expand("%"))<cr>
" autocmd FileType tex noremap <silent> <leader><leader> :w<cr>:VimtexCompile<cr>
" autocmd FileType tex noremap <leader><leader> :update<bar>:AsyncRun! lualatex --shell-escape -synctex=1 %<CR>
" autocmd BufRead,BufNewFile,BufEnter,BufWinEnter tex <leader><leader> :update<bar>:AsyncRun! lualatex --shell-escape -synctex=1 %<CR>

function! LatexBiber()
  " echom "Run biber now..."
  let g:asyncrun_exit = 'silent :lua require("notify")("Biber has done~! -- Le", "info")'
  let filenameRoot=expand("%:r")
  let execstr="AsyncRun! biber --output_format=bibtex --output_resolve " . filenameRoot. ".bcf && biber " . filenameRoot
  echom execstr
  exec execstr
  echom "Done biber now..."
  " let g:asyncrun_exit = 'silent :lua require("notify")("Asyncrun has done~!", "info")'
endfunction
autocmd FileType tex noremap \b :update<bar>:call LatexBiber()<CR>
autocmd FileType tex noremap \B :update<bar>:!bibtex %:r<CR>

function! CopyAllBib()
  " echom "Run biber now..."
  let filenameRoot=expand("%:r")
  let execstr="AsyncRun! rsync ~/Dropbox/workspace/svn/refdb/All.bib All.bib "
  " let execstr="AsyncRun! rsync ~/Dropbox/Public/SPDEs-Bib/All.bib All.bib "
  exec execstr
  let g:asyncrun_exit = 'silent :lua require("notify")("Synchronized All.bib~! -- Le", "info")'
endfunction
autocmd FileType tex noremap \i :update<bar>:call CopyAllBib()<CR>

function! MyUpdateBib()
  let execstr = ":r " . expand("%:r") . "_biber.bib"
  " echom execstr
  exec execstr
endfunction

function! RunBlackTex()
  exec "w!"
  " echom "Run Lualatex now..."
  " If the file output.tex exists, remove it
  if filereadable("output.tex")
    exec "!rm output.tex"
  endif
  let execstr="!blacktex --keep-dollar-math --keep-comments " . expand("%") . "> output.tex"
  echom execstr
  silent exec execstr
  exec "vertical diffsplit output.tex"
endfunction

autocmd FileType,BufEnter,BufWinEnter yaml noremap ff :call SyncYamlZathura()<CR>
" autocmd FileType tex set foldmethod=marker
autocmd FileType tex.lua noremap \\ :Lualatax <CR>

au FileType tex let b:AutoPairs = {"'":"'",'"':'"', '':''}

if &filetype == "tex"
  let g:AutoPairs = {"'":"'",'"':'"', '':''}
endif

nnoremap <leader>w :set wrap!<cr>

" Some useful macros
" 1. @m minipage, first write a fraction for the \textwidth, then @m{{{
let @m="\<Esc>BdWi\\begin{minipage}{\<Esc>pa\\textwidth}\<Esc>0yf}o\<Esc>pFbdwiend\<Esc>ko"
"}}}
" 2. @g inclurdegraphics, first write the file name.{{{
let @g="\<Esc>BdWi\\includegraphics[scale=0.25]{\<Esc>pa}\<Esc>Bwwwww\<Esc>"
"}}}
" 3. @o The following will make beamer slides only. Make sure select the text first{{{
let @o="di\\only<1->{}hp"
"}}}
" 4. @a The following is to add alert to the selected text{{{
let @a='di\alert{pa}'
"}}}
" 5. Add textcolor to the selected text, the color is in{{{
" register n.
" @c to add color from register z: magenta
" @v to add another color from register b: cyan
" @i to add \it in side {}. Start inside {}.
" @x to remove color, start when the cursor is on textcolor
" @r to remove the next textcolor
let @z='magenta'
let @c='gvdi\textcolor{"zpa}{pa}'
let @b='cyan'
let @v='gvdi\textcolor{"bpa}{pa}'
let @x='gvdiwhxda{sd{'
let @i='gvdi\textit{pa}'
" let @r="/textcolor\<cr>hdf}sd{"
" The following is to add color for the selected text within a line
autocmd FileType tex vnoremap <C-n> "hdi\textcolor{magenta}{<esc>"hpa}<esc>
" The following is to add color for the selected text by lines
autocmd FileType tex vnoremap <C-m> "hdO\textcolor{magenta}{<cr>}<esc>k"hp<esc>
"}}}
" 6. The following transform \| ... \| to \Norm{...} in the current line.{{{
" test here: \|a asdf.. adf\|
" Either of the following two will give the same result.
autocmd FileType tex nnoremap <c-n><c-n> :s/\\\|\(.*\)\\\|/\\Norm{\1}/g<c-b>
"}}}
" 7. gF: The following is to open latex file without extension.{{{
" Created one if it does not exist.
autocmd FileType tex noremap gF :vsplit <cfile>.tex<cr>
"}}}
" 8. bb: The following command align equations.{{{
" This requires easyalign plugin.
autocmd FileType tex nmap bb mmviega*&'m
" nnoremap bb vie:EasyAlign *&<cr>
"}}}
" 10. The following command is to pdf file all indent from ../refs/ folder.{{{
" autocmd FileType tex nnoremap gtt :/\%<c-r>=line('.')<cr>lcite{<CR>n5lyt}:!zathura ./refs/<C-r>".pdf &
" autocmd FileType tex vnoremap gtt "hy:!zathura ./refs/<C-r>h.pdf &
"}}}
" 11. Switch $$...$$ to \begin{align} ... \end{align}{{{
" let @e = "\<ESC>?$$\<CR>ddO\\begin{align}\<ESC>/$$\<CR>ddO\\end{align}\<ESC>"
let @e="di\$o\\begin{align*}\<CR>\<Esc>po\\end{align*}\<Esc>?\$\$\<CR>dd"
" let @e="dd"
" Switch \[...\] to \begin{align} ... \end{align}
" nnoremap <leader>e :normal! mm?$$<cr>ddO\begin{align}<esc>/$$<cr>ddO\end{align}<esc>'m
autocmd FileType tex nnoremap <leader>e :normal! mm/\$\$<cr>Nxxi\begin{align*}<cr><esc>nxxo\end{align*}<esc>'m
autocmd FileType tex nnoremap <leader>r :normal! vi{"9ydi{diW"9pa<space><esc><cr>
"}}}
" 12. Open references or codes using dmenu.{{{
" https://leafo.net/posts/using_dmenu_to_open_quickly.html
" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction
" Find a file and pass it to cmd
function! DmenuOpen(cmd,files)
  " let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
  let fname = Chomp(system("ls ". a:files . " | dmenu -i -l 30 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname ." &"
endfunction
" Open files with dmenu.
autocmd FileType tex nnoremap <leader>rr :call DmenuOpen("!zathura","refs/*.pdf")<cr>
autocmd FileType tex nnoremap <leader>rm :call DmenuOpen("!mathematica","codes/*.nb")<cr>
autocmd FileType tex nnoremap <leader>rd :call DmenuOpen("!zathura","Discussions/*.pdf *.pdf")<cr>
"}}}
" 13. The following is for Zathura forward search{{{
" Double hit ff in normal mode for forward locate to the position in pdf file viewed in zathura
function! SyncTexForward()
  let linenumber=line(".")
  let colnumber=col(".")
  let filename=bufname("%")
  let filenamePDF=filename[:-4]."pdf"
  let execstr="!zathura --synctex-forward " . linenumber . ":" . colnumber . ":" . filename . " " . filenamePDF . "&>/dev/null &"
  exec execstr
endfunction
autocmd FileType tex noremap ff :call SyncTexForward()<CR>
"}}}
" 14. The following is the setup when in the vimdiff mode.{{{
if &diff
	autocmd FileType tex nnoremap <silent> <space><space> :windo call SyncTexForward()<CR> <c-w>w
	autocmd FileType tex noremap <leader><space> :silent windo !zathura %:r.pdf &<cr>
else
	autocmd FileType tex nnoremap <silent> <space>b :call SyncTexForward()<CR>
	autocmd FileType tex noremap <leader><space> :silent !zathura %:r.pdf &<cr>
endif
"}}}
" 15. Generate matrix and arrays{{{
" run the following command in command mode:
" https://vi.stackexchange.com/questions/17439/easiest-way-to-insert-latex-matrix
" :Matrix 3 4
" :Array 3 4
" The first argument has to be the number for rows.
" If the second argument is not given, the default column will be 3.
function! CreateMatrix(rows, ...) abort
  let cols = a:0 ? a:1 : 3
  let matrix = ['\begin{bmatrix}']
  call extend(matrix, repeat([repeat('0 & ', cols - 1) . '0\\'], a:rows))
  call add(matrix, '\end{bmatrix}')
  call append(line('.') - 1, matrix)
endfunction
command! -nargs=+ Matrix silent call CreateMatrix(<f-args>)
" Now for Array
function! CreateArray(rows, ...) abort
  let cols = a:0 ? a:1 : 3
  let matrix = ['\begin{array}{' . repeat('c',cols) . '}']
  call extend(matrix, repeat([repeat('<++> & ', cols - 1) . '<++>\\'], a:rows))
  call add(matrix, '\end{array}')
  call append(line('.') - 1, matrix)
endfunction
command! -nargs=+ Array silent call CreateArray(<f-args>)
"}}}
" 16. My setup for reviewing reports {{{
command! GenReview :w!| :!GenReview.lua > /home/lechen/Dropbox/vimwiki/Reviewing\ records.wiki
command! GenMathReview :w!| !GenMathReview.lua > /home/lechen/Dropbox/vimwiki/MathRew.wiki
augroup MyNoteGroup
	" au! BufRead,BufNewFile,BufEnter *.java,*Test.java,*/test/* <<YOURCOMMANDHERE>>
	au! BufRead,BufNewFile,BufEnter notes.tex nnoremap <leader>r :GenReview<CR>
	" autocmd BufRead,BufNewFile,BufEnter notes.tex :set filetype=tex.vimwiki
augroup END
"}}}


function! RunBlackTex()
  exec "w!"
  " echom "Run Lualatex now..."
  " If the file output.tex exists, remove it
  if filereadable("output.tex")
    exec "!rm output.tex"
  endif
  let execstr="!blacktex --keep-dollar-math --keep-comments " . expand("%") . "> output.tex"
  echom execstr
  silent exec execstr
  exec "vertical diffsplit output.tex"
endfunction


"  17. Reformat lines (getting the spacing correct) {{{
" https://tex.stackexchange.com/questions/1548/intelligent-paragraph-reflowing-in-vim
" fun! TeX_fmt()
"     if (getline(".") != "")
"     let save_cursor = getpos(".")
"         let op_wrapscan = &wrapscan
"         set nowrapscan
"         let par_begin = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\Start\|\\Stop\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
"         let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\Start\|\\Stop\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
"         " let par_begin = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
"         " let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
"     try
"       exe '?'.par_begin.'?+'
"     catch /E384/
"       1
"     endtry
"         norm V
"     try
"       exe '/'.par_end.'/-'
"     catch /E385/
"       $
"     endtry
"     norm gq
"         let &wrapscan = op_wrapscan
"     call setpos('.', save_cursor)
"     endif
"     norm zz
" endfun
"
" nmap Q :call TeX_fmt()<CR>

" function! My_Q()
"   exec "normal! :call <Plug>latexfmt_format"
"   " exec "normal! <c-o>"
" endfunction
" nmap <unique><silent> Q :call My_Q()<cr>
let g:latexfmt_verbatim_envs = [
      \ 'equation',
      \ 'alignat',
      \ 'align',
      \ 'eqnarray',
      \ 'gather',
      \ 'figure',
      \ 'tikzpicture',
      \ '\(\\)\@1<!\[']
" noremap <unique><silent> Q <Plug>latexfmt_format | normal <c-o> |
noremap <unique><silent> qs <Plug>latexfmt_format | normal! <c-o>
" noremap <unique><silent> P vip <Plug>latexfmt_format | normal! <c-o>
" }}}



noremap <buffer> K <Plug>(vimtex-doc-package)

"{{{ 19. Papis
function! PapisBibtexRef()
  let l:temp = tempname()
  echom l:temp
  silent exec "!papis bibtex ref -o ".l:temp
  let l:olda = @a
  let @a = join(readfile(l:temp), ',')
  normal! "ap
  redraw!
  let @a = l:olda
endfunction

command! -nargs=0 BibRef call PapisBibtexRef() command! -nargs=0 BibOpen exec "!papis bibtex open"
autocmd FileType tex nnoremap .b :!Link_All_bib.sh dummy <cr>  :vert sview ~/Dropbox/workspace/svn/refdb/All.bib<cr> :vertical resize 80 <cr> <C-w>w
autocmd FileType tex nnoremap <silent> gtt :/\%<c-r>=line('.')<cr>lcite{<CR>n5lyt}:!open_by_CiteKey.sh <C-r>"<cr>
autocmd FileType tex vnoremap <silent> gtt "hy:!open_by_CiteKey.sh <C-r>"<cr>

autocmd FileType tex,bib nnoremap <silent> grr :/\%<c-r>=line('.')<cr>lcite{<CR>n5lyt}:!copy_pdf_by_CiteKey.sh <C-r>" refs/<cr>
" autocmd FileType tex vnoremap <silent> grr "hy:!copy_pdf_by_CiteKey.sh <C-r>" refs/<cr>
autocmd FileType tex,bib vnoremap <silent> grr "hy:!copy_pdf_by_CiteKey.sh <C-r>" ./<cr>

" Toggle textwidth between 800 and 80
" Done with Chatgpt
let g:textwidth_default = &textwidth
let g:textwidth_previous = &textwidth
autocmd FileType tex nnoremap <silent> <leader><backspace> :call ToggleTextwidth()<CR>
function! ToggleTextwidth()
  if &textwidth <= 80
    let g:textwidth_previous = &textwidth
    let &textwidth = 800
  else
    let g:textwidth_previous = &textwidth
    let &textwidth = 80
  " else
  "   let &textwidth = g:textwidth_previous
  endif
endfunction

" The following is to open the yaml file, the cursor is under the reference.
function! PapisBibtexYaml()
  normal! "byi{
  let CiteKey=getreg("b")
  " echom CiteKey
  let output = system('rg "CiteKey: "'. CiteKey." ~/Dropbox/Research-References/")
  echom "Before substitute: ". output
  let output = substitute(output, ":Cite.*", "", "g")
  " echom "Opening: ". output
  let execstr = ":vsplit ". output
  echom execstr
  exec execstr
  let execstr = ":vertical resize 80 <cr> <C-w>w"
  exec execstr
endfunction
autocmd FileType tex nnoremap <silent> gyy :call PapisBibtexYaml()<cr>

autocmd FileType tex nnoremap <silent> .i :Telescope bibtex<cr>

" Suppose the split window is open for All.bib,
" The next macro will synchronize the record.
autocmd FileType tex nnoremap <silent> rr yi{w/"zah
let @l='yi{w/"zah'


" Set upt g:bib file and then open it using rofi
let g:bib = ""
function! Refs()
  if len(g:bib) == 0
    echom "Please set up the bib file by \"let g:bib = ....bib\""
  else
    exec "!rg @ " . g:bib . " | sed 's/@.*{//' | sed 's/,//' | rofi -dmenu | xargs open_by_CiteKey.sh"
  endif
endfunction
autocmd FileType tex noremap <silent> <leader>r :call Refs()<cr>

" my script to open papis in a floaterm.
function PapisRefinFloaterm()
  FloatermSend papis_get_CiteKey.sh a
  FloatermShow
endfunction
command! PapisRef  :exec PapisRefinFloaterm()

" Yaml file
" update the papis library
autocmd FileType yaml noremap <silent> <leader><leader> :w!<cr> :!papis update --doc-folder .<cr> :e!
" Insert CiteKey
autocmd FileType yaml noremap <silent> cc ggOCiteKey: a
" Open pdf in marks, page number is under the cursor
function! SyncYamlZathura()
  let pagenumber=expand("<cword>")
  let fileName="output.pdf"
  let execstr="!zathura -P " . pagenumber . " " . fileName . "&>/dev/null &"
  exec execstr
endfunction
function! Scratch()
  let execstr="..."
  exec execstr
endfunction
autocmd FileType,BufEnter,BufWinEnter yaml noremap <silent> ff :call SyncYamlZathura()<CR>
autocmd FileType,BufEnter,BufWinEnter yaml noremap <silent> <leader><space> :!zathura output.pdf<CR>
autocmd FileType,BufEnter,BufWinEnter yaml noremap <silent> <leader>n :!zathura notes.pdf<CR>
autocmd FileType,BufEnter,BufWinEnter yaml noremap <silent> <leader>g :!zathura goodnotes.pdf<CR>
autocmd FileType,BufEnter,BufWinEnter yaml noremap <silent> nn :w!<cr> :!papis edit --notes --doc-folder . <cr> :e notes.tex<cr>
autocmd FileType,BufEnter,BufWinEnter yaml noremap mv :!~/bin/MoveLatestOutput.sh a<cr>
autocmd FileType,BufEnter,BufWinEnter yaml noremap gn :!~/bin/LinkGoodNotes.py a<cr>
autocmd FileType,BufEnter,BufWinEnter yaml noremap sc :!~/bin/Scratch.py<cr>
" Make sure @w is the macro to increase the right page number
let @w="12"
" let @e="Vkyjpj"
autocmd FileType,BufEnter,BufWinEnter yaml noremap tt Vkyjpj


" 1) Your existing function and command
function! GotoNotesCiteKey(citekey)
  if a:citekey == ''
    echo "\n\nUsage: :GotoNotesCiteKey CiteKey\nby Le CHEN, (chenle02@gmail.com)\nSat 25 Dec 2021 01:30:48 PM EST\n\n"
    return
  endif

  let file = system("rg --glob '!scripts' 'CiteKey: " . a:citekey . "' ~/Dropbox/Research-References/ | sed 's/info.*$/notes.tex/g' | tr -d '\n'")
  execute 'edit ' . file
endfunction

command! -nargs=1 GotoNotesCiteKey call GotoNotesCiteKey(<f-args>)

" 2) Example normal-mode mapping
"    - Here, we do a small search to jump to the nearest \cite{} pattern,
"      yank the text inside {¿}, and then call your function.
"    - Adjust the search/yank as needed to match your LaTeX references.
" autocmd FileType tex nnoremap <silent> gnn :silent! /\cite{\zs\k\+}<CR>n "zy :call GotoNotesCiteKey(@z)<CR>
autocmd FileType tex nnoremap <silent> gnn :/\%<c-r>=line('.')<CR>lcite{<CR>n5l"zyt}:call GotoNotesCiteKey(@z)<CR>

" Explanation of the normal-mode mapping:
"   :silent! /\cite{\zs\k\+}<CR>  -> search for 'cite{' and put the cursor after '{'
"   n                              -> jump to next match (if needed)
"   "zy                            -> yank the matched text into register z
"   :call GotoNotesCiteKey(@z)<CR> -> call the function with the yanked text


" 3) Example visual-mode mapping
"    - You visually select the CiteKey, press gnn, and it will yank your selection
"      into a register, then call the function.
autocmd FileType tex vnoremap <silent> gnn "zy:call GotoNotesCiteKey(@z)<CR>

" function! GotoNotesCiteKey2(citekey)
"   if a:citekey == ''
"     echo "\n\nUsage: :GotoNotesCiteKey2 CiteKey\nby Le CHEN (chenle02@gmail.com)\n\n"
"     return
"   endif
"
"   let file = system("rg --glob '!scripts' 'CiteKey: " . a:citekey . "' ~/Dropbox/Research-References/ | sed 's/info.*$/notes.tex/g' | tr -d '\n'")
"
"   " Remove any trailing newlines in file
"   let file = substitute(file, '\n\+$', '', '')
"
"   if empty(file)
"     let choice = confirm("File does not exist. Create it?", "&Yes\n&No", 2)
"     if choice == 1
"       let dir = fnamemodify(file, ":h")
"       call mkdir(dir, "p")
"       call writefile([], file)
"       echo "File created: " . file
"     else
"       echo "File not created."
"       return
"     endif
"   endif
"
"   execute 'edit ' . file
"   echo file
" endfunction
"
" command! -nargs=1 GotoNotesCiteKey2 call GotoNotesCiteKey2(<f-args>)

" }}}

" {{{ 20. Here are some abbreviations
ab matern Mat\'ern 
" }}}

" The following is the update references.
let @a='gccyi`0jvi{üR+@7kb\b'

" echom "LatexProject.vim has been sourced~! -- Le Chen"


