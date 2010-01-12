" ===========================================================================================
"                          CONFIG POUR DEVELOPPEMENT PYTHON
" ===========================================================================================
set nocompatible                 " Rend Vim non compatible avec Vi
set shiftwidth=4                 " Nombre de caractère utilisé pour l'indentation
set tabstop=4                    " Nombre d'espace par tab
set softtabstop=2                " Pour que backspace supprime 4 espaces
set expandtab                    " Insère un nombre approprié d'espace pour <Tab>
set smarttab                     " <Tab> en début de ligne, insère blancs selon shiftwidth sinon tabstop
set smartindent                  " Indentation des mots de l'option 'cinwords'
set backspace=indent,eol,start   " Retour Arrière autorisé en mode Insertion pour suppression
set ruler                        " Affiche en bas à droite la position du curseur
set showcmd                      " Affiche en bas à droite la commande en cours de saisie
set showmode                     " Affiche en bas à droite le mode actif
set showmatch                    " Affiche automatiquement la parenthèse correspondante
set wrap                         " Si ligne trop longue se poursuit sur ligne suivante
set incsearch                    " Montre correspondance partielle du motif de recherche
set hlsearch                     " Surligne les occurrences de la chaîne recherchée
set ignorecase                   " Ignore la casse dans les motifs de recherche
set mouse=a                      " Activation de la souris
set cursorline                   " Soulignement de la ligne courante
set t_Co=256e                    " Passe en 256 couleurs
set laststatus=2                 " Afficher en permanence la barre d'état (en plus de la barre de commande)
set statusline=%=%f%10p%%%10c/%l " Affiche info sur la ligne
set wildmode=list:longest        " Affiche une liste identique à la complétion bash
set showtabline=2                " Affiche toujours les onglets
set lcs:tab:>-,trail:.           " Affiche les tabs, les ' ' en fin de ligne et les \n
set nu                           " Affiche les numéros de ligne

syntax on         " Activation de la coloration syntaxique
colorscheme zenburn

filetype on                      " Detection to determine the type of the current file
filetype plugin on
filetype plugin indent on        " For plugin Pyflakes
au BufRead *.stl so  $VIMRUNTIME/syntax/html.vim  " Coloration des fichiers STL


function! MyTabLine()
	  let s = ''
	  for i in range(tabpagenr('$'))
	    " select the highlighting
	    if i + 1 == tabpagenr()
	      let s .= '%#errorMsg#'
	    else
	      let s .= '%#Tab#'
	    endif

	    " set the tab page number (for mouse clicks)
	    let s .= '%' . (i + 1) . 'T'

	    " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
	  endfor

	  " after the last tab fill with TabLineFill and reset tab page nr
	  let s .= '%#TabLineFill#%T'

	  " right-align the label to close the current tab page
	  if tabpagenr('$') > 1
	    let s .= '%=%#TabLine#%999X X '
	  endif

	  return s
	endfunction

function! MyTabLabel(n)
	  let buflist = tabpagebuflist(a:n)
	  let winnr = tabpagewinnr(a:n)
	  let buffername = bufname(buflist[winnr - 1])
    let filename = fnamemodify(buffername, ':t')
    if filename == ''
        let filename = 'noname'
    endif
    "Only show the first 18 letters of  the name and
    ".. if the filename is more than 20 letters long
    let ret = ''
    let ret = matchstr (filename, ".[^.]*")
    if strlen(ret) >= 16
        let ret = ret[0:15].'..'
    endif
    for bufnr in buflist
        if getbufvar(bufnr, "&modified")
          let ret = '!'.ret
          break
        endif
    endfor
    return ret
	endfunction

set tabline=%!MyTabLine()

" Tag les classes de pvxcore
set tag=~/sandboxes/PvxCoreApplication/tags
let Tlist_Exit_OnlyWindow=1

" Surligne les espaces de fin de ligne
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" Copier/coller avec souris
function! Paste(...)
    if (exists ("a:1"))
        if a:1 == "on"
            let b:fo = &formatoptions
            let b:ai = &autoindent
            let b:si = &smartindent
            exe ':set formatoptions='
            exe ':set noautoindent'
            exe ':set nosmartindent'
            echo "autoformatting disabled: you can safely mouse-paste"
        elseif a:1 == "off"
            exe ':set formatoptions='.b:fo
            if b:ai == 1
                exe ':set autoindent'
            endif
            if b:si == 1
                exe ':set smartindent'
            endif
            echo 'autoformatting options restored'
        endif
    else
        echo 'usage: :Paste on|off'
    endif
endfunction
:com! -nargs=* Paste call Paste()


