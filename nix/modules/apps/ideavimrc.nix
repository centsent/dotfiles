{ ... }:

{
  home.file.".ideavimrc".text = ''
set incsearch
set surround
set NERDTree
set ignorecase
set smartcase

let mapleader = ","
let g:mapleader = ","
nnoremap ; :
nnoremap H ^
nnoremap L $
nnoremap U :action $Redo<cr>

nnoremap gn :action GotoNextError<cr>
nnoremap gp :action GotoPreviousError<cr>
nnoremap gi :action GotoImplementation<cr>
nnoremap gd :action GotoDeclaration<cr>
nnoremap gf :action Forward<cr>
nnoremap gr :action Refactorings.QuickListPopupAction<cr>
nnoremap gu :action FindUsages<CR>
nnoremap <c-o> :action Back<cr>
nnoremap go :action OptimizeImports<cr>
nnoremap gw :action GenerateGetterAndSetter<cr>

nnoremap fa :action SearchEverywhere<cr>
nnoremap fc :action GotoClass<cr>
nnoremap ff :action GotoFile<cr>
nnoremap fg :action FindInPath<cr>
nnoremap fh :action CallHierarchy<cr>

nnoremap <leader>ss :source ~/.ideavimrc<cr>
nnoremap <leader>se :edit ~/.ideavimrc<cr>
nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>x :action HideAllWindows<CR>

nnoremap <tab> :action NextTab<cr>
nnoremap <s-tab> :action PreviousTab<cr>
nnoremap <leader>f :NERDTreeToggle<cr>

noremap <space>a :action android.deploy.ApplyChanges<cr>
noremap <space>d :action Debug<cr>
noremap <space>p :action Android Profiler<cr>
nnoremap <space>r :action Run<cr>
noremap <space>R :action Rerun<cr>
noremap <space>s :action Stop<cr>

nnoremap zc :action CollapseRegion<CR>
nnoremap zo :action ExpandRegion<CR>
nnoremap zC :action CollapseAllRegions<CR>
nnoremap zO :action ExpandAllRegions<CR>

nnoremap gcc :action CommentByLineComment<cr>
nnoremap gcb :action CommentByBlockComment<cr>

nnoremap <c-j> :move +1<cr>
nnoremap <c-k> :move -2<cr>

inoremap <c-j> <esc>
inoremap <c-b> <c-o>h
inoremap <c-f> <c-o>l
inoremap <c-n> <c-o>j
inoremap <c-p> <c-o>k
inoremap <c-e> <c-o>$
inoremap <c-a> <c-o>^

vnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>x "+d
vnoremap H ^
vnoremap L $

xnoremap <c-j> :move '>+1<cr>gv-gv
xnoremap <c-k> :move '<-2<cr>gv-gv
xnoremap gc :action CommentByLineComment<cr>
xnoremap gb :action CommentByBlockComment<cr>

onoremap H ^
onoremap L $
  '';
}
