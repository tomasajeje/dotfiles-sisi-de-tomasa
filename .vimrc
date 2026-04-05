" --- 1. CONFIGURACIÓN BASE ---
syntax on
set termguicolors

" --- 2. COLORES SIMPLES Y ELEGANTES (Sin ruidos verdes/amarillos) ---
" Texto normal: Blanco hueso limpio
highlight Normal       guifg=#d1d1d1 guibg=NONE ctermbg=NONE
" Comentarios: Gris oscuro apagado
highlight Comment      guifg=#545454 gui=italic ctermfg=240
" Strings y Constantes: Azul acero mate
highlight Constant     guifg=#7aa2f7 ctermfg=111
" Comandos y Palabras clave: Púrpura sobrio
highlight Statement    guifg=#bb9af7 ctermfg=176
" Identificadores y Funciones: Blanco (mismo que el texto para no saturar)
highlight Identifier   guifg=#d1d1d1 ctermfg=252
highlight Function     guifg=#d1d1d1 ctermfg=252
" Tipos y Especiales: Azul ceniza
highlight Type         guifg=#89ddff ctermfg=117
highlight Special      guifg=#89ddff ctermfg=117

" --- 3. RESALTADO DE LÍNEA SUAVE ---
set cursorline
" Gris azulado muy profundo, casi imperceptible
highlight CursorLine   guibg=#1e222a gui=NONE cterm=NONE
highlight LineNr       guifg=#3b4261 guibg=NONE ctermfg=239

" --- 4. TRANSPARENCIA TOTAL ---
function! TransparentBackground()
    highlight Normal     guibg=NONE ctermbg=NONE
    highlight NonText    guibg=NONE ctermbg=NONE
    highlight LineNr     guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
endfunction

autocmd VimEnter,ColorScheme * call TransparentBackground()

" --- 1. ESTÉTICA ---
set shortmess+=I
set laststatus=0
set nonumber
hi Normal ctermbg=NONE

" --- 2. PANTALLA DE INICIO ---
function! StartScreen()
    if argc() == 0
        " Tu logo actual ajustado para que Vim no lo rompa
        let l:logo = [
        \ '  _        _  _____   __     __ ',
        \ '  \ \    / / |_   _| |  \   /  |',
        \ '   \ \  / /    | |   |   \ /   |',
        \ '    \ \/ /    _| |_  | | \_/ | |',
        \ '     \_ /    |_____| |_|     |_|',
        \ ' ',
        \ ' <-----  A M O R  Y  P A Z ----->',
        \ ' ',
        \ '      > i   : empezar a escribir',
        \ '      > :q  : salir de vim',
        \ '      > :wq : guardar y salir',
        \ ' '
        \ ]

        " --- CÁLCULO DE CENTRADO DINÁMICO ---
        let l:pantalla_alto = winheight(0)
        let l:pantalla_ancho = winwidth(0)
        let l:logo_alto = len(l:logo)
        " Medimos el largo de la línea más larga del logo
        let l:logo_ancho = 40 

        " Cálculo para el medio exacto
        let l:relleno_v = (l:pantalla_alto / 2) - (l:logo_alto / 2)
        let l:lineas = repeat([''], l:relleno_v)

        " Centrado horizontal con espacios
        let l:margen_h = repeat(' ', (l:pantalla_ancho / 2) - (l:logo_ancho / 2))
        for l:linea in l:logo
            call add(l:lineas, l:margen_h . l:linea)
        endfor

        call setline(1, l:lineas)

        " --- CONFIGURACIÓN DEL BUFFER ---
        setlocal buftype=nofile
        setlocal bufhidden=wipe
        setlocal noswapfile
        setlocal nomodifiable

        " Desaparecer al presionar i
        nnoremap <buffer> <silent> i :enew<Bar>startinsert<CR>
    endif
endfunction

autocmd VimEnter * call StartScreen()
