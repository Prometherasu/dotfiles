" ============================================
" CONFIGURATION DE BASE
" ============================================

" Activer la coloration syntaxique
syntax on

" Afficher les numéros de ligne
set number
" set relativenumber          " Numéros relatifs (utile pour les déplacements)

" Indentation intelligente
set autoindent
set smartindent

" Tabulation : 4 espaces (standard Python)
set tabstop=4
set shiftwidth=4
set expandtab               " Convertir les tabs en espaces
set softtabstop=4

" Recherche insensible à la casse
set ignorecase
set smartcase               " Sauf si on met une majuscule

" Afficher la position du curseur
set ruler

" Afficher les commandes en bas
set showcmd

" Recherche en temps réel
set incsearch
set hlsearch                " Surligner les résultats

" Activer le retour en arrière (backspace) complet
set backspace=indent,eol,start

" Encodage UTF-8
set encoding=utf-8
set fileencoding=utf-8

" ============================================
" INTERFACE UTILISATEUR
" ============================================

" Activer la souris (utile pour scroller)
set mouse=a

" Afficher la barre d'état
set laststatus=2

" Thème de couleurs (décommente celui que tu préfères)
" colorscheme desert        " Classique
" colorscheme slate         " Sombre
" colorscheme morning       " Clair
" colorscheme ron             " Bon contraste pour Kali

" Afficher les lignes trop longues
" set colorcolumn=80
" highlight ColorColumn ctermbg=darkgray

" Afficher les caractères invisibles
set list
set listchars=tab:▸\ ,trail:·,nbsp:␣

" ============================================
" FONCTIONNALITÉS AVANCÉES
" ============================================

" Auto-complétion avec Tab
set wildmenu
set wildmode=list:longest,full

" Permettre le changement de buffer sans sauvegarder
set hidden

" Historique des commandes
set history=1000

" Fichiers de sauvegarde et swap
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Activer l'annulation persistante
set undofile

" ============================================
" RACCOURCIS CLAVIER PERSONNALISÉS
" ============================================

" Leader key (ta touche de préfixe)
let mapleader = ","

" Enregistrer avec Ctrl+S (comme dans la plupart des éditeurs)
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Quitter avec Ctrl+Q
nnoremap <C-q> :q<CR>

" Désactiver la recherche surlignée avec double-Échap
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" Navigation entre les buffers
nnoremap <leader>n :bnext<CR>
nnoremap <leader>b :bprevious<CR>
nnoremap <leader>d :bdelete<CR>

" Copier/Coller vers/depuis le clipboard système
" (Nécessite vim-gtk ou vim-gnome installé)
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" ============================================
" CONFIGURATIONS SPÉCIFIQUES AUX LANGAGES
" ============================================

" Python - pliage automatique
" autocmd FileType python setlocal foldmethod=indent

" Bash/Shell - syntaxe améliorée
" autocmd FileType sh setlocal ts=2 sts=2 sw=2

" Markdown - syntaxe
" autocmd FileType markdown setlocal spell spelllang=fr
" autocmd FileType markdown setlocal textwidth=80

" JSON - formatage
" autocmd FileType json setlocal ts=2 sts=2 sw=2

" ============================================
" FONCTIONS UTILES
" ============================================

" Nettoyer les espaces en fin de ligne
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
endfunction
nnoremap <leader>ws :call CleanExtraSpaces()<CR>

" Afficher la syntaxe sous le curseur
nnoremap <leader>ss :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<CR>

" ============================================
" AMÉLIORATIONS VISUELLES
" ============================================

" Curseur en forme de bloc en mode normal, barre en mode insertion
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" ============================================
" CONFIGURATION TERMINAL
" ============================================

" Meilleur support des couleurs 256
set t_Co=256

" Support des couleurs vraies si disponible
if has("termguicolors")
    set termguicolors
endif

" ============================================
" DERNIÈRES OPTIONS
" ============================================

" Charger les types de fichiers
filetype plugin on
filetype indent on

" Message de bienvenue désactivé
set shortmess+=I

" Fin du fichier .vimrc