" ===============================================================================================
"                                      HOTKEYS
" ===============================================================================================
map <F2> :source ~/.vimrc<CR>    " Recharge configuration vim
map <F3> :s/^/#<CR>    " Commente le bloc sélectionné
map <F4> :s/^#//<CR>  " Décommente le bloc sélectionné
map <F5> :set paste!<Bar>set paste?<CR>
map <F6> :set number!<Bar>set number?<CR>
map <F7>  :%s/  *$//<CR>
noremap <silent> <F8> :TlistToggle<CR>  " Open class navigator
map <silent> <F9> "<Esc>:match ErrorMsg '\%>80v.\+'<CR>" " sur pression de la touche F3 highlight les charactères qui dépassent la 80ème colonne
map <M-Left> gT
map <M-Right> gt
map <M-Up> :tabnew<CR>:tabm<CR>:e
command! SQ silent :mksession! ~/.vim/session.vim | :wqa    " Met en session et quitte tous les buffers
"command! -nargs=+ G :tabe | :GitGrep <q-args>

noremap <C-k> <C-E>  " Déplace 1/2 écran vers le haut
noremap <C-j> <C-Y>  " Déplace 1/2 écran vers le bas
noremap <M-K> <C-U>  " Déplace 1/2 écran vers le haut
noremap <M-J> <C-D>  " Déplace 1/2 écran vers le bas

imap ,ppr  from pprint import pprint<CR>pprint()<Esc>i
imap ,pgr  print '\033[1;42m',  , '\033[1;m'<Esc>12hi
imap ,pre  print '\033[1;41m',  , '\033[1;m'<Esc>12hi
imap ,pbr  print '\033[1;43m',  , '\033[1;m'<Esc>12hi
imap ,pbl  print '\033[1;44m',  , '\033[1;m'<Esc>12hi
imap ,pma  print '\033[1;45m',  , '\033[1;m'<Esc>12hi
imap ,pcy  print '\033[1;46m',  , '\033[1;m'<Esc>12hi
imap ,pgr  print '\033[1;47m',  , '\033[1;m'<Esc>12hi
imap ,pdb  import pdb; pdb.set_trace()
imap ,hea  # -*- coding: UTF-8 -*-<CR><CR># Import from standard library<CR><CR># Import from Zope<CR><CR># Import from PvxCoreApplication<CR><CR><CR>from Products.PvxCoreApplication.PvxFactory import parser_module_pour_creer_arbre_architectural<CR>parser_module_pour_creer_arbre_architectural(__name__)
imap ,gpdb import pdb, sys; pdb.Pdb(stdin=getattr(sys,'__stdin__'),stdout=getattr(sys,'__stderr__')).set_trace(sys._getframe().f_back)


" ===============================================================================================
"                                      SETUP
" ===============================================================================================
" sudo apt-get install vim-gnome


" ===============================================================================================
"                                      PLUGINS
" ===============================================================================================
"
" Installer vimball
"   1. vim tail-03.vba
"   2. :so %

" ==> Zenburn :
"    * Fonction : colorsheme
"    * Url : http://www.vim.org/scripts/script.php?script_id=415

" ==> Taglist : menu de navigation de la classe courante
"    * Fonction : rajoute sur la gauche de l'écran un menu de navigation de la classe courante
"    * URL : http://sourceforge.net/project/showfiles.php?group_id=181103
"    * Installation :
"         - Décompresser le plugin dans ~/.vim
"         - $ cd ~/.vim/doc
"         - $ vim
"         - :helptags .

" ==> Pyflakes
"    * Fonction : Vérifie syntaxe python
"    * URL : http://www.vim.org/scripts/script.php?script_id=2441
"    * Installation :
"         - Décompresser le plugin dans le répertoire ~/.vim/after/ftplugin/python
"         - Ajouter dans le fichier .vimrc la ligne suivante : filetype plugin indent on
"         OU
"         - Récupérer et déposer la dernière version de pyflakes.vim (http://github.com/kevinw/pyflakes-vim)
"           dans ~/.vim/after/ftplugin/python
"         - Déposer la dernière version du module pyflakes (http://github.com/kevinw/pyflakes)
"           dans /urs/lib/python2.6/dist_packages/ --> *** version plus rapide ***

" ==> Align
"    * Fonction : Alignement du texte
"    * URL : http://www.vim.org/scripts/script.php?script_id=294

" ==> NERDTree
"    * Fonction : Exploreur de filesystem
"    * URL : http://www.vim.org/scripts/script.php?script_id=1658
"    * Installation :
"         - Décompresser le plugin dans ~/.vim"

" ==> GetLatestVimScripts
"    * Fonction : Mise à jour plugins vim
"    * URL : http://www.vim.org/scripts/script.php?script_id=642
"

" ==> Git-vim
"    * Fonction : Commandes git sous vim
"    * URL : http://github.com/motemen/git-vim
"    * Installation :
"         - $ cd ~/.vim
"         - $ git clone git://github.com/motemen/git-vim.git

" ===============================================================================================
"                                     HELP
" ===============================================================================================

" ==> TAG
"   Tag stack
"   * :tj / --> Recherche le tag après le /
"   * :po --> Revenir à l'écran précédent
